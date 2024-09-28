import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateProvider<int>(
  (ref) => 0,
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
    final name = ref.watch(countProvider);
    ref.listen(countProvider, ((p, n) {
      if (n == 5) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("the value is $name")));
      }
    }));
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
        child: Text(name.toString()),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //ref.read(countProvider.notifier).state++;
        ref.read(countProvider.notifier).update((state) => state + 1);
      }),
    );
  }
}
