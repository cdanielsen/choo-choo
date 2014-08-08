require './lib/line'
require './lib/station'
require './conductor'

DB = PG.connect({:dbname => 'trains'})

@current_station
@current_line

def menu
  loop do
    system('clear')
    image
    puts "Welcome to Train-o-Matic\n\n"
    puts "Drive?! (choo-choo-choose 1) or RIIIIIIDE (choo-choo-choose 2)\n\n"
    choice = gets.chomp.to_i
    if choice == 1
      conductor_menu
    elsif choice == 2
      rider_menu
    else
      trippin
    end
  end
end

def rider_menu
  system('clear')
  image
  puts "S > View stations"
  puts "L > View lines"
  puts "M > Main menu"
  case gets.chomp.upcase
  when 'S'
    station_map
  when 'L'
    line_map
  when 'M'
    menu
  else
    trippin
  end
end

def station_map
  system('clear')
  image
  puts "Which station would you like to see?"
  view_stations
  station_choice = gets.chomp.to_i
  @current_station = Station.all[station_choice - 1]
  puts "The following lines run through #{@current_station.name}:"
  @current_station.view_lines.each do |line|
    puts "#{line.name}"
  end
  puts "Look at another station? (Y/N)"
  case gets.chomp.upcase
  when 'Y'
    station_map
  when 'N'
    rider_menu
  else
    trippin
  end
end

def line_map
  system('clear')
  image
  puts "Which line would you like to see?"
  view_lines
  line_choice = gets.chomp.to_i
  @current_line = Line.all[line_choice - 1]
  puts "The following lines run through #{@current_line.name}:"
  @current_line.view_stations.each do |station|
    puts "#{station.name}"
  end
  puts "Look at another line? (Y/N)"
  case gets.chomp.upcase
  when 'Y'
    line_map
  when 'N'
    rider_menu
  else
    trippin
  end
end

menu
