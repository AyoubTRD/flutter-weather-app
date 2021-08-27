import 'package:rxdart/rxdart.dart';

class CounterBloc {
  BehaviorSubject<int> _subjectCounter = BehaviorSubject<int>.seeded(0);

  ValueStream<int> get counter => _subjectCounter.stream;

  void increment() {
    _subjectCounter.sink.add(counter.value + 1);
  }

  void decrement() {
    _subjectCounter.sink.add(counter.value - 1);
  }

  void reset() {
    _subjectCounter.sink.add(0);
  }

  void dispose() {
    _subjectCounter.close();
  }
}
