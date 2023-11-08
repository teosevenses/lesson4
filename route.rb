
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
    @stations.delete(station)
  end

  def readable_stations
      stations.map { |x| x.name }.join("-")
  end

end
