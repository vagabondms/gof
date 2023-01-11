void iteratorPattern() async {
  final pancakeHouseMenu = PancakeHouseMenu();

  final dinerMenu = DinerMenu();

  final waiter = Waiter(
    pancakeHouseMenu: pancakeHouseMenu,
    dinerMenu: dinerMenu,
  );

  waiter.printMenu();
}

class Waiter {
  PancakeHouseMenu pancakeHouseMenu;
  DinerMenu dinerMenu;

  Waiter({required this.pancakeHouseMenu, required this.dinerMenu});

  void printMenu() {
    Iterator<MenuItem> pancakeIterator = pancakeHouseMenu.iterator;
    Iterator<MenuItem> dinerIteraor = dinerMenu.iterator;
    _printMenu(pancakeIterator);
    _printMenu(dinerIteraor);
  }

  void _printMenu(Iterator<MenuItem> iterator) {
    while (iterator.hasNext()) {
      final MenuItem menuItem = iterator.next();
      print(menuItem.name);
      print(menuItem.description);
      print(menuItem.vegetarian);
      print(menuItem.price);
    }
  }
}

class MenuItem {
  final String _name;
  final String _description;
  final bool _vegetarian;
  final double _price;

  MenuItem({
    required String name,
    required String description,
    required bool vegetarian,
    required double price,
  })  : _name = name,
        _description = description,
        _vegetarian = vegetarian,
        _price = price;

  get name => _name;
  get description => _description;
  get vegetarian => _vegetarian;
  get price => _price;
}

class PancakeHouseMenu {
  final List<MenuItem> _menuItems = [];

  PancakeHouseMenu() {
    addItem('팬케이크 세트', '스크램블 에그가 있음', true, 2.99);
    addItem('레귤러 팬케이크 세트', '달걀 프라이 있음', false, 2.99);
  }

  addItem(String name, String description, bool vegetarian, double price) {
    final MenuItem menuItem = MenuItem(
      name: name,
      description: description,
      vegetarian: vegetarian,
      price: price,
    );
    _menuItems.add(menuItem);
  }

  get menuItems => _menuItems;

  Iterator<MenuItem> get iterator => PancakeHouseMenuIterator(_menuItems);
}

class PancakeHouseMenuIterator implements Iterator<MenuItem> {
  List<MenuItem> menuItems;
  int index = 0;
  PancakeHouseMenuIterator(this.menuItems);

  @override
  bool hasNext() {
    return menuItems.length > index;
  }

  @override
  MenuItem next() {
    return menuItems.elementAt(index++);
  }
}

class DinerMenuIterator implements Iterator<MenuItem> {
  List<MenuItem> menuItems;
  int index = 0;
  DinerMenuIterator(this.menuItems);

  @override
  bool hasNext() {
    return menuItems.length > index;
  }

  @override
  MenuItem next() {
    return menuItems.elementAt(index++);
  }
}

class DinerMenu {
  final List<MenuItem> _menuItems = [];

  DinerMenu() {
    addItem('채식자용 BLT', '콩고기 베이컨 있음', true, 2.99);
    addItem('통밀 위에 베이컨', '상추 토마토 있음', false, 2.99);
  }

  addItem(String name, String description, bool vegetarian, double price) {
    final MenuItem menuItem = MenuItem(
      name: name,
      description: description,
      vegetarian: vegetarian,
      price: price,
    );
    _menuItems.add(menuItem);
  }

  Iterator<MenuItem> get iterator => DinerMenuIterator(_menuItems);

  get menuItems => _menuItems;
}

abstract class Iterator<T> {
  bool hasNext();
  T next();
}
