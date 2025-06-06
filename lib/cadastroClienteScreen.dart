import 'package:flutter/material.dart';
import 'package:projeto/controladoraCliente.dart';
import 'package:projeto/error.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({super.key, this.clienteToBeUpdated});
  final Cliente? clienteToBeUpdated;

  @override
  State<CadastroClienteScreen> createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  var _control = ClienteController();

  String tipoSelecionado = 'Pessoa Física';
  bool nomeError = false;
  bool cpfCnpjError = false;

  void _saveCliente() {
    if (_nomeController.text.isEmpty) {
      setState(() {
        nomeError = true;
      });
      return;
    }

    if (_cpfCnpjController.text.isEmpty) {
      setState(() {
        cpfCnpjError = true;
      });
      return;
    }

    _control.saveCliente(
      nome: _nomeController.text,
      tipo: tipoSelecionado,
      cpfCnpj: _cpfCnpjController.text,
      bairro: _bairroController.text,
      cep: _cepController.text,
      cidade: _cidadeController.text,
      email: _emailController.text,
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      uf: _ufController.text,
    );
    Navigator.pop(context);
  }

  void _editCliente() {
    if (_nomeController.text.isEmpty) {
      setState(() {
        nomeError = true;
      });
      return;
    }

    if (_cpfCnpjController.text.isEmpty) {
      setState(() {
        cpfCnpjError = true;
      });
      return;
    }

    _control.editCliente(
      nome: _nomeController.text,
      tipo: tipoSelecionado,
      cpfCnpj: _cpfCnpjController.text,
      bairro: _bairroController.text,
      cep: _cepController.text,
      cidade: _cidadeController.text,
      email: _emailController.text,
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      uf: _ufController.text,
      id: widget.clienteToBeUpdated!.id,
    );

    Navigator.pop(context);
  }

  void _dismissNomeError() {
    setState(() {
      nomeError = false;
    });
  }

  void _dismissCpfCnpjError() {
    setState(() {
      cpfCnpjError = false;
    });
  }

  void setUpdatingInformation() {
    if (widget.clienteToBeUpdated == null) return;
    _nomeController.text = widget.clienteToBeUpdated!.nome;
    _cpfCnpjController.text = widget.clienteToBeUpdated!.cpfCnpj;
    tipoSelecionado = widget.clienteToBeUpdated!.tipo;
    _emailController.text = widget.clienteToBeUpdated!.email ?? '';
    _telefoneController.text = widget.clienteToBeUpdated!.telefone ?? '';
    _cepController.text = widget.clienteToBeUpdated!.cep ?? '';
    _enderecoController.text = widget.clienteToBeUpdated!.endereco ?? '';
    _bairroController.text = widget.clienteToBeUpdated!.bairro ?? '';
    _cidadeController.text = widget.clienteToBeUpdated!.cidade ?? '';
    _ufController.text = widget.clienteToBeUpdated!.uf ?? '';
  }

  @override
  void initState() {
    setUpdatingInformation();
    _control.loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Cliente')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController,
                  onChanged: (_) => _dismissNomeError(),
                  decoration: InputDecoration(
                    label: Text('Nome'),
                    error:
                        nomeError ? CustomErrorMessage(origin: 'Nome') : null,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: tipoSelecionado,
                  items:
                      ['Pessoa Física', 'Pessoa Jurídica']
                          .map(
                            (tipo) => DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      tipoSelecionado = value!;
                    });
                  },
                  decoration: InputDecoration(label: Text('Tipo')),
                ),
                TextField(
                  controller: _cpfCnpjController,
                  onChanged: (_) => _dismissCpfCnpjError(),
                  decoration: InputDecoration(
                    label: Text(
                      tipoSelecionado == 'Pessoa Física' ? 'CPF' : 'CNPJ',
                    ),
                    error:
                        cpfCnpjError
                            ? CustomErrorMessage(origin: 'CPF/CNPJ')
                            : null,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(label: Text('Email (opcional)')),
                ),
                TextField(
                  controller: _telefoneController,
                  decoration: InputDecoration(
                    label: Text('Telefone (opcional)'),
                  ),
                ),
                TextField(
                  controller: _cepController,
                  decoration: InputDecoration(label: Text('CEP (opcional)')),
                ),
                TextField(
                  controller: _enderecoController,
                  decoration: InputDecoration(
                    label: Text('Endereço (opcional)'),
                  ),
                ),
                TextField(
                  controller: _bairroController,
                  decoration: InputDecoration(label: Text('Bairro (opcional)')),
                ),
                TextField(
                  controller: _cidadeController,
                  decoration: InputDecoration(label: Text('Cidade (opcional)')),
                ),
                TextField(
                  controller: _ufController,
                  decoration: InputDecoration(label: Text('UF (opcional)')),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    onPressed:
                        widget.clienteToBeUpdated == null
                            ? _saveCliente
                            : _editCliente,
                    child: Text(
                      widget.clienteToBeUpdated == null
                          ? 'Cadastrar cliente'
                          : 'Atualizar cliente',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
