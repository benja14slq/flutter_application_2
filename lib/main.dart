import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_colors/app_colors.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/models/cart_model.dart';
import 'package:flutter_application_2/screen/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (ctx) => CartModel(), //Permite que cualquier widget acceda al carrito
      child: MaterialApp(
        title: 'Cafetería Express', // Nombre de la app
        theme: ThemeData(
          //Tema General
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:
            LoginPage(), // Define la primera pantalla que se muestra: El Login
      ),
    );
  }
}
