void commandPattern() async {
  final rc = RemoteControl();

  final OutdoorLight outdoorLight = OutdoorLight();

  rc.setCommand(
    slot: 6,
    onCommand: OutdoorLightOnCommand(outdoorLight),
    offCommand: OutdoorLightOffCommand(outdoorLight),
  );
  rc.onTapOn(0);
}

abstract class Command {
  void execute();
}

/// [RemoteControl] : Invoker
class RemoteControl {
  RemoteControl();

  final List<Command?> onCommands = List<Command?>.filled(7, null);
  final List<Command?> offCommands = List<Command?>.filled(7, null);

  setCommand({
    required int slot,
    required Command onCommand,
    required Command offCommand,
  }) {
    if (slot > 7) throw ArgumentError('0~6 사이만 입력하세요');
    onCommands[slot] = onCommand;
    offCommands[slot] = offCommand;
    print('$slot에 기기가 할당되었습니다.');
  }

  onTapOn(int slot) {
    onCommands.elementAt(slot)?.execute();
  }

  onTapOff(int slot) {
    offCommands.elementAt(slot)?.execute();
  }
}

class OutdoorLightOffCommand implements Command {
  OutdoorLight outdoorLight;
  OutdoorLightOffCommand(this.outdoorLight);

  @override
  void execute() {
    outdoorLight.off();
  }
}

class OutdoorLightOnCommand implements Command {
  OutdoorLight outdoorLight;
  OutdoorLightOnCommand(this.outdoorLight);

  @override
  void execute() {
    outdoorLight.on();
  }
}

/// Receivers
class OutdoorLight {
  on() {
    print('outdoor light on');
  }

  off() {
    print('outdoor light off');
  }
}

class CeilingLight {
  on() {}
  off() {}
  dim() {}
}

class TV {
  on() {}
  off() {}
}

class FaucetControl {
  openValve() {}
  closeValve() {}
}

class Hottub {
  jetsOn() {}
  jetsOff() {}
}

class GardeLight {
  manualOn() {}
  manualOff() {}
}
