import 'package:flutter/material.dart';
import 'package:motor_flutter/motor_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meet Link',
                  style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  'First Time?',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                RegisterForm(),
                Divider(height: 60, thickness: 3),
                Text(
                  'Been Here Before?',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SigninForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username'
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 5) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password'
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 8) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
             ElevatedButton(
                child: Text('Create Account'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber[800]
                ),
                onPressed: () async {
                  final res = await MotorFlutter.to.createAccount(_formKey.currentState['Password']);
                  if (res == null) {
                    throw Exception('Account creation failed');
                  }
                  await MotorFlutter.to.connect();
                  Navigator.pushNamed(context, "/");
                }
             )
          ],
        ),
      ),
    );
  }
}

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DiD Address'
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 5) {
                  return 'Please enter your DiD Address';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password (Optional)'
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 8) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            ElevatedButton(
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber[800]
                ),
                onPressed: () async {
                  final res = await MotorFlutter.to.login(password: _formKey.currentState["Password (Optional)"] , did: _formKey.currentState["DiD Address"]);
                  if (res == null) {
                    throw Exception('Login failed');
                  }
                  await MotorFlutter.to.connect();
                  Navigator.pushNamed(context, "/");
                }
            )
          ],
        ),
      ),
    );
  }
}
