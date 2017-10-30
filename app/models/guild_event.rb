class GuildEvent < ApplicationRecord
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

		return self.roster_size
	end

	def combine_date_time
		puts "Combining Start Times to DateTime"
		self.start_time = "#{@start_time_date} #{@start_time_time}".in_time_zone(Time.zone.name)
		self.end_time = "#{@end_time_date} #{@end_time_time}".in_time_zone(Time.zone.name)
	end

end
