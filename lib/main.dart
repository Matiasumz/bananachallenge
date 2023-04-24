import 'package:flutter/material.dart';
import 'package:banana_challenge/login_page.dart';
import 'package:banana_challenge/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/productList': (context) => ProductListPage(token: 'my_token'),
      },
    );
  }
}
