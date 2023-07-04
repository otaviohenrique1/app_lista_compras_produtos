import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lista_compras_produtos/providers/produto_provider.dart';
import 'package:app_lista_compras_produtos/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProdutoProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Lista de compra de produtos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
