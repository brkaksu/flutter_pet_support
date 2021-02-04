import 'package:flutter/material.dart';

class UrunBilgi extends StatefulWidget {
  @override
  _UrunBilgiState createState() => _UrunBilgiState();
}

class _UrunBilgiState extends State<UrunBilgi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Ürün bilgi"),
        ),
      ),
    );
  }
}
