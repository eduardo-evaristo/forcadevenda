import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Produto {
  int id;
  String nome;
  String unidade;
  String qtdEstoque;
  String precoVenda;
  String status;

  String? custo;
  String? codigoBarras;

  Produto({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.qtdEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    this.codigoBarras,
  });

  Produto.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      unidade = json['unidade'],
      qtdEstoque = json['qtdEstoque'],
      precoVenda = json['precoVenda'],
      status = json['status'],
      custo = json['custo'],
      codigoBarras = json['codigoBarras'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarras': codigoBarras,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class ProdutoController {
  List<Produto> produtos = [];

  void saveProduto({
    required String nome,
    required String unidade,
    required String qtdEstoque,
    required String precoVenda,
    required String status,
    String? custo,
    String? codigoBarras,
  }) {
    Produto produto = Produto(
      id: produtos.length,
      nome: nome,
      unidade: unidade,
      qtdEstoque: qtdEstoque,
      precoVenda: precoVenda,
      status: status,
      custo: custo,
      codigoBarras: codigoBarras,
    );
    produtos.add(produto);
    return saveListToFile();
  }

  void deleteProduto(Produto produto) {
    produtos.remove(produto);
    return saveListToFile();
  }

  Future<List<Produto>> loadList() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    File file = File('$folder/produtos.txt');
    String list = await file.readAsString();

    List<dynamic> listToJson = jsonDecode(list);
    var temporaryNewList = listToJson.map(
      (jsonItem) => Produto.fromJson(jsonItem),
    );
    produtos.clear();
    produtos.addAll(temporaryNewList);
    return produtos;
  }

  void saveListToFile() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    File file = File('$folder/produtos.txt');
    String produtosListString = produtos.toString();
    print(produtosListString);
    await file.writeAsString(produtosListString);
  }
}
