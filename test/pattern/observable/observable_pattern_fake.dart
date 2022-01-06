import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

class ObservableFake extends Observable<int> {
  ObservableFake(List<Observer<int>> observers) : super(observers);
}

class ObserverFake extends Observer<int> {
  int _message = 0;

  int get message => _message;

  @override
  void update(int message) => _message = message;
}
