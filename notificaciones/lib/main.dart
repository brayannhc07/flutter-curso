import 'package:flutter/material.dart';
import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Material App",
      initialRoute: 'home',
      routes: {'home': (_) => HomeScreen(), "message": (_) => MessageScreen()},
    );
  }
}
