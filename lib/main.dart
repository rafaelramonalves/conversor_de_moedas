import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; //Para fazer as requisições

import 'dart:async'; /*para fazer as requisições e
não tenha que ficar esperando ela voltar
O servidor leva um tempo para devolver as informaçoes
então não se deve travar a aplicação enquanto os dados
não chegam
*/

import 'dart:convert'; //Conversão do texto que chega para JSON

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=8703e44a";

void main() async{



  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async{ // Função que retorna dados no futuro

  http.Response response = await http.get(request); // a resposta da requisição
  //await = esperando a resposta chegar
  // json.decode(response.body)["results"]["currencies"]["USD"]; // vai acessado cada bloco dentro do JSON
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(" \$ Conversor \$"),// o \ faz com que seja possivel colocar o sifrão
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>( // Construir a tela quando os dados retornarem
         // É Map pq o JSON retorna um map
          future: getData(), // função getData
          builder: (context, snapshot){ // especificando o que será mostrado em cada caso
              switch(snapshot.connectionState){ // verifica estado da conexão
                case ConnectionState.none: // Sem resultado
                case ConnectionState.waiting: // esperando os dados
                  return Center(
                    child: Text("Carregando Dados...",
                      style:  TextStyle(color:Colors.amber,
                        fontSize: 25.0),
                    textAlign: TextAlign.center ,)
                  );
                default: // caso ele obteve alguma coisa
                  if(snapshot.hasError){ // se houve erro
                    return Center(
                        child: Text("Erro ao Carregando Dados...",
                          style:  TextStyle(color:Colors.amber,
                              fontSize: 25.0),
                          textAlign: TextAlign.center ,)
                    );
                  } else{
                    return Container(color: Colors.green); // não teve erro.
                  }
              }
          }),
    );
  }
}
