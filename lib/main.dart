import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/controllers/products_controller.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/views/home_screen.dart';
import 'package:e_commerce_app/views/login_screen.dart';
import 'package:e_commerce_app/views/product_info_screen.dart';
import 'package:e_commerce_app/views/profile_screen.dart';
import 'package:e_commerce_app/views/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProductsProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => SignupScreen(),
          "/login": (context) => LoginScreen(),
          "/home": (context) => const HomeScreen(),
          "/profile" : (context)=>const ProfileScreen(),
          "/productInfo" : (context) =>const ProductInfoScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
