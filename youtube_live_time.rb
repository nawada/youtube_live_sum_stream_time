require 'time'
require 'csv'

def readCsv
  Dir.glob('./data/*.csv').map { |path|
    csv = CSV.read(path)
    start_str = csv[0][3]
    end_str = csv[0][5]
    {start: start_str, end: end_str}
  }
end

def str2Date(str)
  Time.parse(str)
end

def getMonthName(time)
  case time.month
  when 1
    'Jan'
  when 2
    'Feb'
  when 3
    'Mar'
  when 4
    'Apr'
  when 5
    'May'
  when 6
    'Jun'
  when 7
    'Jul'
  when 8
    'Aug'
  when 9
    'Sep'
  when 10
    'Oct'
  when 11
    'Nov'
  when 12
    'Dec'
  end
end

def sec2Time(_sec)
  sec = _sec
  h = 60 * 60
  m = 60
  hour = (sec / h).floor
  sec %= h
  minute = (sec / m).floor
  sec %= m
  puts format('%02d:%02d:%02d', hour, minute, sec)
end

def csv2HashArray(csv_data)
  data = {}
  csv_data.each { |csv|
    start_time = str2Date(csv[:start])
    end_time = str2Date(csv[:end])

    month_name = getMonthName(start_time)
    if data[month_name.to_s].nil?
      data[month_name.to_s] = []
    end

    data[month_name].push({start: start_time, end: end_time})
  }
  data
end

def putsMonthlyLiveHour(monthly_data)
  monthly_data.each do |key, value|
    print key.to_s + ': '

    month_sec = 0
    value.each do |obj|
      month_sec += obj[:end] - obj[:start]
    end

    sec2Time(month_sec)
  end
end

csv_data = readCsv
data = csv2HashArray(csv_data)
putsMonthlyLiveHour(data)
