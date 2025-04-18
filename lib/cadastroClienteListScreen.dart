import 'package:flutter/material.dart';
import 'package:projeto/cadastroClienteScreen.dart';
import 'package:projeto/controladoraCliente.dart';
// import 'usuario.dart'; // Assuming Usuario is defined here

class CadastroClienteListScreen extends StatefulWidget {
  const CadastroClienteListScreen({super.key});

  @override
  State<CadastroClienteListScreen> createState() =>
      _CadastroClienteListScreenState();
}

class _CadastroClienteListScreenState extends State<CadastroClienteListScreen> {
  final control = ClienteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CadastroClienteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Cliente>>(
        future: control.loadList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar usuários: ${snapshot.error}'),
            );
          }

          final clientes = snapshot.data ?? [];

          if (clientes.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];
              return ListTile(
                title: Text(cliente.nome),
                subtitle: Text('ID: ${cliente.id}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CadastroClienteScreen()),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
