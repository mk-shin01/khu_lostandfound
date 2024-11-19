import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Firebase 초기화가 필요한 경우 WidgetsFlutterBinding.ensureInitialized()를 호출해야 함
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Firebase Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//인증ui
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // 로그인 성공 후 처리할 코드
    } on FirebaseAuthException catch (e) {
      // 에러 처리
      print('Error: ${e.message}');
    }
  }

  Future<void> _signUpWithEmailPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // 회원가입 성공 후 처리할 코드
    } on FirebaseAuthException catch (e) {
      // 에러 처리
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _signInWithEmailPassword,
                  child: Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: _signUpWithEmailPassword,
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//데이터베이스 ui
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestorePage(),
    );
  }
}

class FirestorePage extends StatefulWidget {
  @override
  _FirestorePageState createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  final _nameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addName() async {
    await _firestore.collection('users').add({
      'name': _nameController.text,
    });
  }

  Future<void> _getNames() async {
    final snapshot = await _firestore.collection('users').get();
    for (var doc in snapshot.docs) {
      print(doc['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addName,
                  child: Text('Add Name'),
                ),
                ElevatedButton(
                  onPressed: _getNames,
                  child: Text('Get Names'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//푸시알림 ui
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notifications Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PushNotificationPage(),
    );
  }
}

class PushNotificationPage extends StatefulWidget {
  @override
  _PushNotificationPageState createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 알림 수신 시 처리할 코드
      print('Message received: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Push Notifications Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // 알림 권한 요청 및 설정
            await _firebaseMessaging.requestPermission();
          },
          child: Text('Enable Notifications'),
        ),
      ),
    );
  }
}

//파일업로드 ui
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoragePage(),
    );
  }
}

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _uploadImage() async {
    if (_image == null) return;
    try {
      await _storage.ref('uploads/${_image?.path.split('/').last}').putFile(_image!);
      print('File uploaded successfully');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Storage Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick an Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
