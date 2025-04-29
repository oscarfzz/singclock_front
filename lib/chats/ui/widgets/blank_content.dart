import 'package:flutter/material.dart';

class BlankContent extends StatelessWidget {
  final String? content;
  final bool? isLoading;
  final IconData? icon;

  const BlankContent({super.key, this.content, this.isLoading, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLoading != null && isLoading == true
            ? const [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                )
              ]
            : [
                Icon(
                  icon ?? Icons.receipt,
                  size: 80.0,
                  color: Theme.of(context).hintColor.withValues(alpha: 102),
                ),
                Text(
                  content ?? "Aqui nada",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).highlightColor.withValues(alpha: 102),
                  ),
                ),
              ],
      ),
    );
  }
}
