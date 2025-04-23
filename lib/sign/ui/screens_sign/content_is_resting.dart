import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signclock/sign/bloc_location/location_bloc.dart';
import 'package:signclock/sign/ui/widgets/sign_button.dart';
import 'package:signclock/constant/theme.dart';

class ContentIsResting extends StatelessWidget {
  const ContentIsResting({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: SignButton(
            voidCallback: () =>
                context.read<LocationBloc>().add(ReturnWorkingEvent()),
            sizeWH: size.width * 0.3,
            icono: Icons.mode_of_travel,
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor,
                width: 2.0,
              ),
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "En descanso",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
