import 'package:flutter/material.dart';

import 'pages/AtakSearch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pesquisa Atak',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AtakSearch(),
    );
  }
}
