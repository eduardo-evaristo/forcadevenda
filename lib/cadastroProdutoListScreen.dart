import 'package:flutter/material.dart';
import 'package:projeto/cadastroClienteScreen.dart';
import 'package:projeto/cadastroProdutoScreen.dart';
import 'package:projeto/controladoraCliente.dart';
import 'package:projeto/controladoraProduto.dart';
// import 'usuario.dart'; // Assuming Usuario is defined here

class CadastroProdutoListScreen extends StatefulWidget {
  const CadastroProdutoListScreen({super.key});

  @override
  State<CadastroProdutoListScreen> createState() =>
      _CadastroProdutoListScreenState();
}

class _CadastroProdutoListScreenState extends State<CadastroProdutoListScreen> {
  final _control = ProdutoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Produto')),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CadastroProdutoScreen()),
          ).then((_) async {
            _control.loadList();
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Produto>>(
        future: _control.loadList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar usuários: ${snapshot.error}'),
            );
          }

          final produtos = snapshot.data ?? [];

          if (produtos.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ListTile(
                title: Text(produto.nome),
                subtitle: Text('ID: ${produto.id}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      setState(() {
                        _control.deleteProduto(produto);
                      });
                    } else if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => CadastroProdutoScreen(
                                produtoToBeUpdated: produto,
                              ),
                        ),
                      ).then((_) async {
                        _control.loadList();
                        setState(() {});
                      });
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Excluir'),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Editar'),
                        ),
                      ],
                  icon: const Icon(Icons.more_vert),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CadastroProdutoScreen(
                            produtoToBeUpdated: produto,
                          ),
                    ),
                  ).then((_) async {
                    _control.loadList();
                    setState(() {});
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
