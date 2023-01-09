void facadePattern() async {
  final myDualSense = BlackDualSense();

  PlayStation(
    dualSense: myDualSense,
    monitor: SamsungMonitor(),
    speaker: BaO(),
  );

  final gamingLife = GamingLifeFacade(myDualSense);
  gamingLife.start();

  await Future.delayed(Duration(seconds: 3));

  gamingLife.stop();
}

class GamingLifeFacade {
  final DualSense dualSense;
  final Light light = Light();
  final Curtain curtain = Curtain();

  GamingLifeFacade(this.dualSense);

  start() {
    dualSense.on();
    light.off();
    curtain.close();
    print('start gaming.... 🎮');
  }

  stop() {
    print('stop gaming.... 🎮');
    dualSense.off();
    light.on();
    curtain.open();
  }
}

abstract class Console {
  on() {}
  off() {}
}

abstract class Monitor {
  on() {}
  off() {}
}

abstract class Speaker {
  on();
  off();
}

abstract class DualSense {
  on();
  off();
  addListener(PlayStation playStation);
}

class BlackDualSense implements DualSense {
  PlayStation? playStation;

  @override
  off() {
    print('듀얼센스 꺼짐');
    if (playStation != null) {
      playStation!.off();
    }
  }

  @override
  on() {
    print('듀얼센스 켜짐');
    if (playStation != null) {
      playStation!.on();
    }
  }

  @override
  addListener(PlayStation playStation) {
    this.playStation = playStation;
  }
}

class SamsungMonitor implements Monitor {
  @override
  off() {
    print('모니터 켜짐');
  }

  @override
  on() {
    print('모니터 꺼짐');
  }
}

class PlayStation implements Console {
  // output 장치
  final Monitor monitor;
  final Speaker speaker;

  // input 장치
  final DualSense dualSense;

  PlayStation({
    required this.monitor,
    required this.speaker,
    required this.dualSense,
  }) {
    dualSense.addListener(this);
  }

  @override
  off() {
    print('플레이스테이션 꺼짐');
    monitor.off();
    speaker.off();
  }

  @override
  on() {
    print('플레이스테이션 켜짐');
    monitor.on();
    speaker.on();
  }
}

class BaO implements Speaker {
  @override
  off() {
    print('BaO turned off');
  }

  @override
  on() {
    print('BaO turned on');
  }
}

class Curtain {
  open() {
    print('curtain open');
  }

  close() {
    print('curtain close');
  }
}

class Light {
  on() {
    print('불켜짐');
  }

  off() {
    print('불꺼짐');
  }
}
