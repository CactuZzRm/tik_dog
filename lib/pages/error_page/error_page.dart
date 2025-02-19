import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Произошла ошибка'),
            const SizedBox(height: 20),
            TextButton(onPressed: () => context.replace('/'), child: const Text('Вернуться к авторизации')),
          ],
        ),
      ),
    );
  }
}
