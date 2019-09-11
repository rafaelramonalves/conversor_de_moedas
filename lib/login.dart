import 'package:conversor_de_moedas/TelaPrincipal.dart' as prefix0;
import 'package:flutter/material.dart';
import 'progress_button.dart';
import 'TelaPrincipal.dart';

void main(){
  runApp(MaterialApp(
    home: telaLogin(),
  ));
}

class telaLogin extends StatefulWidget {
  @override
  _telaLoginState createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {

  final _login = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.account_circle,color: Colors.amber,size: 200,),
            Divider(),
            campoDigitavel("Usuario: ",_login),
            Divider(),
            campoDigitavel("Senha: ",_senha),
            Divider(),
            ProgressButton(),
          ],
        ),
      )
    );
  }

  Widget campoDigitavel(String label, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),//Colocar borda
      ),
      style: TextStyle(
          color: Colors.amber,
          fontSize: 25,
      ),
    );
  }


}
