import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thoughtbox/pages/userlist.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Load saved login state from shared preferences
    _loadLoginState();
  }

  void _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (username != null && password != null && rememberMe) {
      _usernameController.text = username;
      _passwordController.text = password;
      _rememberMe = rememberMe;
    }
  }

  void _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
    prefs.setBool('rememberMe', _rememberMe);
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login Screen')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                    // color: Colors.black,
                    child: Center(
                        child: Text(
                      'Login Page',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    labelText: 'Password',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                  ),
                  Text('Remember me'),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (_usernameController.text == 'thoughtbox@google.com' &&
                        _passwordController.text == 'Test@123456') {
                      _saveLoginState();
                      // TODO: Navigate to User List Screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListScreen(
                                    users: [],
                                  ))).then((value) {
                        _usernameController.clear();
                        _passwordController.clear();
                        return null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid username or password')),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                      // color: Colors.black,
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
