import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/picsum_controller.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PicsumController()),
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF000000),
            secondary: const Color(0xFFFFFFFF),
          ),
          scaffoldBackgroundColor: const Color(0xFF000000),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
