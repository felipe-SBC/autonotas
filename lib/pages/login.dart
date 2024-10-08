import 'package:flutter/material.dart';
import 'aluno.dart'; // Importa o arquivo onde está a página de perfil
import 'cadastro_professor.dart'; // Importa a página de cadastro
import 'cadastro_aluno.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variável para controlar o tipo de usuário selecionado
  String _userType = 'Aluno'; // Valor inicial padrão

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _Logo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _userTypeSelection(),
                  ),
                  const _FormContent(),
                  // Adicionando o link "Cadastre-se"
                  _cadastreSeLink(context),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    const Expanded(child: _Logo()),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: _userTypeSelection(),
                          ),
                          const _FormContent(),
                          // Adicionando o link "Cadastre-se"
                          _cadastreSeLink(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // Método que retorna o Widget de seleção de usuário (Aluno ou Professor)
  Widget _userTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'Aluno',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),
            const Text('Aluno'),
          ],
        ),
        const SizedBox(width: 20), // Espaçamento entre os botões
        Row(
          children: [
            Radio<String>(
              value: 'Professor',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),
            const Text('Professor'),
          ],
        ),
      ],
    );
  }

  // Link para a página "Cadastre-se"
  Widget _cadastreSeLink(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton(
        onPressed: () {
          // Verifica o tipo de usuário e navega para a página correspondente
          if (_userType == "Professor") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastroProfessor()),
            );
          } else if (_userType == "Aluno") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CadastroAluno()), // Altere aqui para sua classe de cadastro de aluno
            );
          } else {
            // Aqui você pode tratar o caso em que _userType não é nem "Professor" nem "Aluno"
            // Por exemplo, mostrar um alerta ou uma mensagem
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tipo de usuário inválido!'),
              ),
            );
          }
        },
        child: const Text(
          'Cadastre-se',
          style: TextStyle(
            color: Colors.blue, // Cor do texto "Cadastre-se"
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
              "Auto Notas",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 24 : 32,
                color: Colors.white, // O ShaderMask sobrescreverá essa cor
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

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  void janelaAlerta(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Aluno()),
        );
      },
    );
    var alerta = AlertDialog(
      actions: [okButton],
      title: Text("Login"),
      content: Text("Login Realizado com sucesso"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira algum texto';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Por favor, insira um email válido';
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
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira algum texto';
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
                    'Entrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  janelaAlerta(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
