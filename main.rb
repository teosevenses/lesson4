require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Main

	def initialize
		@wagons = []
		@trains = []
		@routes = []
		@stations = []
	end

	def start 
		puts "Управление поездами"
    	loop do
    		menu 
    		choice = gets.chomp
    		break if choice == "9"
    		list(choice)
    	end		
	end

	private 

	attr_reader :trains, :stations, :routes, :wagons

	def menu 
		puts "
		1 - Создать станцию
		2 - Создать поезда
		3 - Создать маршруты
		4 - Добавить станцию на маршрут
		5 - Удалить станцию с маршрута
		6 - Список маршрутов
		7 - Просматривать список станций
		8 - Просматривать список поездов
		9 - Выйти из меню
		"
	end

	def list(choice)
		if choice == "1"
			create_station
		elsif choice == "2"
			create_train
		elsif choice == "3"
			create_route
		elsif choice == "4"
			add_route
		elsif choice == "5"
			delete_route
		elsif choice == "6"
			list_routes
		elsif choice == "7"
			list_stations
		elsif choice == "8"
			trains.each do |x|
				puts "Номер поезда #{x.num}, тип поезда #{x.type}" 
			end
	end
		
	end

	def create_station
		puts "Введите название станции"
		name = gets.chomp
		station = Station.new(name)
		puts "Произошло создание станции #{name}"
		stations << station
	end

	def create_train
		puts "Введите тип поезда
				0 - Грузовой
				1 - Пассажирский"
		type = gets.chomp
		num = trains.count + 1
		if type == "0" 
			train = CargoTrain.new(num)
			puts "Создан грузовой поезд"
			trains << train
		elsif type == "1"
			train = PassengerTrain.new(num)
			puts "Создан пассажирский поезд"
			trains << train
		else 
			puts "Ошибка"
		end
	end


	def list_stations
		puts "Список станций"
		stations.each_with_index do |x, y| 
			puts "#{y}. #{x.name}"
		end

	end 
 	
 	def create_route
 		puts "Выберите начальную станцию по номеру из списка ниже"
 		list_stations
 		input = gets.chomp
 		start_station = stations[input.to_i]
 		puts "Выберите конечную станцию по номеру из списка ниже"
 		list_stations
 		second_input = gets.chomp
 		finish_station = stations[second_input.to_i]
 		route = Route.new(start_station, finish_station)
 		puts "Создан маршрут поезда"
 		routes << route
 	end
 	
 	def list_routes
 		puts "Список маршрутов"
 		routes.each_with_index do |x, y|
 			puts "#{y} #{x.readable_stations}"
 		end
 	end

 	def add_route
 		puts "Выберите станцию и маршрут"
 		list_routes
 		input = gets.chomp
 		route = routes[input.to_i]

 		list_stations
 		second_input = gets.chomp
 		station = stations[second_input.to_i]
 		route.add_station(station)
 		puts "Выбранная станция добавлена в маршрут"
 	end

 	def delete_route
 		puts "Выберите станцию и маршрут"

		list_routes
 		input = gets.chomp
 		route = routes[input.to_i]

 		list_stations
 		second_input = gets.chomp
 		station = stations[second_input.to_i]
 		
		if route.stations.include?(station)
     	route.delete_station(station)
     	puts "Выбранная станция удалена из маршрута"
  	 	else
    	puts "Выбранная станция не найдена в выбранном маршруте"
   	end
   	
   	end
end

f = Main.new
f.start
