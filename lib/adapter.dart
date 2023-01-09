void adapterPattern() async {
  final client = Client(Adapter());
  client.doSomething();
}

class Client {
  final Target target;
  Client(this.target);

  void doSomething() {
    print(target.get());
  }
}

abstract class Target {
  String get();
}

class Adapter implements Target {
  final Server server = Server();
  @override
  get() {
    return server.getSomething();
  }
}

class Server {
  String getSomething() {
    return 'here you are';
  }
}
