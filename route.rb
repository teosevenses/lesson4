
class Route
attr_reader :stations

#создаем маршрут

def initialize(first_station, last_station)
@stations = [first_station, last_station]
end

#добавляем станцию
def add_station(station)
  @stations.insert(-2, station)
end

#удаляем станцию
def delete_station(station)
  @stations.insert(-2, station)
end

#выводим список всех станций
def all_stations
  @stations.each { |station| puts station}
  end
end