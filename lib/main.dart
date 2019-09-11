import 'package:flutter/material.dart';
import 'package:conversor_de_moedas/progress_button.dart';

import 'package:http/http.dart' as http; //Para fazer as requisições

import 'dart:async'; /*para fazer as requisições e
não tenha que ficar esperando ela voltar
O servidor leva um tempo para devolver as informaçoes
então não se deve travar a aplicação enquanto os dados
não chegam
*/

import 'dart:convert'; //Conversão do texto que chega para JSON

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=8703e44a";

/*void main() async{

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData( // thema padrão do app
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}*/

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

  //Controladores
    final realController = TextEditingController();
    final dolarController = TextEditingController();
    final euroController = TextEditingController();

  double dolar;
  double euro;

  //Funçoes de alteração dos valores das moedas
    void _realCharged(String text){
      double real = double.parse(text);
      dolarController.text = (real/dolar).toStringAsFixed(2); // a quantidade de digitos
      euroController.text = (real/euro).toStringAsFixed(2);
    }

    void _dolarCharged(String text){
      double dolar = double.parse(text);
      realController.text = (dolar = this.dolar).toStringAsFixed(2);
      euroController.text = (dolar = this.dolar/euro).toStringAsFixed(2);

    }
    void _euroCharged(String text){
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro/dolar).toStringAsFixed(2);
    }

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
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      child: CircularProgressIndicator(
                        value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.amber), backgroundColor: Colors.white,)
                    )
                   /* Text("Carregando Dados...",
                      style:  TextStyle(color:Colors.amber,
                        fontSize: 25.0),
                    textAlign: TextAlign.center ,) */
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
                      dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                      euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(// não teve erro.
                      padding: EdgeInsets.all(10), // borda em toda a tela
                      // Tela com rolamento
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.stretch, //centralizar ocupando o maior espaço possivel
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,),
                          buildTextField("Reais", "R\$", realController,_realCharged),
                          Divider(), // faz uma divisão (espaçamento) entre os dos objetos
                          buildTextField("Dólares", "US\$",dolarController,_dolarCharged),
                          Divider(),
                          buildTextField("Euros", "€",euroController,_euroCharged),
                        ],
                      ),

                    );
                  }
              }
          }),
    );
  }
}

// função para criar os TextField ( nao repetir codigo)
Widget buildTextField(String label, String prefix,
    TextEditingController textEditingController, Function alteraTextField){
 return TextField(
   controller: textEditingController, // passando o controlador
   decoration:  InputDecoration(
     labelText: label,
     labelStyle:  TextStyle(color:  Colors.amber),
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),//Colocar borda
     prefixText: prefix, // um texto predefinido para mostrar
   ),
   style: TextStyle(
       color: Colors.amber,
       fontSize: 25
   ),
   onChanged: alteraTextField, // toda vez que tiver alteração no campo ele vai chamar a função
   keyboardType: TextInputType.number, // irá aparecer o teclado de número
 );
}

