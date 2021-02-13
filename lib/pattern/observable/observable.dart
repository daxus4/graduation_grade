import 'observer.dart';

class Observable<T> {
  final List<Observer<T>> _observers;

  Observable(this._observers);

  addObserver(Observer<T> observer) {
    _observers.add(observer);
  }

  removeObserver(Observer<T> observer) {
    _observers.remove(observer);
  }

  notify(T message) {
    _observers.forEach((o) => o.update(message));
  }
}