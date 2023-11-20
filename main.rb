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
    		break if choice == "99"
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
		9 -  Назначать маршрут поезду
		10 - Перемещать поезд по маршруту вперед
		11 - Перемещать поезд по маршруту назад
		99 - Выйти из меню
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
			list_trains
		elsif choice == "9"
			assign_route
		elsif choice == "10"
			move_forward
		elsif choice == "11"
			move_back
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

 		route.list_stations
 		second_input = gets.chomp.to_i
 		deleted_station = route.stations.delete_at(second_input)
 		if deleted_station 
 			puts "Станция #{second_input} #{deleted_station.name} удалена"
 		else
			puts "Станция под номером #{second_input} не найдена"
		end
   	end

   	def assign_route
   		puts "Выбрать маршрут"
   		list_routes
   		input = gets.chomp
   		route = routes[input.to_i]

   		puts "Выбрать поезд"
   		list_trains
   		second_input = gets.chomp.to_i
   		train = trains[second_input]
   		route.trains << train
   		train.route = route
   		train.station = 0
   		puts "Выбранный поезд #{second_input} назначен на выбранный маршрут #{input}"
	end

	def list_trains
 		puts "Список поездов"
 		trains.each_with_index do |x, y|
 			puts "#{y} #{x.type}"
 		end
 	end

 	def move_forward
 		list_trains
 		input = gets.chomp.to_i
 		train = trains[input]
		train.move_forward
		puts "Поезд на следующей станции"
 	end

 	def move_back
 		list_trains
 		input = gets.chomp.to_i
 		train = trains[input]
		train.move_back
		puts "Поезд на предыдщей станции"
	end
end

f = Main.new
f.start







