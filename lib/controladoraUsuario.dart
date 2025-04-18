import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Usuario {
  int id;
  String nome;
  String senha;

  Usuario({required this.id, required this.nome, required this.senha});

  Usuario.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      senha = json['senha'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'senha': senha};
  }

  @override
  String toString() {
    // Stringification, kinda like JSON.stringify
    return jsonEncode(toJson());
  }
}

class UsuarioController {
  List<Usuario> usuarios = [Usuario(id: 0, nome: 'Abc', senha: 'aaaaaaaaa')];

  void saveUsuario(String nome, String senha) {
    Usuario usuario = Usuario(id: usuarios.length, nome: nome, senha: senha);
    usuarios.add(usuario);
    return saveListToFile();
  }

  void deleteUsuario(Usuario usuario) {
    usuarios.remove(usuario);
    return saveListToFile();
  }

  Future<List<Usuario>> loadList() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    File file = File(folder + '/usuarios.txt');
    //Reading the .txt file
    String list = await file.readAsString();

    List<dynamic> listToJson = jsonDecode(list);
    var temporaryNewList = listToJson.map(
      (jsonItem) => Usuario.fromJson(jsonItem),
    );
    usuarios.clear();
    usuarios.addAll(temporaryNewList);
    return usuarios;
  }

  void saveListToFile() async {
    final Directory dir = await getApplicationSupportDirectory();
    String folder = dir.path;
    print(folder);
    File file = File(folder + '/usuarios.txt');
    String usuariosListString = usuarios.toString();
    print(usuariosListString);
    await file.writeAsString(usuariosListString);
  }
}
