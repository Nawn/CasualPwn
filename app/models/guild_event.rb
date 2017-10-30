require "#{Rails.root}/lib/guild_wars_call.rb"

def pull_from_global(tag)
	result = GlobalSetting.find_by(tag: tag)

	if result.nil?
	  return "ERROR: tag #{tag} not found in GlobalSetting"
	else
	  return result.content
	end
end

class GuildEvent < ApplicationRecord
	serialize :roster, Array
	belongs_to :guild_member
	before_validation :combine_date_time
	validates :title, :category, :roster_size, :start_time, :end_time, presence: true
	validates :roster_size, numericality: {only_integer: true, greater_than_or_equal_to: 0}

	def start_time_time
		puts "Sending Start Time"
		self.start_time.strftime("%l:%M %p") if self.start_time.present?
	end

	def start_time_date
		puts "Sending Start Date"
		self.start_time.strftime("%e %B, %Y") if self.start_time.present?
	end

	def start_time_time=(time)
		puts "Setting Start Time"
		@start_time_time = Time.zone.parse(time).strftime("%H:%M:%S")
	end

	def start_time_date=(date)
		puts "Setting Start Date"
		@start_time_date = Date.parse(date).strftime("%Y-%m-%d")
	end

	def end_time_time
		puts "Sending End Time"
		self.end_time.strftime("%l:%M %p") if self.end_time.present?
	end

	def end_time_date
		puts "Sending End Date"
		self.end_time.strftime("%e %B, %Y") if self.end_time.present?
	end

	def end_time_time=(time)
		puts "Setting End Time"
		@end_time_time = Time.zone.parse(time).strftime("%H:%M:%S")
	end

	def end_time_date=(date)
		puts "Setting End Date"
		@end_time_date = Date.parse(date).strftime("%Y-%m-%d")
	end

	def spaces_available
		return "Unlim." if self.roster_size == 0

		return self.roster_size - self.roster.size
	end

	def combine_date_time
		puts "Combining Start Times to DateTime"
		self.start_time = "#{@start_time_date} #{@start_time_time}".in_time_zone(Time.zone.name)
		self.end_time = "#{@end_time_date} #{@end_time_time}".in_time_zone(Time.zone.name)
	end

	def self.update_events
		our_bot = Discord::Bot.new(pull_from_global('discord_token'), pull_from_global('discord_client').to_i)
		
		# The events within 30 minutes that have not been alerted
		send_event_reminders = self.where('start_time > ?', Time.zone.now).where('start_time < ?', Time.zone.now + 30.minutes).where(notice: 0)
		send_event_start = self.where('start_time < ?', Time.zone.now).where('end_time > ?', Time.zone.now).where.not(notice: 2)
		delete_events = self.where('end_time < ?', Time.zone.now - 6.months)

		send_event_reminders.each do |remind_event|
			remind_event.roster.each do |guild_member_id|
				this_user = GuildMember.find(guild_member_id)

				our_bot.message_user(this_user.discord_id, "REMINDER: You are to take part in a Guild Event called #{remind_event.title}, More Information: #{event_link(remind_event)}")
			end

			remind_event.notice = 1
			remind_event.save(validate: false)
		end

		send_event_start.each do |remind_event|

			remind_event.roster.each do |guild_member_id|
				this_user = GuildMember.find(guild_member_id)

				our_bot.message_user(this_user.discord_id, "REMINDER: The event #{remind_event.title} has begun! More information: #{event_link(remind_event)}")
			end

			remind_event.notice = 2
			remind_event.save(validate: false)
		end

		delete_events.destroy_all
	end

	def event_link(guild_event)
		"http://casualpwn.com/guild_events/#{guild_event.id}"
	end
end
