import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Calculadora IMC",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _textInfo = "";

  void _resetCampos() {
    _formKey.currentState?.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calcular() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);

    if (imc < 18.5) {
      _textInfo = "Abaixo do Peso: $imc";
    } else if (18.5 <= imc && imc <= 24.9) {
      _textInfo = "Peso normal: $imc";
    } else if (25 <= imc && imc <= 29.9) {
      _textInfo = "Sobrepeso: $imc";
    } else if (30 <= imc && imc <= 34.9) {
      _textInfo = "Obsidade Grau I: $imc";
    } else if (35 <= imc && imc <= 39.9) {
      _textInfo = "Obesidade Grau II: $imc";
    } else if (40 <= imc) {
      _textInfo = "Obesidade Grau III: $imc";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetCampos,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person, size: 120, color: Colors.blue),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso [kg]",
                      labelStyle: TextStyle(color: Colors.blue)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira seu peso!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura [cm]",
                      labelStyle: TextStyle(color: Colors.blue)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira sua altura!";
                    else
                      return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ButtonTheme(
                      height: 50.0,
                      highlightColor: Colors.amber,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcular();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      )),
                ),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                )
              ],
            )),
      ),
    );
  }
}
