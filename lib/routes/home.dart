import 'package:flutter/material.dart';
import 'package:motor_flutter/motor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _tokens;
  Future<QueryWhatIsResponse?> querySchema(String q) async {
    return await MotorFlutterPlatform.instance.querySchema(QueryWhatIsRequest(did: q));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Links"),
        centerTitle: true,
        backgroundColor: Colors.amber[800],
      ),
      body: Column(
        children: _tokens.map((e) => e.toString()),
      ),
    );
  }
}
