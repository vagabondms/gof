void observerPattern() async {
  print('observerPattern');

  final WeatherData weatherData = WeatherData();

  final currentConditionDisplay = CurrentConditionDisplay(weatherData);
  final statisticsDisplay = StatisticsDisplay(weatherData);
  final forecastDisplay = ForecastDisplay(weatherData);

  await Future.delayed(
      Duration(seconds: 1), () => weatherData.setMeasurements(1, 1, 1));
  await Future.delayed(
      Duration(seconds: 1), () => weatherData.setMeasurements(2, 2, 2));
  await Future.delayed(
      Duration(seconds: 1), () => weatherData.setMeasurements(3, 3, 3));
}

abstract class Subject {
  removeObserver(Observer observer);
  registerObserver(Observer observer);
  notifyObservers();
}

abstract class Observer {
  update();
}

abstract class Display {
  display();
}

class WeatherData implements Subject {
  final List<Observer> observers = [];
  int temperature = 0;
  int humidity = 0;
  int pressure = 0;

  @override
  registerObserver(Observer observer) {
    observers.add(observer);
  }

  @override
  removeObserver(Observer observer) {
    observers.remove(observer);
  }

  @override
  notifyObservers() {
    for (final observer in observers) {
      observer.update();
    }
  }

  int getTemperature() {
    return temperature;
  }

  int getHumidity() {
    return humidity;
  }

  int getPressure() {
    return pressure;
  }

  void setMeasurements(int temperature, int humidity, int pressure) {
    this.temperature = temperature;
    this.humidity = humidity;
    this.pressure = pressure;
    notifyObservers();
  }
}

class CurrentConditionDisplay implements Observer, Display {
  int temperature = 0;

  WeatherData weatherData;

  CurrentConditionDisplay(this.weatherData) {
    weatherData.registerObserver(this);
  }

  @override
  display() {
    print(runtimeType);
    print('temperature: $temperature');
  }

  @override
  update() {
    temperature = weatherData.getTemperature();
    display();
  }
}

class StatisticsDisplay implements Observer, Display {
  int humidity = 0;

  WeatherData weatherData;

  StatisticsDisplay(this.weatherData) {
    weatherData.registerObserver(this);
  }

  @override
  display() {
    print(runtimeType);
    print('humidity: $humidity');
  }

  @override
  update() {
    humidity = weatherData.getHumidity();
    display();
  }
}

class ForecastDisplay implements Observer, Display {
  int pressure = 0;
  WeatherData weatherData;

  ForecastDisplay(this.weatherData) {
    weatherData.registerObserver(this);
  }

  @override
  display() {
    print(runtimeType);
    print('pressure: $pressure');
  }

  @override
  update() {
    pressure = weatherData.getPressure();
    display();
  }
}
