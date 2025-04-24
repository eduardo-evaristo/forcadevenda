import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projeto/controladoraUsuario.dart';
import 'package:projeto/error.dart';

enum _errorEnum { usuario, senha }

class Cadastrousuarioscreen extends StatefulWidget {
  const Cadastrousuarioscreen({super.key, this.usuarioToBeUpdated});
  // Making it optional
  final Usuario? usuarioToBeUpdated;

  @override
  State<Cadastrousuarioscreen> createState() => _CadastrousuarioscreenState();
}

class _CadastrousuarioscreenState extends State<Cadastrousuarioscreen> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  UsuarioController controller = UsuarioController();
  bool nomeError = false;
  bool senhaError = false;
  bool hidePassword = true;

  //Create a controller class for this!!
  dynamic _saveUser() {
    if (_controllerNome.text.isEmpty) {
      setState(() {
        nomeError = true;
      });
      return;
    } else if (_controllerSenha.text.isEmpty) {
      setState(() {
        senhaError = true;
      });
      return;
    }
    controller.saveUsuario(_controllerNome.text, _controllerSenha.text);
    Navigator.pop(context);
  }

  dynamic _editUser() {
    if (!areFieldsValid() || widget.usuarioToBeUpdated == null) return;
    controller.editUsuario(
      _controllerNome.text,
      _controllerSenha.text,
      widget.usuarioToBeUpdated!.id,
    );
    Navigator.pop(context);
  }

  bool areFieldsValid() {
    if (_controllerNome.text.isEmpty) {
      setState(() {
        nomeError = true;
      });
      return false;
    } else if (_controllerSenha.text.isEmpty) {
      setState(() {
        senhaError = true;
      });
      return false;
    }
    return true;
  }

  void _dismissNomeError() {
    setState(() {
      nomeError = false;
    });
  }

  void _dismissSenhaError() {
    setState(() {
      senhaError = false;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void setUpdatingInformation() {
    if (widget.usuarioToBeUpdated == null) return;
    _controllerNome.text = widget.usuarioToBeUpdated!.nome;
  }

  @override
  void initState() {
    setUpdatingInformation();
    controller.loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Usuário')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  onChanged: (string) => _dismissNomeError(),
                  controller: _controllerNome,

                  decoration: InputDecoration(
                    label: Text('Nome de usuário'),
                    error:
                        nomeError ? CustomErrorMessage(origin: 'Nome') : null,
                  ),
                ),
                TextField(
                  onChanged: (string) => _dismissSenhaError(),
                  controller: _controllerSenha,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordVisibility,
                      child: Icon(
                        hidePassword
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded,
                      ),
                    ),
                    label: Text('Senha'),
                    error:
                        senhaError ? CustomErrorMessage(origin: 'Senha') : null,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    onPressed:
                        widget.usuarioToBeUpdated == null
                            ? _saveUser
                            : _editUser,

                    child: Text(
                      widget.usuarioToBeUpdated == null
                          ? 'Cadastrar'
                          : 'Atualizar',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
