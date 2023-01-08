void simpleCommandPattern() async {
  final rc = SimpleRemoteControl();
  rc.command = LightOnCommand(Light());
  rc.onTap();
}

abstract class Command {
  void execute();
}

class LightOnCommand implements Command {
  Light light;

  LightOnCommand(this.light);

  @override
  void execute() {
    light.on();
  }
}

class Light {
  on() {
    print('light on');
  }
}

class SimpleRemoteControl {
  Command? slot;

  SimpleRemoteControl();

  set command(Command command) {
    slot = command;
  }

  onTap() {
    if (slot != null) {
      slot!.execute();
    }
  }
}
