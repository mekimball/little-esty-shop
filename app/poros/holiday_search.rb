require 'faraday'
require_relative 'holiday'
require_relative 'holiday_service'

class HolidaySearch
  def holiday_information
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  def service
    HolidayService.new
  end
end