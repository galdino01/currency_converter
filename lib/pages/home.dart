import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:currency_converter/main.dart';
import 'package:currency_converter/widgets/custom_text_field.dart';

import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _realController = TextEditingController();
  final _dollarController = TextEditingController();
  final _euroController = TextEditingController();

  late Map<String, dynamic> carouselItems;
  late List<String> keys;
  late double dollar;
  late double euro;

  void _clearAll() {
    _realController.text = "";
    _dollarController.text = "";
    _euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double real = double.parse(text);

    _dollarController.text = (real / dollar).toStringAsFixed(2);
    _euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dollar = double.parse(text);

    _realController.text = (dollar * this.dollar).toStringAsFixed(2);
    _euroController.text = ((dollar * this.dollar) / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

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
                carouselItems = snapshot.data!['results']['stocks'];
                keys = carouselItems.keys.toList();
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
                        type: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: _realController,
                        label: 'Reais',
                        prefix: 'R\$ ',
                        onChanged: _realChanged,
                      ),
                      const Divider(color: Colors.white),
                      CustomTextField(
                        type: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: _dollarController,
                        label: 'Dolares',
                        prefix: 'US\$ ',
                        onChanged: _dollarChanged,
                      ),
                      const Divider(color: Colors.white),
                      CustomTextField(
                        type: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: _euroController,
                        label: 'Euros',
                        prefix: '€ ',
                        onChanged: _euroChanged,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            viewportFraction: 1,
                            initialPage: 0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                          ),
                          items: keys.map((key) {
                            return Builder(builder: (context) {
                              return Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            key,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(
                                        width: 8,
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              carouselItems[key]['points']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              carouselItems[key]['variation']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(
                                        width: 8,
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            carouselItems[key]['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            carouselItems[key]['location'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          }).toList(),
                        ),
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
