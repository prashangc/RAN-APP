import 'package:app/screens/login_register_screen.dart';
import 'package:app/state/details_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterTabView extends StatefulWidget {
  static const routeName = '/Register-tab-view-screen';
  const RegisterTabView({Key? key}) : super(key: key);

  @override
  State<RegisterTabView> createState() => _RegisterTabViewState();
}

class _RegisterTabViewState extends State<RegisterTabView> {
  final _form = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isHiddenPassword2 = true;

  String? _username;
  String? _password;
  String? _confirmPassword;
  String? _email;

  void _registerNow() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _form.currentState?.save();
    bool isRegister = await Provider.of<DetailsState>(context, listen: false)
        .registerNow(_username.toString(), _email.toString(),
            _confirmPassword.toString(), _password.toString());
    if (!isRegister) {
      print("success");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginRegisterScreen()));
      // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
    } else {
      print("error");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Please provide correct credentials.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(35.0, 30.0, 35.0, 0.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter your Username';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _username = v;
                    },
                    cursorHeight: 22,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 25.0),

                      // prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Username',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _email = v;
                    },
                    cursorHeight: 22,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 25.0),

                      // prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _password = v;
                    },
                    obscureText: isHiddenPassword,
                    cursorHeight: 22,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.lock),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 25.0),

                      suffixIcon: GestureDetector(
                        onTap: _ontogglePasswordView,
                        child: Icon(
                            isHiddenPassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: const Color.fromARGB(255, 207, 206, 206),
                            size: 18),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter password again';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _confirmPassword = v;
                    },
                    obscureText: isHiddenPassword2,
                    cursorHeight: 22,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.lock),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 25.0),

                      suffixIcon: GestureDetector(
                        onTap: _ontogglePasswordViewConfirm,
                        child: Icon(
                            isHiddenPassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: const Color.fromARGB(255, 207, 206, 206),
                            size: 18),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      _registerNow();
                    },
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _ontogglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _ontogglePasswordViewConfirm() {
    setState(() {
      isHiddenPassword2 = !isHiddenPassword2;
    });
  }
}
