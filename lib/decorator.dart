void decoratorPattern() async {
  print('decoratorPattern');
  final me = Whip(Mocha(Espresso(size: Size.tall)));
  print(me.cost);
  print(me.description);
}

enum Size { tall, grande, venti }

abstract class Beverage {
  Size get size;
  int get cost;
  String get description;
}

class PriceInfo {
  final int tall;
  final int venti;
  final int grande;

  PriceInfo({
    required this.tall,
    required this.grande,
    required this.venti,
  });

  int getCost(Size size) {
    return size == Size.tall
        ? tall
        : size == Size.grande
            ? grande
            : size == Size.venti
                ? venti
                : 0;
  }
}

abstract class BeverageDecorator extends Beverage {
  final Beverage beverage;
  BeverageDecorator(this.beverage);

  @override
  get size => beverage.size;
}

class Espresso extends Beverage {
  final String _description = '에스프레소';
  final Size _size;
  final PriceInfo priceInfo = PriceInfo(tall: 100, grande: 200, venti: 300);

  Espresso({required Size size}) : _size = size;

  @override
  get size => _size;

  @override
  get cost => priceInfo.getCost(size);

  @override
  get description => _description;
}

class Mocha extends BeverageDecorator {
  final String _description = '모카';
  final PriceInfo priceInfo = PriceInfo(tall: 1, grande: 2, venti: 3);

  Mocha(super.beverage);

  @override
  int get cost => beverage.cost + priceInfo.getCost(size);

  @override
  String get description => _description + beverage.description;
}

class Whip extends BeverageDecorator {
  final String _description = '휘핑크림';
  final PriceInfo priceInfo = PriceInfo(tall: 1, grande: 2, venti: 3);

  Whip(super.beverage);

  @override
  int get cost => beverage.cost + priceInfo.getCost(size);

  @override
  String get description => _description + beverage.description;
}
