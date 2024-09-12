import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController usernameTextControler = TextEditingController();
TextEditingController passwordTextControler = TextEditingController();
Future signIn() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameTextControler.text.trim(),
      password: passwordTextControler.text.trim());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void passwordCheeter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password is "thisIsTest"'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is Login',
            ),
            TextField(
              controller: usernameTextControler,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: passwordTextControler,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //Click Action
                if (usernameTextControler.text != '' &&
                    passwordTextControler.text != '') {
                  StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //true
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signed in successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        //false
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to sign in!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('The username or password field is empty'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password is "thisIsTest"'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
