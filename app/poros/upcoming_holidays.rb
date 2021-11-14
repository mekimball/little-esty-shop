require 'faraday'
require 'json'
require_relative 'holiday'
require_relative 'holiday_search'

search = HolidaySearch.new
search.holiday_information[0..2].each do |holiday|
  puts holiday.date
  puts holiday.name
end
