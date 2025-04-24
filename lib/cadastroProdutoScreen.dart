import 'package:flutter/material.dart';
import 'package:projeto/controladoraProduto.dart';
import 'package:projeto/error.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _controllerNome = TextEditingController();
  final _controllerQtdEstoque = TextEditingController();
  final _controllerPrecoVenda = TextEditingController();
  final _controllerStatus = TextEditingController();
  final _controllerCusto = TextEditingController();
  final _controllerCodigoBarras = TextEditingController();
  var _control = ProdutoController();

  bool nomeError = false;
  bool unidadeError = false;
  bool estoqueError = false;
  bool precoVendaError = false;
  bool statusError = false;

  String _selectedUnidade = '';

  void _saveProduto() {
    setState(() {
      nomeError = _controllerNome.text.isEmpty;
      unidadeError = _selectedUnidade.isEmpty;
      estoqueError = _controllerQtdEstoque.text.isEmpty;
      precoVendaError = _controllerPrecoVenda.text.isEmpty;
      statusError = _controllerStatus.text.isEmpty;
    });

    if (nomeError ||
        unidadeError ||
        estoqueError ||
        precoVendaError ||
        statusError)
      return;

    // salvar os dados (fazer algo com eles
    _control.saveProduto(
      nome: _controllerNome.text,
      unidade: _selectedUnidade,
      qtdEstoque: _controllerQtdEstoque.text,
      precoVenda: _controllerPrecoVenda.text,
      status: _controllerStatus.text,
    );
  }

  @override
  void initState() {
    _control.loadList();
    super.initState();
  }

  void _dismissError(String campo) {
    setState(() {
      switch (campo) {
        case 'nome':
          nomeError = false;
          break;
        case 'unidade':
          unidadeError = false;
          break;
        case 'estoque':
          estoqueError = false;
          break;
        case 'precoVenda':
          precoVendaError = false;
          break;
        case 'status':
          statusError = false;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar produto')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 100, bottom: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerNome,
                      onChanged: (_) => _dismissError('nome'),
                      decoration: InputDecoration(
                        label: const Text('Nome'),
                        error:
                            nomeError
                                ? CustomErrorMessage(origin: 'Nome')
                                : null,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value:
                          _selectedUnidade.isNotEmpty ? _selectedUnidade : null,
                      items:
                          ['un', 'cx', 'kg', 'lt', 'ml']
                              .map(
                                (unidade) => DropdownMenuItem(
                                  value: unidade,
                                  child: Text(unidade),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        _dismissError('unidade');
                        setState(() {
                          _selectedUnidade = value!;
                        });
                      },
                      decoration: InputDecoration(
                        label: const Text('Unidade'),
                        error:
                            unidadeError
                                ? CustomErrorMessage(origin: 'Unidade')
                                : null,
                      ),
                    ),
                    TextField(
                      controller: _controllerQtdEstoque,
                      onChanged: (_) => _dismissError('estoque'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Qtd. Estoque'),
                        error:
                            estoqueError
                                ? CustomErrorMessage(origin: 'Estoque')
                                : null,
                      ),
                    ),
                    TextField(
                      controller: _controllerPrecoVenda,
                      onChanged: (_) => _dismissError('precoVenda'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Preço de venda'),
                        error:
                            precoVendaError
                                ? CustomErrorMessage(origin: 'Preço de venda')
                                : null,
                      ),
                    ),
                    TextField(
                      controller: _controllerStatus,
                      onChanged: (_) => _dismissError('status'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Status (0 - ativo, 1 - inativo)'),
                        error:
                            statusError
                                ? CustomErrorMessage(origin: 'Status')
                                : null,
                      ),
                    ),
                    TextField(
                      controller: _controllerCusto,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Custo (opcional)'),
                      ),
                    ),
                    TextField(
                      controller: _controllerCodigoBarras,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Código de barras (opcional)'),
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: _saveProduto,
                        child: const Text('Cadastrar Produto'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
