import 'package:flutter/cupertino.dart';
import 'package:signclock/sign/location_repo/current_user_location_entity.dart';

class SignSuccessWidget extends StatefulWidget {
  final CurrentUserLocationEntity currentUserLocation;

  const SignSuccessWidget({
    super.key,
    required this.currentUserLocation,
  });

  @override
  State<SignSuccessWidget> createState() => _SignSuccessWidgetState();
}

class _SignSuccessWidgetState extends State<SignSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("success"));
  }
}
