import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_application/states/states.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login anonymously'),
              onPressed: () async {
                ref
                    .read(userAutnenticationProvider.notifier)
                    .signInAnonymously();
                if (context.mounted) context.go('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
