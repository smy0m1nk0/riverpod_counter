import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter_app/notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  CounterPage()));
          },
          child: const Text('Start Counter'),
        ),
      ),
    );
  }
}

class CounterPage extends ConsumerWidget {
  CounterPage({super.key});

  final counterProvider = CounterProvider(
    () => CounterNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(counterProvider, (previous, next) {
      print('Counter: $next & Previous: $previous');
    });
    final counter = ref.watch(counterProvider);
    CounterNotifier counterNotifier = ref.read(counterProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Counter is $counter',
                style: const TextStyle(fontSize: 24.0),
              ),
              FilledButton(
                  onPressed: () {
                    counterNotifier.increment();
                  },
                  child: const Text('Increment')),
              FilledButton(
                  onPressed: () {
                    counterNotifier.decrement();
                  },
                  child: const Text('Decrement')),
              FilledButton(
                  onPressed: () {
                    int defaultValue = ref.refresh(counterProvider);
                  },
                  child: const Text('Decrement')),
            ],
          ),
        ));
  }
}
