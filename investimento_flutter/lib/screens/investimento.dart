import 'package:flutter/material.dart';
import 'dart:math';

class Investimento extends StatefulWidget {
  const Investimento({super.key});

  @override
  State<Investimento> createState() => _InvestimentoState();
}

class _InvestimentoState extends State<Investimento> {
  double valorMensal = 0.0;
  double juros = 0.0;
  int meses = 0;

  double totalSemJuros() {
    return valorMensal * meses;
  }

  double totalComJuros() {
    double i = juros / 100;
    double total = 0;

    for (int mes = 0; mes < meses; mes++) {
      total += valorMensal * pow((1 + i), mes);
    }

    return total;
  }

  void resultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Resultado"),
        content: Text(
          "Valor total com juros compostos: R\$ ${totalComJuros().toStringAsFixed(2)}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simulador de Investimentos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 27, 51, 112),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fundo.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Investimento mensal"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  valorMensal = double.tryParse(value) ?? 0.0;
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: "Número de meses"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  meses = int.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: "Taxa de juros (%)"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  juros = double.tryParse(value) ?? 0.0;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                  resultado();
                },
                child: Text("Simular"),
              ),
              SizedBox(height: 20),
              Text(
                "Valor total sem juros: R\$ ${totalSemJuros().toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Valor total com juros compostos: R\$ ${totalComJuros().toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Sair"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}