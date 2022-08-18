import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

import 'package:currency_converter/widgets/custom_text_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _realController = TextEditingController();
  final _dollarController = TextEditingController();
  final _euroController = TextEditingController();

  late double dollar;
  late double euro;

  void _realChanged(String text) {
    double real = double.parse(text);

    _dollarController.text = (real / dollar).toStringAsFixed(2);
    _euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    double dollar = double.parse(text);

    _realController.text = (dollar * this.dollar).toStringAsFixed(2);
    _euroController.text = ((dollar * this.dollar) / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);

    _realController.text = (euro * this.euro).toStringAsFixed(2);
    _dollarController.text = ((euro * this.euro) / dollar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Carregando dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar dados.',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dollar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      CustomTextField(
                        type: TextInputType.number,
                        controller: _realController,
                        label: 'Reais',
                        prefix: 'R\$ ',
                        onChanged: _realChanged,
                      ),
                      const Divider(color: Colors.white),
                      CustomTextField(
                        type: TextInputType.number,
                        controller: _dollarController,
                        label: 'Dolares',
                        prefix: 'US\$ ',
                        onChanged: _dollarChanged,
                      ),
                      const Divider(color: Colors.white),
                      CustomTextField(
                        type: TextInputType.number,
                        controller: _euroController,
                        label: 'Euros',
                        prefix: '€ ',
                        onChanged: _euroChanged,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
