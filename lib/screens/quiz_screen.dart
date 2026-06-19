import 'package:flutter/material.dart';
import '../data/questions.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;

  void _selectAnswer(int index) {
    if (_selectedAnswer != null) return;
    setState(() {
      _selectedAnswer = index;
      if (index == questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: _score,
            total: questions.length,
          ),
        ),
      );
    }
  }

  Color _getButtonColor(int index) {
    if (_selectedAnswer == null) return const Color(0xFF16213E);
    if (index == questions[_currentIndex].correctIndex) {
      return const Color(0xFF4CAF50);
    }
    if (index == _selectedAnswer) return const Color(0xFFF44336);
    return const Color(0xFF16213E);
  }

  Color _getBorderColor(int index) {
    if (_selectedAnswer == null) return Colors.white24;
    if (index == questions[_currentIndex].correctIndex) {
      return const Color(0xFF4CAF50);
    }
    if (index == _selectedAnswer) return const Color(0xFFF44336);
    return Colors.white24;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentIndex];
    final progress = (_currentIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Question ${_currentIndex + 1} / ${questions.length}',
          style: const TextStyle(color: Colors.white54, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFF16213E),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF4CAF50),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ...List.generate(question.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed:
                      _selectedAnswer == null ? () => _selectAnswer(i) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getButtonColor(i),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _getButtonColor(i),
                    disabledForegroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: _getBorderColor(i)),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    question.options[i],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
            const Spacer(),
            if (_selectedAnswer != null)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentIndex < questions.length - 1
                      ? 'Question suivante'
                      : 'Voir les résultats',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
