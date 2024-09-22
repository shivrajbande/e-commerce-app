import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? isLoading = false;
  String? nameError;
  String? emailError;
  String? passwordError;


  final AuthService _authService = AuthService();

  bool validateForm() {
    bool isValid = true;
    
    if (nameController.text.isEmpty) {
      nameError = "Please enter your name";
      isValid = false;
    } else {
      nameError = null;
    }

    if (emailController.text.isEmpty) {
      emailError = "Please enter your email";
      isValid = false;
    } else {
      emailError = null;
    }

    if (passwordController.text.length < 6) {
      passwordError = "Password too short";
      isValid = false;
    } else {
      passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> signup(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLoading = true;
    notifyListeners();
    try {
      await _authService.signup(
          nameController.text, emailController.text, passwordController.text);
      prefs.setString("name", nameController.text);
      prefs.setString("email", emailController.text);
        Navigator.pushNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully!')),
      );
    } on FirebaseAuthMultiFactorException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${error.message}')));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.message}')),
      );
    } finally {
      passwordController.clear();
      emailController.clear();
      nameController.clear();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> userInfo = await _authService.login(
          emailController.text, passwordController.text);
      prefs.setString("name", userInfo['name']);
      prefs.setString("email", userInfo['email']);
        Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${error.message}')));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearFields() {
    passwordController.clear();
    emailController.clear();
    nameController.clear();
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    clearFields();
  }
}
