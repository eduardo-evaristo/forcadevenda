import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Cliente {
  int id;
  String nome;
  String tipo; // Pessoa Física ou Jurídica
  String cpfCnpj;

  String? email;
  String? telefone;
  String? cep;
  String? endereco;
  String? bairro;
  String? cidade;
  String? uf;

  Cliente({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.cpfCnpj,
    this.email,
    this.telefone,
    this.cep,
    this.endereco,
    this.bairro,
    this.cidade,
    this.uf,
  });

  Cliente.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      tipo = json['tipo'],
      cpfCnpj = json['cpfCnpj'],
      email = json['email'],
      telefone = json['telefone'],
      cep = json['cep'],
      endereco = json['endereco'],
      bairro = json['bairro'],
      cidade = json['cidade'],
      uf = json['uf'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'cpfCnpj': cpfCnpj,
      'email': email,
      'telefone': telefone,
      'cep': cep,
      'endereco': endereco,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class ClienteController {
  List<Cliente> clientes = [];

  void saveCliente({
    required String nome,
    required String tipo,
    required String cpfCnpj,
    String? email,
    String? telefone,
    String? cep,
    String? endereco,
    String? bairro,
    String? cidade,
    String? uf,
  }) {
    Cliente cliente = Cliente(
      id: clientes.length,
      nome: nome,
      tipo: tipo,
      cpfCnpj: cpfCnpj,
      email: email,
      telefone: telefone,
      cep: cep,
      endereco: endereco,
      bairro: bairro,
      cidade: cidade,
      uf: uf,
    );
    clientes.add(cliente);
    return saveListToFile();
  }

  void deleteCliente(Cliente cliente) {
    clientes.remove(cliente);
    return saveListToFile();
  }

  Future<List<Cliente>> loadList() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    File file = File('$folder/clientes.txt');
    String list = await file.readAsString();

    List<dynamic> listToJson = jsonDecode(list);
    var temporaryNewList = listToJson.map(
      (jsonItem) => Cliente.fromJson(jsonItem),
    );
    clientes.clear();
    clientes.addAll(temporaryNewList);
    return clientes;
  }

  void saveListToFile() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    File file = File('$folder/clientes.txt');
    String clientesListString = clientes.toString();
    print(clientesListString);
    await file.writeAsString(clientesListString);
  }
}
