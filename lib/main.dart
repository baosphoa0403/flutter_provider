import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    // nhà phân phối
    create: (context) => MySettings(), // nhà cùng cấp
    child: const MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MySettings extends ChangeNotifier {
  // nhà cung cấp
  String text = "Heloo";
  Color color = Colors.red;

  void changeText() {
    if (text == "Heloo") {
      text = "World";
    } else {
      text = "Heloo";
    }
    notifyListeners();
  }

  void changeColor() {
    if (color == Colors.red) {
      color = Colors.cyan;
    } else {
      color = Colors.red;
    }
    notifyListeners();
  }

  Set? newColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// mySettings biến chứa dữ liệu child là chứa giao diện
  @override
  Widget build(BuildContext context) {
    return Consumer<MySettings>(
      builder: (context, mySettings, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Provider"),
          backgroundColor: mySettings.color,
        ),
        drawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        {mySettings.changeText(), Navigator.pop(context)},
                    child: const Text("change text")),
                ElevatedButton(
                    onPressed: () {
                      mySettings.changeColor();
                      Navigator.pop(context);
                    },
                    child: const Text("change Color")),
                ElevatedButton(
                    onPressed: () {
                      mySettings.newColor(Colors
                          .lightBlue); // sẽ ko đổi ui dc về ko có gọi hàm notyfi á để nó báo đến nơi cần cung cấp
                      Navigator.pop(context);
                    },
                    child: const Text("change Color to red")),
              ],
            ),
          ),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: mySettings.changeText,
                  child: const Text("Change Text")),
              Text('${mySettings.text} of MySettings')
            ],
          ),
        ),
      ),
    );
  }
}
