import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/sign/bloc_location/location_bloc.dart';

import 'package:signclock/constant/theme.dart';

class ContentLoading extends StatelessWidget {
  const ContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 7.0,
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: kPrimaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: const Text(
            "Cargando...",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        FloatingActionButton(
            onPressed: () => context.read<LocationBloc>().add(CancelEvent()))
      ],
    );
  }
}
