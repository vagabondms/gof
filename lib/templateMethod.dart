void templateMethod() async {}

abstract class CaffeineBeverageHook {
  // template Method
  prepareRecipe() {
    boilWater();
    brew();
    pourInCup();
    if (customerWantsCondiments()) {
      addCondiments();
    }
  }

  void boilWater() {
    print('물 끓이는 중');
  }

  pourInCup() {
    print('컵에 따르는 중');
  }

  brew();
  addCondiments();

  bool customerWantsCondiments() {
    return true;
  }
}

class Coffee extends CaffeineBeverageHook {
  brewCoffeeGrinds() {
    print('필터로 커피를 우려내는 중');
  }

  addSugarAndMilk() {
    print('설탕과 우유를 추가하는 중');
  }

  @override
  addCondiments() {
    addSugarAndMilk();
  }

  @override
  brew() {
    addSugarAndMilk();
  }

  @override
  bool customerWantsCondiments() {
    String answer = getUserInput();
    if (answer.toLowerCase().startsWith('y')) {
      return true;
    } else {
      return false;
    }
  }

  String getUserInput() {
    return 'yes';
  }
}

class Tea extends CaffeineBeverageHook {
  steepTeaBag() {
    print('찻잎을 우려내는 중');
  }

  addLemon() {
    print('레몬을 추가하는 중');
  }

  @override
  addCondiments() {
    addLemon();
  }

  @override
  brew() {
    steepTeaBag();
  }
}
