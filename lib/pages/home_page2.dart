import 'package:app_lista_compras_produtos/components/aviso_dialog.dart';
import 'package:app_lista_compras_produtos/models/produto_model.dart';
import 'package:app_lista_compras_produtos/pages/busca_produto2.dart';
import 'package:app_lista_compras_produtos/pages/detalhes_produto.dart';
import 'package:app_lista_compras_produtos/pages/novo_produto.dart';
import 'package:app_lista_compras_produtos/providers/produto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'busca_produto.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({
    super.key,
  });

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);

    produtoProvider.buscaTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BuscaProduto()),
              );
            },
            iconSize: 32,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BuscaProduto2()),
              );
            },
            iconSize: 32,
            icon: const Icon(Icons.manage_search),
          ),
        ],
      ),
      body: Consumer<ProdutoProvider>(
        builder: (context, produtoProviderConsumer, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      ProdutoModel produtoItem =
                          produtoProviderConsumer.listaProdutos[index];
                      return _Item(produto: produtoItem);
                    },
                    childCount: produtoProviderConsumer.listaProdutos.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NovoProduto()),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    // ignore: unused_element
    super.key,
    required this.produto,
  });

  final ProdutoModel produto;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = (widget.produto.ativo == "Sim") ? true : false;

    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);

    void onChanged(bool? value) {
      setState(() {
        isSelected = value!;
        produtoProvider.atualizar(
          ProdutoModel(
            id: widget.produto.id,
            dataCriacao: widget.produto.dataCriacao,
            nome: widget.produto.nome,
            preco: widget.produto.preco,
            descricao: widget.produto.descricao,
            quantidade: widget.produto.quantidade,
            unidade: widget.produto.unidade,
            categoria: widget.produto.categoria,
            ativo: (isSelected) ? "Sim" : "Não",
          ),
          widget.produto.id,
        );
      });
    }

    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesProduto(
                  id: widget.produto.id,
                ),
              ),
            );
          },
          title: Text(
            widget.produto.nome,
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            "${widget.produto.quantidade.toString()} ${widget.produto.unidade}",
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              avisoDialog(
                context: context,
                mensagem: "Deseja remover o produto?",
                onPressedCancel: () => Navigator.pop(context),
                onPressedConfirm: () {
                  Navigator.pop(context, 'OK');
                  produtoProvider.remover(widget.produto.id);
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
          leading: Checkbox(
            onChanged: onChanged,
            value: isSelected,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
