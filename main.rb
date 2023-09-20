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
	3 - Создать маршруты и управлять станциями в нем (добавлять, удалять)
	4 - Назначать маршрут поезду
	5 - Добавлять вагоны к поезду, отцеплять вагоны
	6 - Перемещать поезд по маршруту вперед и назад
	7 - Просматривать список станций
	8 - Просматривать список поездов
	9 - Выйти из меню
	"
end

def list(ch)
	create_station if ch == "1"
	create_train if ch == "2"
	create_management_stations if ch == "3"
	assign_route if ch == "4"
	management_wagon if ch == "5"
	move_train if ch == "6"
	show_stations if ch == "7"
	show_trains if ch == "8"
end


def create_station
	puts "Создать станцию"
	name = gets.chomp
	station = Station.new(name)
	@stations << station
	puts "Создана новая станция #{name}"
end

def create_train 
	puts "Создание нового поезда"
	num = gets.chomp
	puts "Выберите тип поезда"
	puts "Тип поезда
		0 - Грузовой
		1 - Пассажирский"
	type = gets.chomp
	train = type == "0"? Cargotrain.new(num) : Passengertrain.new(num)
	@trains << train
	puts "Создан новый поезд #{train.inspect} номер #{train.num}"
end

def assign_route
    puts "Управление маршрутами

            1 - Создать маршрут
            2 - Добавить станцию в существующем маршруте
            3 - Удалить станцию в существующем маршруте"

    num_route = gets.chomp
    create_route if num == "1"
    add_station_in_route if num == "2"
    delete_station if num == "3"
 end

def create_management_stations 
	puts "Создание маршрутов"
	first_station = gets.chomp
	finish_station = gets.chomp
	route = Route.new(first_station, finish_station)
	@routes << route
	puts "Новый маршрут #{route.inspect} создан"
end

def add_station_in_the_route
	puts "Добавление станции"
	@stations.each_with_index {|element, index|
	puts "Станция - #{element.name} - индекс - #{index}"}
	station = @stations[gets.chomp.to_i]

	puts "Добавление маршрута"
	@routes.each_with_index {|element, index|
	puts "Маршрут - #{element.inspect}, индекс - #{index}"}
	route = @routes [gets.chomp.to_i]
	route.add_station(station)
	puts "Станция #{station.name} добавлена в маршрут #{route.inspect}"
end

def delete_station
	puts "Выбор удаляемой станции"
	@stations.each_with_index {|element, index|
	puts "Станция - #{element}, индекс - #{index}"}
	station = @stations[gets.chomp.to_i]
	puts "Выбор удаляемого маршрута"
	@route.each_with_index {|element, index|
	puts "Маршрут - #{element}, индекс - #{index}"}
	route = @routes[gets.chomp.to_i]
end

def assign_route
	puts "Назначение маршрута поезда"
	@trains.each_with_index {|element, index|
	puts "Поезд - #{element}, индекс - #{index}"}
	train = @trains[gets.chomp.to_i]
	puts "Выбор маршрута поезда"
	@routes.each_with_index {|element, index|
	puts "Маршрут - #{element}, индекс - #{index}"}
	route = @routes[gets.chomp.to_i]
end

def management_wagon
	puts "Управление вагонами"
	puts "0 - Создание вагона"
	     "1 - Добавить вагон"
	     "2 - Отцепить вагон"
	 	num = gets.chomp

	 create_wagon if num == "0"

	 if num == "1"
	 	puts "Добавить поезд к которому добавим вагон"
	 	@trains.each_with_index {|element, index| puts "Поезд - #{element.num}, индекс - #{index}"}
	 	train = @trains[gets.chomp.to_i]
	 	add_wagon(train)
	 end

	 if num == "2"
	 	puts "Отцепить вагон от поезда"
	 	@trains.each_with_index {|element, index| puts "Поезд - #{element.num}, индекс - #{index}"}
	 	train = @trains[gets.chomp.to_i]
	 	delete_wagon(train)
	 end
end

def move_train
    puts "Вы зашли в отдел управления движениями. Выберите поезд по индексу для управления его движением"
    @trains.each_with_index{|item, index| puts "индекс - #{index} - поезд -  #{item.num}"}
    train = @trains[gets.chomp.to_i]
    puts "Выберите действие, которое хотите осуществить"
    puts """
         1 - Ехать вперед
         2 - Сдать назад
        """
    num = gets.chomp
    num == 1? train.go_next_station : train.go_previous_station
    puts "Поезд #{train.num} переместился со станции #{train.previous_station.name} на станцию #{train.current_station}" if num == "1"
    puts "Поезд #{train.num} переместился со станции #{train.current_station} на станцию #{train.previous_station.name}" if num == "2"
  end

def show_stations
	puts "Показ станций"
	@stations.each {|i| puts "Станция - #{i.name}"}
		puts "Наименование станции #{name}"
end 

def show_trains
	puts "Показ поездов на станциях"
	@stations.each_with_index {|element, index| 
		puts "Поезд - #{element.name}, индекс - #{index}"}
	station = @stations[gets.chomp.to_i]
	station.trains.each{|train| puts "Номер поезда - #{train.num}"}
end
end

foo = Main.new
foo.start







