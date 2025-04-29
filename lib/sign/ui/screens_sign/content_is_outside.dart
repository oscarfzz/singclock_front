import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signclock/model/phone_model.dart';
import 'package:signclock/sign/bloc_location/location_bloc.dart';
import 'package:signclock/sign/ui/widgets/sign_button.dart';

class ContentIsOutside extends StatelessWidget {
  final double newHeight;
  final double width;
  final PhoneModel? myHydraInfo;

  const ContentIsOutside({
    super.key,
    required this.newHeight,
    required this.width,
    required this.myHydraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 2,
          child: SignButton(
            voidCallback: () =>
                context.read<LocationBloc>().add(InitWorkingEvent()),
            sizeWH: newHeight * 0.17,
            icono: Icons.where_to_vote,
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              myHydraInfo?.groupName ?? "Sin grupo",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Flexible(
        //   flex: 1,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: kPrimaryColor,
        //         width: 2.0,
        //       ),
        //       color: kPrimaryColor.withOpacity(0.9),
        //       borderRadius: const BorderRadius.all(Radius.circular(30)),
        //     ),
        //     child: const Text(
        //       "Estás fuera de hora",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.w400,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        const Spacer(), // Añade espacio flexible al final
      ],
    );
  }
}
