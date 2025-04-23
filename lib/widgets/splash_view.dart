import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashView());
  }

  static Page<void> page() => const MaterialPage<void>(child: SplashView());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
