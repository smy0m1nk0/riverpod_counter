
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CounterProvider = AutoDisposeNotifierProvider<CounterNotifier, int>;

class CounterNotifier extends AutoDisposeNotifier<int> {
  @override
  build() {
    ref.onDispose(() { print('CounterNotifier disposed');});
    return 0;
  }

  void increment() => state++;
  void decrement() => state--;
}
