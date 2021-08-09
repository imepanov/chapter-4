class Station
attr_reader :type, :trains, :name_of_station, :stations, :start, :finish, :current_index, :next_station, :previous_station
  def initialize(name_of_station)
    @name_of_station = name_of_station
    @trains = []
  end

  def arrived(train)
    @trains << train
  end

  def left(train)
    @trains.delete(train)
  end

  def type_of_trains(by_type)
    @trains.select { |train| train.type == by_type }
  end
end


class Route
  attr_reader :current_route, :trains, :stations, :name_of_station, :current_index
  def initialize(start, finish)
    @stations = [start, finish]
  end

  def push_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

end

class Train
  attr_accessor :speed, :trains
  attr_reader :stations, :current_route, :number_of_train, :type, :name_of_station, :qnt_railway_carriage, :current_index
  def initialize(number_of_train, type, qnt_railway_carriage)
    @number_of_train = number_of_train
    @type = type
    @qnt_railway_carriage = qnt_railway_carriage
  end

  def brake
    @speed = 0
  end

  def increase_qnt_railway_carriage
    @qnt_railway_carriage += 1 if @speed == 0
  end

  def reduce_qnt_railway_carriage
    @qnt_railway_carriage -= 1 if @speed == 0
  end

  def current_route(route)
    @current_route = route
    @current_index = 0
    current_station.arrived(self)
  end

  def current_station
    @current_route.stations[(@current_index)]
  end

  def next_station
    if @current_index == (@current_route.stations.index(-1))
      puts "end of the route"
      @current_route.stations[-1]
    else
      @current_route.stations[(@current_index += 1)]
    end
  end

  def previous_station
    if @current_index == (@current_route.stations.index(0))
      puts "begin of the route"
      @current_route.stations[0]
    else
      @current_route.stations[(@current_index -= 1)]
    end
  end

  def go_next_station
    current_station.left(self)
    next_station.arrived(self)
  end

  def go_previous_station
    current_station.left(self)
    previous_station.arrived(self)
  end
end
