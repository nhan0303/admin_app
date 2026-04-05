import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Product Manager',
      debugShowCheckedModeBanner: false, // Tắt chữ Debug ở góc màn hình
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Giao diện hiện đại hơn
      ),
      home: HomeScreen(),
    );
  }
}
