import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/models/user_model.dart' as app_data;

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        actions: [
          // Botão Logout
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
          ),

          // Nome
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
          ),

          // Celular
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
          ),

          // CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),

          // Botão Atualizar Senha
          SizedBox(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('data'),
            ),
          ),
        ],
      ),
    );
  }
}
