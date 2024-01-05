// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/u%C4%B1/compenent/login/date_button.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:intl/intl.dart';
import 'package:web_db/model/login/login_model.dart';
import 'package:web_db/service/login/reg_service.dart';
import 'package:web_db/settings/route_settings.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool check = false;
  bool check1 = false;
  bool? isGender;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterModal? loginModel;
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void registerLogin() async {
    _changeLoading();
    if (_formKey.currentState!.validate()) {
      loginModel = RegisterModal(
          birthDate: ref.read(registerProvider).birthday!.toIso8601String(),
          email: _emailController.text,
          isMale: isGender,
          name: _nameController.text,
          surname: _surnameController.text,
          password: _passwordController.text);
      if (await register(loginModel!)) {
        print("kayıt başarılı");
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(Routes.loginRoute);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text("Kayıt olunamadı tekrar deneyiz"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Tamam"))
              ]),
        );
      }
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    RegisterNotifier provider = ref.watch(registerProvider);
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SizedBox(
                      width: context.width(0.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Hepsibunda Dünyasını Keşfedin",
                            style: GoogleFonts.poppins(
                              color: PColors.mainColor,
                              fontSize: context.height(0.035),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: context.height(0.1),
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: PColors.mainColor))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _surnameController,
                            decoration: InputDecoration(
                                labelText: 'Surname',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: PColors.mainColor))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your surname';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DateButton(
                            onPressed: () => _selectDate(DateTime.now(),
                                (date) => provider.birthday = date),
                            title:
                                'Birthday\n${DateFormat('dd.MM.yyyy').format(provider.birthday ?? DateTime.now())}',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: check,
                                onChanged: (value) => setState(() {
                                  check = !check;

                                  if (value == true) {
                                    check1 = false;
                                    isGender = true;
                                  } else {
                                    isGender = null;
                                  }
                                }),
                              ),
                              const Text("Erkek"),
                              const Spacer(),
                              Checkbox(
                                value: check1,
                                onChanged: (value) => setState(() {
                                  check1 = !check1;
                                  if (value == true) {
                                    check = false;
                                    isGender = false;
                                  } else {
                                    isGender = null;
                                  }
                                }),
                              ),
                              const Text("Kadın"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: PColors.mainColor))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'Please enter a verified email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: PColors.mainColor))),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your surname';
                              }
                              if (value.length < 6) {
                                return 'Please enter a password longer than 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: context.width(0.4),
                            height: context.height(0.07),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: PColors.mainColor),
                              onPressed: registerLogin,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _selectDate(
      DateTime selectedDate, Function(DateTime) callback) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        callback(picked);
      });
    }
  }
}

class RegisterNotifier extends ChangeNotifier {
  DateTime? birthday;
}

final registerProvider = ChangeNotifierProvider<RegisterNotifier>((ref) {
  return RegisterNotifier();
});
