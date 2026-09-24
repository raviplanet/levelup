import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const QuizScreen(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'q': 'Which format does Google Play accept for production builds?',
      'options': ['.apk', '.exe', '.aab', '.ipa'],
      'a': 2,
    },
    {
      'q': 'What track should you use for initial testing on Google Play Console?',
      'options': ['Production', 'Internal Testing', 'Open Testing', 'Direct Link'],
      'a': 1,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentIndex]['a']) {
      _score++;
    }
    setState(() {
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QMind Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex < _questions.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question ${_currentIndex + 1}/${_questions.length}',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _questions[_currentIndex]['q'] as String,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    (_questions[_currentIndex]['options'] as List<String>).length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
                        onPressed: () => _answerQuestion(index),
                        child: Text(_questions[_currentIndex]['options'][index]),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Quiz Completed!\nScore: $_score/${_questions.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _currentIndex = 0;
                        _score = 0;
                      }),
                      child: const Text('Restart Quiz'),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}