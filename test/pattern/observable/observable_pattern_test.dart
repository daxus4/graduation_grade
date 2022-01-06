import 'package:test/test.dart';

import 'observable_pattern_fake.dart';

void main() {
  ObserverFake observer = ObserverFake();
  ObserverFake observer2 = ObserverFake();
  ObservableFake observable = ObservableFake([observer]);

  test('Observable', () {
    int firstMessage = 4;
    observable.notify(firstMessage);

    expect(observer.message, firstMessage);
    expect(observer2.message, 0);

    observable.removeObserver(observer);
    observable.addObserver(observer2);

    int secondMessage = 8;
    observable.notify(secondMessage);

    expect(observer.message, firstMessage);
    expect(observer2.message, secondMessage);
  });
}
