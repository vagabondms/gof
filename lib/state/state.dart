void statePattern() async {
  final drawingMachine = DrawingMachine(10);
  drawingMachine.insertQuarter();
  drawingMachine.ejectQuarter();
  drawingMachine.insertQuarter();
  drawingMachine.turnCrank();
  drawingMachine.turnCrank();
}

abstract class State {
  insertQuarter();
  ejectQuarter();
  turnCrank();
  dispense();
}

class DrawingMachine {
  late State soldOutState;
  late State noQuarterState;
  late State hasQuarterState;
  late State soldState;

  late State state;

  int count;

  DrawingMachine(this.count) {
    soldOutState = SoldOutState(this);
    noQuarterState = NoQuarterState(this);
    hasQuarterState = HasQuarterState(this);
    soldState = SoldState(this);

    if (count > 0) {
      state = noQuarterState;
    } else {
      state = soldOutState;
    }
  }

  void insertQuarter() {
    state.insertQuarter();
  }

  void ejectQuarter() {
    state.ejectQuarter();
  }

  void turnCrank() {
    state.turnCrank();
    if (state is SoldState) {
      state.dispense();
    }
  }

  void release() {
    count = count - 1;
  }
}

class SoldOutState implements State {
  final DrawingMachine drawingMachine;
  SoldOutState(this.drawingMachine);

  @override
  dispense() {
    print('매진 상태임');
  }

  @override
  ejectQuarter() {
    print('매진 상태임');
  }

  @override
  insertQuarter() {
    print('매진 상태임');
  }

  @override
  turnCrank() {
    print('매진 상태임');
  }
}

class NoQuarterState implements State {
  final DrawingMachine drawingMachine;
  NoQuarterState(this.drawingMachine);

  @override
  dispense() {
    print('동전 없음');
  }

  @override
  ejectQuarter() {
    print('동전 없음');
  }

  @override
  insertQuarter() {
    print('동전 넣음');
    drawingMachine.state = drawingMachine.hasQuarterState;
  }

  @override
  turnCrank() {
    print('동전 없음');
  }
}

class HasQuarterState implements State {
  final DrawingMachine drawingMachine;
  HasQuarterState(this.drawingMachine);

  @override
  dispense() {
    print('내보낼 수 없습니다.');
  }

  @override
  ejectQuarter() {
    print('동전 반환');
    drawingMachine.state = drawingMachine.noQuarterState;
  }

  @override
  insertQuarter() {
    print('동전은 한개만');
  }

  @override
  turnCrank() {
    print('손잡이 돌렸음.');
    drawingMachine.state = drawingMachine.soldState;
  }
}

class SoldState implements State {
  final DrawingMachine drawingMachine;
  SoldState(this.drawingMachine);

  @override
  dispense() {
    drawingMachine.release();
    if (drawingMachine.count > 0) {
      print('나오는 중');
      drawingMachine.state = drawingMachine.noQuarterState;
    } else {
      print('매진');
      drawingMachine.state = drawingMachine.soldOutState;
    }
  }

  @override
  ejectQuarter() {
    print('내보내고 있음');
  }

  @override
  insertQuarter() {
    print('내보내고 있음');
  }

  @override
  turnCrank() {
    print('내보내고 있음');
  }
}
