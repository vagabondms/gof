void statePatternBefore() async {
  final DrawingMachine drawingMachine = DrawingMachine(10);
  drawingMachine.insertQuarter();
  drawingMachine.turnCrank();

  print(drawingMachine);
}

class DrawingMachine {
  static final int SOLD_OUT = 0;
  static final int NO_QUARTER = 1;
  static final int HAS_QUARTER = 2;
  static final int SOLD = 3;

  int state = NO_QUARTER;

  int count;

  DrawingMachine(this.count);

  void insertQuarter() {
    if (state == HAS_QUARTER) {
      print('동전은 한개만');
    } else if (state == NO_QUARTER) {
      state = HAS_QUARTER;
      print('동전 넣음.');
    } else if (state == SOLD_OUT) {
      print('매진.');
    } else if (state == SOLD) {
      print('뽑고있음');
    }
  }

  void ejectQuarter() {
    if (state == HAS_QUARTER) {
      state = NO_QUARTER;
      print('동전 반환');
    } else if (state == NO_QUARTER) {
      print('동전 넣어주세요');
    } else if (state == SOLD_OUT) {
      print('매진되었음. 동전 반환중');
    } else if (state == SOLD) {
      print('알맹이 이미 뽑음');
    }
  }

  void turnCrank() {
    if (state == HAS_QUARTER) {
      state = SOLD;
      print('손잡이 돌렸음');
      dispense();
    } else if (state == NO_QUARTER) {
      print('동전을 넣으세요');
    } else if (state == SOLD_OUT) {
      print('매진됨');
    } else if (state == SOLD) {
      print('손잡이 한번만 돌려요');
    }
  }

  void dispense() {
    if (state == HAS_QUARTER) {
      print('내보내고 있음');
    } else if (state == NO_QUARTER) {
      print('동전 넣어주세요');
    } else if (state == SOLD_OUT) {
      print('매진');
    } else if (state == SOLD) {
      print('알맹이 내보내는 중');
      count = count - 1;
      if (count == 0) {
        print('더이상 뽑을게 없음');
        state = SOLD_OUT;
      } else {
        state = NO_QUARTER;
      }
    }
  }

  @override
  String toString() {
    return '${count}개 밖에 안남음 ㅠㅠ\n현재 state: $state';
  }
}
