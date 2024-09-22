import 'package:e_commerce_app/constants/color-codes.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/components/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorCodes.primaryBg,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "e-Shop",
                style: FontManager.getTextStyle(context,
                    color: ColorCodes.primaryButtonBg,
                    fontSize: 20,
                    lWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60, // Ensure fixed height for the field
                            child: TextFormField(
                              controller: Provider.of<AuthProvider>(context)
                                  .emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                constraints:
                                    const BoxConstraints(maxHeight: 40.0),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: false,
                            ),
                          ),
                          // Error Message for Password
                          Consumer<AuthProvider>(
                            builder: (context, provider, child) =>
                                provider.emailError != null
                                    ? Container(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          provider.emailError!,
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60, // Ensure fixed height for the field
                            child: TextFormField(
                              controller: Provider.of<AuthProvider>(context)
                                  .passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                constraints:
                                    const BoxConstraints(maxHeight: 40.0),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: true,
                            ),
                          ),
                          // Error Message for Password
                          Consumer<AuthProvider>(
                            builder: (context, provider, child) =>
                                provider.passwordError != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          provider.passwordError!,
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      text: "login",
                      textFontSize: 16,
                      onTap: () async {
                        if (Provider.of<AuthProvider>(context, listen: false)
                            .validateForm()) {
                          await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .signup(context);
                        }
                      },
                      bgColor: ColorCodes.primaryButtonBg,
                      textColor: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New here? ",
                            style:
                                FontManager.getTextStyle(context, fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .clearFields();
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              "Signup",
                              style: FontManager.getTextStyle(context,
                                  color: ColorCodes.primaryButtonBg,
                                  fontSize: 16,
                                  lWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
