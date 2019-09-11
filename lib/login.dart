import 'package:flutter/material.dart';

/*void main(){
  runApp(MaterialApp(
    home: telaLogin(),
  ));
}*/

class telaLogin extends StatefulWidget {
  @override
  _telaLoginState createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
    );
  }
}
