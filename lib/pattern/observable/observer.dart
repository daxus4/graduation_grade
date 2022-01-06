/// Abstract class that represent the Observer part for an **Observer pattern**.
abstract class Observer<T> {
  /// This function contains what to do when this receive a notification from
  /// [Observable].
  void update(T message);
}
