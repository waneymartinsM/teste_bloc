import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MeuBloc bloc = MeuBloc();

  @override
  void dispose() {
    bloc.fecharStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Bloc Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
                stream: bloc.minhaStream,
                initialData: 0,
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Há um erro na Stream");
                  } else {
                    return Text(
                      "${snapshot.data}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementar,
        tooltip: "Incrementar",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MeuBloc {
  int _total = 0;
  int get total => _total;

  final _blocController = StreamController<int>();

  Stream<int> get minhaStream => _blocController.stream;

  void incrementar() {
    _total++;
    _blocController.sink.add(total);
  }

  fecharStream() {
    _blocController.close();
  }
}
