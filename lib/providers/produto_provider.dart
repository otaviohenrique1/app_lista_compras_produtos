import 'package:app_lista_compras_produtos/data/produto_dao.dart';
import 'package:app_lista_compras_produtos/models/produto_model.dart';
import 'package:flutter/material.dart';

class ProdutoProvider extends ChangeNotifier {
  List<ProdutoModel> _listaProdutos = [];
  List<ProdutoModel> _listaProdutosBusca = [];
  ProdutoModel _produto = ProdutoModel(
    id: "",
    // foto: "",
    nome: "",
    preco: 0,
    categoria: "",
    descricao: "",
    dataCriacao: "",
    ativo: "",
    quantidade: 0,
    unidade: "",
  );

  List<ProdutoModel> get listaProdutos => _listaProdutos;
  List<ProdutoModel> get listaProdutosBusca => _listaProdutosBusca;
  ProdutoModel get produto => _produto;

  Future adicionar(ProdutoModel produto) async {
    await ProdutoDao().save(produto);
    buscaTodos();
  }

  Future remover(String idTarefa) async {
    await ProdutoDao().delete(idTarefa);
    buscaTodos();
  }

  Future atualizar(ProdutoModel produto, String produtoId) async {
    await ProdutoDao().update(produto, produtoId);
    buscaTodos();
  }

  buscarPorId(String produtoId) async {
    List<ProdutoModel> data = await ProdutoDao().findByID(produtoId);
    if (data.isNotEmpty) {
      _produto = data.first;
      buscaTodos();
    } else {
      _produto = ProdutoModel(
        id: "",
        // foto: "",
        nome: "",
        preco: 0,
        categoria: "",
        descricao: "",
        dataCriacao: "",
        ativo: "",
        quantidade: 0,
        unidade: "",
      );
      buscaTodos();
    }
  }

  buscarPorNome(String nome) async {
    _listaProdutosBusca = await ProdutoDao().findByNome(nome);
    buscaTodos();
  }

  Future<void> buscaTodos() async {
    _listaProdutos = await ProdutoDao().findAll();
    notifyListeners();
  }
}
