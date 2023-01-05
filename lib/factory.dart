void factoryPattern() async {
  final seoul = NewYorkStylePizzaStore();
  print(seoul.orderPizza(PizzaType.cheese));
}

enum PizzaType {
  cheese,
  pepperoni,
}

abstract class Pizzeria {
  Pizzeria();

  Pizza orderPizza(PizzaType type) {
    final pizza = _createPizza(type);
    pizza.prepare();
    pizza.bake();
    pizza.cut();
    pizza.box();

    return pizza;
  }

  Pizza _createPizza(PizzaType type);
}

class NewYorkStylePizzaStore extends Pizzeria {
  final IngredientFactory ingredientFactory = NyIngredientFactory();

  @override
  Pizza _createPizza(PizzaType type) {
    switch (type) {
      case PizzaType.cheese:
        return NewYorkStyleCheesePizza(NyIngredientFactory());
      default:
        return NewYorkStyleCheesePizza(NyIngredientFactory());
    }
  }
}

abstract class IngredientFactory {
  String getCheese();
  String getDough();
  String getClams();
  String getSauce();
}

class NyIngredientFactory implements IngredientFactory {
  @override
  String getCheese() {
    return 'cheese';
  }

  @override
  String getClams() {
    return 'clams';
  }

  @override
  String getDough() {
    return 'dough';
  }

  @override
  String getSauce() {
    return 'sauce';
  }
}

abstract class Pizza {
  String get cheese;

  prepare();
  bake() {}
  cut() {}
  box() {}
}

class NewYorkStyleCheesePizza extends Pizza {
  final IngredientFactory ingredientFactory;
  @override
  late String cheese;

  NewYorkStyleCheesePizza(this.ingredientFactory);

  @override
  prepare() {
    cheese = ingredientFactory.getCheese();
  }
}
