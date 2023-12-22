import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/view/register.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/settings/route_settings.dart';
import 'package:web_db/core/state/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends StateLogin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text(
                  "Hepsibunda",
                  style: GoogleFonts.poppins(
                    color: PColors.mainColor,
                    fontSize: context.height(0.035),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 4),
                Container(
                  padding: const EdgeInsets.all(50),
                  width: context.width(0.3),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: context.width(0.25),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: PColors.mainColor))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: context.width(0.25),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: PColors.mainColor))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length <= 6) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: context.width(0.25),
                        height: context.height(0.07),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: PColors.mainColor),
                          onPressed: handleLogin,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Şifremi Unuttum",
                                    style: TextStyle(
                                        fontSize: 15, color: PColors.mainColor),
                                  )),
                              const Spacer(),
                              TextButton(
                                  onPressed: () => pushToPage(
                                      context, const RegistrationScreen()),
                                  child: const Text(
                                    "Üye Ol",
                                    style: TextStyle(
                                        fontSize: 15, color: PColors.mainColor),
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
