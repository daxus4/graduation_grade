import 'observer.dart';

/// Abstract class that represent the Observable part for an **Observer
/// pattern**.
abstract class Observable<T> {
  final List<Observer<T>> _observers;

  /// Constructor that require a [List] of [Observer] of the same type.
  Observable(this._observers);

  /// Add an observer of the same type to the list.
  addObserver(Observer<T> observer) => _observers.add(observer);

  /// Remove an observer from the list.
  removeObserver(Observer<T> observer) => _observers.remove(observer);

  /// Notify the changes to every observer in the list.
  notify(T message) => _observers.forEach((o) => o.update(message));
}
