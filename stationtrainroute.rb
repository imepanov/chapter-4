class Station
attr_reader :type, :trains, :name_of_station
  def initialize(name_of_station)
    @name_of_station = name_of_station.to_s
  end

  def arrived(train)
    @trains ||= []
    @trains << train
  end

  def full_list
    puts "Список всех поездов на станции: #{@trains}"
  end

  def left(train)
    @trains.delete(train)
  end

  def type_of_trains(by_type)
    @trains.select { |train| train.type == by_type }
  end
end


class Route
  attr_reader :current_route, :trains, :stations
  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [start, finish]
  end

  def assign_the_route
    @start
  end

  def push_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def full_station_list
    @stations
  end

end

class Train
  attr_accessor :speed
  attr_reader :start, :finish, :stations, :current_route, :type, :trains, :name_of_station
  def initialize(number_of_train, type, qnt_railway_carriage)
    @number_of_train = number_of_train.to_s
    @type = 'pass' or 'cargo'
    @qnt_railway_carriage = qnt_railway_carriage.to_s
    @train_position = 0
    @current_route = []
  end

  def brake
    @speed = 0
  end

  def see_qnt_railway_carriage
    puts "количество вагонов: #{@qnt_railway_carriage}"
  end
  def increase_qnt_railway_carriage
    if @speed == 0
      @qnt_railway_carriage += 1
    end
  end

  def reduce_qnt_railway_carriage
    if @speed == 0
      @qnt_railway_carriage -= 1
    end
  end

  def current_route(route)
    @current_route = route
    @current_index = 0
    @current_station = @current_route.full_station_list[0]
    @current_station.arrived(self)
  end

  def current_station
    @current_station = current_route.stations.each do |station|
      return station if station.trains.include?(self)
    end
  end

  def next_station
    @go_forward = @current_route.full_station_list[(@current_index + 1)]
  end

  def previous_station
    @go_back = @current_route.full_station_list[(@current_index - 1)]
  end

  def go_next_station
    @current_station.left(self)
    @current_station = next_station
    @current_station.arrived(self)
  end

  def go_back_station
    @current_station.left(self)
    @current_station = previous_station
    @current_station.arrived(self)
  end

end
