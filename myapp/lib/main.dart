import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
      name: 'flutterMangaHub',
      options: Platform.isMacOS || Platform.isIOS
          ? const FirebaseOptions(
              apiKey: 'AIzaSyCEuEcJnvirJ32Ek4QbEANbz-_ZIuajhXU',
              appId: 'IOS KEY',
              messagingSenderId: '500152845569',
              projectId: 'fluttermangahub',
              databaseURL:
                  'https://fluttermangahub-default-rtdb.europe-west1.firebasedatabase.app')
          : const FirebaseOptions(
              apiKey: 'AIzaSyCEuEcJnvirJ32Ek4QbEANbz-_ZIuajhXU',
              appId: '1:500152845569:android:a16031ef2239e09131c700',
              messagingSenderId: '500152845569',
              projectId: 'fluttermangahub',
              databaseURL:
                  'https://fluttermangahub-default-rtdb.europe-west1.firebasedatabase.app'));
  // runApp(const MyApp());
  // ignore: prefer_const_constructors
  runApp(ProviderScope(child: MyApp(app: app)));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  FirebaseApp app;
  // MyApp({this.app}, {Key? key}) : super(key: key);
  MyApp({Key? key, required this.app}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Manga Hub', app: app),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.app})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final FirebaseApp app;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  late DatabaseReference _bannerRef;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    final FirebaseDatabase _database = FirebaseDatabase(app: widget.app);
    _bannerRef = _database.ref().child('Banners');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: const Color(0xFFF44A3E),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<String>>(
        future: getBanners(_bannerRef),
        builder: (context, snapshot) {
          return Column();
        },
      ),
    );
  }

  Future<List<String>> getBanners(DatabaseReference bannerRef) {
    return bannerRef.once().then((truc) => truc.snapshot.value);
  }
}
