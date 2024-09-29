import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_nipples/counter_demo.dart';

final countProvider = StateNotifierProvider<CounterDemo, int>(
  (ref) => CounterDemo(),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(countProvider);
    ref.listen<int>(countProvider, (p, n) {
      if (n == 5) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("the value is $n")));
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ref.refresh(countProvider);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Text(counter.toString()),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(countProvider.notifier).increment();
      }),
    );
  }
}
