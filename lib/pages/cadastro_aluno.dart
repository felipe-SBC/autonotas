import 'package:flutter/material.dart';

class CadastroAluno extends StatefulWidget {
  const CadastroAluno({Key? key}) : super(key: key);

  @override
  State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _Logo(),
                  _FormCadastro(),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: const [
                    Expanded(child: _Logo()),
                    Expanded(
                      child: Center(child: _FormCadastro()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: isSmallScreen ? 100 : 200,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShaderMask(
            shaderCallback: (bounds) => _createGradientShader(bounds),
            child: Text(
              "Cadastro de Aluno",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 24 : 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Shader _createGradientShader(Rect bounds) {
    return LinearGradient(
      colors: [
        Colors.blue,
        Colors.purple,
        Colors.pink,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds);
  }
}

class _FormCadastro extends StatefulWidget {
  const _FormCadastro({Key? key}) : super(key: key);

  @override
  State<_FormCadastro> createState() => __FormCadastroState();
}

class __FormCadastroState extends State<_FormCadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void janelaAlerta(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    var alerta = AlertDialog(
      actions: [okButton],
      title: const Text("Cadastro"),
      content: const Text("Cadastro realizado com sucesso"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de Nome
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                hintText: 'Nome Completo',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            // Campo de Curso
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu curso';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Curso',
                hintText: 'Nome do Curso',
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            // Campo de RA
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu RA';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'RA',
                hintText: 'Registro Acadêmico',
                prefixIcon: Icon(Icons.confirmation_number),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            // Campo de Email
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Por favor, insira um e-mail válido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'E-mail',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            // Campo de Senha
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                if (value.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Senha',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),

            // Botão de Cadastrar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    janelaAlerta(context); // Chama a função corretamente
                  }
                },
              ),
            ),
            _gap(),

            // Link para Login
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Já tem uma conta? Faça login!',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
