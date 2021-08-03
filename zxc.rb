class Station
attr_reader :type, :number_of_train
  def initialize(name_of_station)
    @name_of_station = name_of_station
    @train = []
    @type = []
  end

  def arrived(number_of_train)
    @train << number_of_train
    puts "Поезд #{number_of_train} прибыл"
  end

  def full_list
    puts "Список всех поездов на станции: #{@train}"
  end

  def left(number_of_train)
    @train.delete(number_of_train)
    puts "Поезд #{number_of_train} удаляется со станции"
  end

  def type_of_trains(train)
    @type << train
    @type.each { |type| puts "#{@type}"}
  end
end


class Route
  attr_reader :routers
  def initialize(start, finish)
    @start = start
    @finish = finish
    @intermittent = []
    @route = [@start, @intermittent, @finish]
  end

  def push_station(name_of_station)
    @intermittent << name_of_station
  end

  def delete_station(name_of_station)
    @intermittent.delete(name_of_station)
  end

  def full_station_list
    puts "Список всех станций: #{@route}"
  end
end

class Train
  attr_reader :start, :finish, :intermittent
  attr_accessor :speed, :route
  def initialize(number_of_train, type = ["грузовой", "пассажирский"], qnt_railway_carriage)
    @number_of_train = number_of_train
    @type = type
    @qnt_railway_carriage = qnt_railway_carriage
    @routers = []
    @train_position = []
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

  def add_route(route)
     @routers << route
     @train_position << @routers.first
  end

  def train_position_now
    puts "#{@train_position}"
  end

  def go_forward
    @train_position << @routers.rindex
  end

  def go_back
    @train_position << @routers.index
  end

  def train_position
    puts "Поезд находится на станции: #{@train_position}, предыдущая станция: #{@train_position.index}, следующая станция: #{@train_position.rindex}"
  end
end
