void mvcController() {
  final duckSimulator = DuckSimulator();
  duckSimulator.simulate();
}

abstract class QuackObservable {
  void registerObserver(QuackObserver observer);
  void notifyObservers();
}

abstract class QuackObserver {
  void notify(Quackable quackable);
}

class Quackologist implements QuackObserver {
  @override
  void notify(Quackable quackable) {
    print('${quackable.runtimeType} 오리가 QuackQuack');
  }
}

class QuackObservableImpl implements QuackObservable {
  final List<QuackObserver> observers = [];
  final Quackable quackable;

  QuackObservableImpl(this.quackable);

  @override
  void notifyObservers() {
    for (final QuackObserver observer in observers) {
      observer.notify(quackable);
    }
  }

  @override
  void registerObserver(QuackObserver observer) {
    observers.add(observer);
  }
}

class DuckSimulator {
  AbstractDuckFactory duckFactory = CountingDuckFactory();

  void simulate() {
    final QuackObserver quackologist = Quackologist();

    final Flock ducks = Flock()
      ..addAll([
        duckFactory.createMallardDuck(),
        duckFactory.createRedHeadDuck(),
        duckFactory.createDuckCall(),
        duckFactory.createRubberDuck(),
        GooseAdapter(Goose()),
      ])
      ..registerObserver(quackologist);

    final Flock mallacDucks = Flock()
      ..addAll(
        [
          duckFactory.createMallardDuck(),
          duckFactory.createMallardDuck(),
          duckFactory.createMallardDuck(),
          duckFactory.createMallardDuck(),
          duckFactory.createMallardDuck(),
          duckFactory.createMallardDuck(),
        ],
      )
      ..registerObserver(quackologist);

    print('오리 시뮬레이션');

    _simulate(ducks);
    _simulate(mallacDucks);
  }

  void _simulate(Quackable quackable) {
    quackable.quack();
  }
}

abstract class Quackable extends QuackObservable {
  void quack();
}

class MallardDuck implements Quackable {
  late QuackObservable observable;

  MallardDuck() {
    observable = QuackObservableImpl(this);
  }

  @override
  void quack() {
    print('꽥꽥');
    notifyObservers();
  }

  @override
  void notifyObservers() {
    observable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    observable.registerObserver(observer);
  }
}

class RedHeadDuck implements Quackable {
  late QuackObservable observable;

  RedHeadDuck() {
    observable = QuackObservableImpl(this);
  }

  @override
  void quack() {
    print('꽥꽥');
    notifyObservers();
  }

  @override
  void notifyObservers() {
    observable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    observable.registerObserver(observer);
  }
}

class DuckCall implements Quackable {
  late QuackObservable observable;

  DuckCall() {
    observable = QuackObservableImpl(this);
  }

  @override
  void quack() {
    print('꽉꽉');
    notifyObservers();
  }

  @override
  void notifyObservers() {
    observable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    observable.registerObserver(observer);
  }
}

class RubberDuck implements Quackable {
  late QuackObservable observable;

  RubberDuck() {
    observable = QuackObservableImpl(this);
  }

  @override
  void quack() {
    print('삑삑');
    notifyObservers();
  }

  @override
  void notifyObservers() {
    observable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    observable.registerObserver(observer);
  }
}

class Goose {
  void honk() {
    print('끽끽');
  }
}

///[GooseAdapter] 어댑터 패턴
class GooseAdapter implements Quackable {
  Goose goose;

  late QuackObservable observable;

  GooseAdapter(this.goose) {
    observable = QuackObservableImpl(this);
  }

  @override
  void quack() {
    goose.honk();
    notifyObservers();
  }

  @override
  void notifyObservers() {
    observable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    observable.registerObserver(observer);
  }
}

///[QuackakbleCounter] 어댑터 패턴
class QuackableCounter implements Quackable {
  Quackable quackable;
  QuackableCounter(this.quackable);

  static int count = 0;

  @override
  void quack() {
    countQuack();
    quackable.quack();
  }

  void countQuack() {
    count++;
  }

  @override
  void notifyObservers() {
    quackable.notifyObservers();
  }

  @override
  void registerObserver(QuackObserver observer) {
    quackable.registerObserver(observer);
  }
}

abstract class AbstractDuckFactory {
  Quackable createMallardDuck();
  Quackable createRedHeadDuck();
  Quackable createDuckCall();
  Quackable createRubberDuck();
}

class DuckFactory extends AbstractDuckFactory {
  @override
  Quackable createMallardDuck() {
    return MallardDuck();
  }

  @override
  Quackable createRedHeadDuck() {
    throw RedHeadDuck();
  }

  @override
  Quackable createDuckCall() {
    throw DuckCall();
  }

  @override
  Quackable createRubberDuck() {
    throw RubberDuck();
  }
}

class CountingDuckFactory extends AbstractDuckFactory {
  @override
  Quackable createMallardDuck() {
    return QuackableCounter(MallardDuck());
  }

  @override
  Quackable createRedHeadDuck() {
    return QuackableCounter(RedHeadDuck());
  }

  @override
  Quackable createDuckCall() {
    return QuackableCounter(DuckCall());
  }

  @override
  Quackable createRubberDuck() {
    return QuackableCounter(RubberDuck());
  }
}

class Flock implements Quackable {
  List<Quackable> quackers = [];

  void add(Quackable quackable) {
    quackers.add(quackable);
  }

  void addAll(List<Quackable> quackableList) {
    quackers.addAll(quackableList);
  }

  @override
  void quack() {
    for (var element in quackers) {
      element.quack();
    }
  }

  @override
  void registerObserver(QuackObserver observer) {
    for (final quacker in quackers) {
      quacker.registerObserver(observer);
    }
  }

  @override
  void notifyObservers() {}
}
