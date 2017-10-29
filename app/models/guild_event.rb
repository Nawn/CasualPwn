class GuildEvent < ApplicationRecord
	before_save :combine_date_time

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
		@start_time_time = Time.zone.parse(time).getutc.strftime("%H:%M:%S")
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
		@end_time_time = Time.zone.parse(time).getutc.strftime("%H:%M:%S")
	end

	def end_time_date=(date)
		puts "Setting End Date"
		@end_time_date = Date.parse(date).strftime("%Y-%m-%d")
	end

	def combine_date_time
		puts "Combining Start Times to DateTime"
		puts "Start Date: #{@start_time_date} Start Time: #{@start_time_time}"
		puts "End Date: #{@end_time_date} End Time: #{@end_time_time}"
		self.start_time = DateTime.parse("#{@start_time_date} #{@start_time_time}")
		self.end_time = DateTime.parse("#{@end_time_date} #{@end_time_time}")
	end

end
