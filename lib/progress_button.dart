import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';


// Barra de progresso
class ProgressButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_progressButtonState();

}

class _progressButtonState extends State<ProgressButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  int state; // para animação
  double width = double.infinity;
  Animation _animation;
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.blue,
        elevation: _isPressed ? 6.0 : 4.0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          key: globalKey,
          height: 48,
          width: width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),//fazer o circulo rodar em todo o botão
            color: state ==2 ? Colors.green : Colors.blue,
            child: buildButtonChild(), // botão circular girando
            onHighlightChanged: (isPressed) {
              setState(() {
                isPressed = _isPressed;
                if (state == 0) { // mudar para a cor verde apos a animação
                  animateButton();
                }
              });
            },
          ),
        )
    );
  }

  void animateButton() {
    double inicialWigth = globalKey.currentContext.size.width;
    var controller = AnimationController(
        duration: Duration(microseconds: 300), vsync: this);
    Tween(begin: 0.0, end: 1.0)
        .animate(controller)
      ..addListener(() {
        setState(() {
          width = inicialWigth - ((inicialWigth - 48.0) * _animation.value);
        });
      });
    controller.forward(); // Animação do botão grande ficar pequeno
    setState(() {
      state = 1;
    });

    Timer(Duration(milliseconds: 3300),(){
      setState(() {
        state=2;
      });
    });
  }

  Widget buildButtonChild() {
    if (state == 0) {
      return Text('loguin');
    } else if (state == 1) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child:  CircularProgressIndicator(
            value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
      );
    } else {
      return Icon(Icons.check, color: Colors.white,);
    }
  }
}