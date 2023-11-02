import 'package:flutter/material.dart';
import 'package:gaze_tracking/manager.dart';
import 'package:gaze_tracking/utils/route_generator.dart';

 main() async
 {
   WidgetsFlutterBinding.ensureInitialized();
   Manager dataManager = Manager();
   await dataManager.loadSettings();
   dataManager.connectServer();

   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/Home",
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}

