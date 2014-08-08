require './lib/line'
require './lib/station'
# require './train_station_ui'

def conductor_menu
  system('clear')
  image
  puts "S > Add a station"
  puts "L > Add a line"
  puts "DS > Delete a station"
  puts "DL > Delete a line"
  if Station.all != [] and Line.all != []
    puts "CS > Connect a station to a line"
    puts "CL > Connect a line to a station"
  end
  puts "M > Main menu"
  case gets.chomp.upcase
  when 'S'
    station_menu
  when 'L'
    line_menu
  when 'CS'
    station_to_line
  when 'CL'
    line_to_station
  when 'DS'
    delete_station
  when 'DL'
    delete_station
  when 'M'
    menu
  end
end

def station_to_line
  system('clear')
  image
  puts ""
  puts "Which station are you connecting? (Enter number)"
  view_stations
  station_choice = gets.chomp.to_i
  if station_choice == 0
    trippin
  else
    @current_station = Station.all[station_choice - 1]
  end
  puts "Which line do you want to connect it to? (Enter number)"
  view_lines
  line_choice = gets.chomp.to_i
  if line_choice == 0
    trippin
  else
    @current_line = Line.all[line_choice - 1]
    if stop_dupe?
      puts "#{@current_station.name} and #{@current_line.name} are already connected!"
      sleep 2
      station_to_line
    else
      @current_line.add_station(@current_station)
      puts "#{@current_station.name} added to #{@current_line.name}!"
      sleep 2
      conductor_menu
    end
  end
end

def line_to_station
  system('clear')
  image
  puts ""
  puts "Which line are you connecting? (Enter number)"
  view_lines
  line_choice = gets.chomp.to_i
  if line_choice == 0
    trippin
  else
    @current_line = Line.all[line_choice - 1]
  end
  puts "Which station do you want to connect it to? (Enter number)"
  view_stations
  station_choice = gets.chomp.to_i
  if station_choice == 0
    trippin
  else
    @current_station = Station.all[station_choice - 1]
    if stop_dupe?
      puts "#{@current_line.name} and #{@current_station.name} are already connected!"
      sleep 2
      line_to_station
    else
      @current_station.add_line(@current_line)
      puts "#{@current_line.name} added to #{@current_station.name}!"
      sleep 2
      conductor_menu
    end
  end
end

def station_menu
  puts "What's the station name?"
  name = gets.chomp
  if station_dupe?(name)
    puts "Station already exists!"
    sleep 1
    station_menu
  else
    create_station(name)
  end
end

def line_menu
  puts "What's the line name?"
  name = gets.chomp
  if line_dupe?(name)
    puts "line already exists!"
    sleep 1
    line_menu
  else
    create_line(name)
  end
end

def create_line(name)
  @new_line = Line.new({:name => name})
  @new_line.save
  puts "Line created!"
  sleep 2
  conductor_menu
end

def create_station(name)
  @current_station = Station.new({:name => name})
  @current_station.save
  puts "Station created!"
  sleep 2
  conductor_menu
end

def delete_station
  puts "Which station would you like to delete?"
  view_stations
  choice = gets.chomp
  if choice == 0
    trippin
  else
    Station.all[choice -1].delete
    puts "That bitch is GONE"
    sleep 2
  end
end

def delete_line
  puts "Which station would you like to delete?"
  view_lines
  choice = gets.chomp.to_i
  if choice == 0
    trippin
  else
    Station.all[choice -1].delete
    puts "That bitch is GONE"
    sleep 2
  end
end

def station_dupe?(input)
  output = false
  Station.all.each do |station|
    if station.name == input
      output = true
    end
  end
  output
end

def line_dupe?(input)
  output = false
  Line.all.each do |line|
    if line.name == input
      output = true
    end
  end
  output
end

def stop_dupe?
  result = DB.exec("SELECT * FROM stops WHERE station_id = #{@current_station.id} AND line_id = #{@current_line.id};").first
  if result != nil
    true
  else
    false
  end
end

def view_stations
  puts "STATIONS"
  Station.all.each_with_index do |station, i|
    puts "#{i + 1} " + "#{station.name}"
  end
end

def view_lines
  puts "LINES"
  Line.all.each_with_index do |line, i|
    puts "#{i + 1} " + "#{line.name}"
  end
end

def trippin
  puts "You're tripping."
  sleep 2
  menu
end

def self.image
puts "
                               ______
                            .-````.._'.       _,##
                     _..__ |.-```-.|  |   _,##'`-._
                    (_____)||_____||  |_,##'`-._,##'`
                    _|   |.;-``-.  |  |#'`-._,##'`
                 _.;_ `--' `\    \ |.'`\._,##'`
                /.-.\ `\     |.-`;.`_, |##'`
                |\__/   | _..;__  |'-' /
                '.____.'_.-`)\--' /'-'`
                 //||\\(_.-'_,'-'`
               (`-...-')_,##'`
            _,##`-..,-;##`
         _,##'`-._,##'`
      _,##'`-._,##'`
        `-._,##'`

"
end
puts image
