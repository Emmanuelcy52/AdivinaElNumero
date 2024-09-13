import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el numero demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Adivina el numero'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _intnetos = 5;
  int Adivina = 0;
  double _valorBarra = 0.0;
  String dificultad = 'Facil';
  List<String> _mayor=[];
  List<String> _menos=[];
  List<String> _exacto=[];

  void _ActualizarBarra(double newValue) {
    var numrandom = Random();
    setState(() {
      _valorBarra = newValue;
      if (_valorBarra <= 1) {
        Adivina = numrandom.nextInt(10)+1;
        dificultad = 'Facil';
        _intnetos= 5;
      } else if (_valorBarra <= 2) {
        Adivina = numrandom.nextInt(20)+1;
        dificultad = 'Medio';
        _intnetos = 8;
      } else if (_valorBarra <= 3) {
        Adivina = numrandom.nextInt(100)+1;
        dificultad = 'Avanzado';
        _intnetos = 15;
      } else {
        Adivina = numrandom.nextInt(1000)+1;
        dificultad = 'Extremo';
        _intnetos = 25;
      }
    });
  }

  void _RestarIntentos() {
    setState(() {
      _intnetos--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 80),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText: 'ingresa el numero',
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'intentos',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            _intnetos.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          'mayor que',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _mayor.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                  title: Text(
                                    _mayor[index],
                                    style: TextStyle(fontSize: 15, color: Colors.cyan),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'menor que',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Historial',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dificultad,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: Slider(
                    value: _valorBarra,
                    onChanged: _ActualizarBarra,
                    min: 0,
                    max: 4,
                    divisions: 3,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
