import 'package:camera/camera.dart';
import 'package:credentity/features/ocr/ocr.dart';
import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:credentity/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  cameras = await availableCameras();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Credentity",
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF434DFF, {
          50: Color.fromRGBO(26, 30, 100, 0.1),
          100: Color.fromRGBO(26, 30, 100, 0.2),
          200: Color.fromRGBO(26, 30, 100, 0.3),
          300: Color.fromRGBO(26, 30, 100, 0.4),
          400: Color.fromRGBO(26, 30, 100, 0.5),
          500: Color.fromRGBO(26, 30, 100, 0.6),
          600: Color.fromRGBO(26, 30, 100, 0.7),
          700: Color.fromRGBO(26, 30, 100, 0.8),
          800: Color.fromRGBO(26, 30, 100, 0.9),
          900: Color.fromRGBO(26, 30, 100, 1)
        }),
        fontFamily: "SFProText",
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
