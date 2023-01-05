void singletonPattern() async {}

class Singleton {
  Singleton._privateConstructor() {
    print('created');
  }
  // static 변수는 호출시 힙에 할당
  // 따라서 lazy하게 할당 가능
  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }
}
