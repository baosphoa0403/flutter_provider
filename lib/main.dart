import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    // nhà phân phối
    create: (context) => CounterProvider(), // nhà cùng cấp
    child: const MaterialApp(
      home: HomeScreen(),
    ),
  ));
}

class CounterProvider extends ChangeNotifier {
  int _counter = 100;
  int get counter => _counter;
  void add() {
    // có sự thay đổi data thì phải dùng hàm notifyListeners()
    _counter++;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<CounterProvider>()._counter.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      // app state là trạng thái nhìu màn hình
                      // push repacement là xoá lun màn hình vừa chạy dùng cho case là login
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SecondScreen(),
                      ));
                },
                child: const Text("Go to second Screen"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CounterProvider>().add();
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<CounterProvider>()._counter.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ));
                },
                child: const Text("Go to Home Screen"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CounterProvider>().add();
        },
      ),
    );
  }
}
