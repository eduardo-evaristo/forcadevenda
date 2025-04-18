import 'package:flutter/material.dart';
import 'package:projeto/cadastroUsuarioScreen.dart';
import 'package:projeto/controladoraUsuario.dart';
// import 'usuario.dart'; // Assuming Usuario is defined here

class CadastroUsuarioListScreen extends StatefulWidget {
  const CadastroUsuarioListScreen({super.key});

  @override
  State<CadastroUsuarioListScreen> createState() =>
      _CadastroUsuarioListScreenState();
}

class _CadastroUsuarioListScreenState extends State<CadastroUsuarioListScreen> {
  final control = UsuarioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Usuario>>(
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

          final usuarios = snapshot.data ?? [];

          if (usuarios.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }

          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return ListTile(
                title: Text(usuario.nome),
                subtitle: Text('ID: ${usuario.id}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Cadastrousuarioscreen()),
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
