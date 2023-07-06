import 'package:flutter/material.dart';
import 'package:app_lista_compras_produtos/components/campo_texto.dart';
import 'package:app_lista_compras_produtos/utils/validator.dart';

class BuscaProduto2 extends StatefulWidget {
  const BuscaProduto2({
    super.key,
  });

  @override
  State<BuscaProduto2> createState() => _BuscaProduto2State();
}

class _BuscaProduto2State extends State<BuscaProduto2> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _termoBuscaController = TextEditingController();

  @override
  void dispose() {
    _termoBuscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (formKey.currentState!.validate()) {
        // String termoBusca = _termoBuscaController.text;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Busca"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // padding: const EdgeInsets.all(32),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CampoTexto(
                              exibeLabel: false,
                              validator: validaCampoVazio,
                              keyboardType: TextInputType.text,
                              controller: _termoBuscaController,
                              hintText: "Digite o nome do produto",
                              obscureText: false,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 65,
                            height: 65,
                            child: IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: onSubmit,
                              icon: const Icon(Icons.search),
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: const Text("Nome"),
                        subtitle: const Text("Quantidade"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      const Divider(),
                    ],
                  );
                },
                childCount: 10,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }
}
