class HolidayService
  def holidays
    get_url("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
  
  def get_url(url)
    holidays = Faraday.get(url)
    holiday_parsed = JSON.parse(holidays.body, symbolize_names: true)
  end
end