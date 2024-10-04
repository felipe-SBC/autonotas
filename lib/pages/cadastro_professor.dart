import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para manipulação de datas

class CadastroProfessor extends StatefulWidget {
  const CadastroProfessor({Key? key}) : super(key: key);

  @override
  State<CadastroProfessor> createState() => _CadastroState();
}

class _CadastroState extends State<CadastroProfessor> {
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
              "Cadastro",
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
  final TextEditingController _dateController = TextEditingController();

  void janelaAlerta(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    var alerta = AlertDialog(
      actions: [okButton],
      title: Text("Cadastro"),
      content: Text("Cadastro realizado com sucesso"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
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

            // Campo de Data de Nascimento
            TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                _selectDate(context); // Chama o método _selectDate
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua data de nascimento';
                }

                // Tenta converter a string em um objeto DateTime
                try {
                  final dateOfBirth = DateFormat('dd/MM/yyyy').parse(value);
                  final now = DateTime.now();

                  // Verifica se a data de nascimento é maior ou igual a hoje
                  if (dateOfBirth.isAfter(now)) {
                    return 'A data de nascimento não pode ser no futuro';
                  }
                } catch (e) {
                  return 'Formato de data inválido. Use DD/MM/AAAA';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Data de Nascimento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            // Campo de Telefone
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu telefone';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: '(XX) XXXX-XXXX',
                prefixIcon: Icon(Icons.phone_outlined),
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
                    janelaAlerta(context);
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
