import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String studentClass = '';
  String teacherName = '';
  double p1 = 0.0;
  double p2 = 0.0;
  double average = 0.0;
  String feedback = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    // Substitua pelo endpoint da sua API
    final url = Uri.parse('https://suaapi.com/aluno/1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          studentClass = data['studentClass'];
          teacherName = data['teacherName'];
          p1 = data['p1'];
          p2 = data['p2'];
          average = (p1 + p2) / 2;
          feedback = data['feedback'];
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar os dados');
      }
    } catch (error) {
      print('Erro: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Aluno'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sala do Aluno: $studentClass',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Nome do Professor: $teacherName',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Nota P1: $p1', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Nota P2: $p2', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Média: $average',
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                  SizedBox(height: 10),
                  Text('Feedback: $feedback',
                      style: TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
    );
  }
}
