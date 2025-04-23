import 'package:flutter/material.dart';

class SignErrorWidget extends StatelessWidget {
  const SignErrorWidget({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 36.0,
          color: Colors.red,
        ),
        const SizedBox(
          height: 18.0,
        ),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}