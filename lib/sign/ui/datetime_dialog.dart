import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signclock/api_services/sign_services.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/models/phone_model.dart';
import 'package:signclock/models/sign_model.dart';
import 'package:signclock/sign/location_repo/location_repository.dart';

void showDateTimeDialog(BuildContext context, PhoneModel phoneModel) {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final locationRepository = LocationRepository();

  dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  // set time to 14:00
  timeController.text = '14:00';
  //  // V2
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Declara un fichaje'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Día'),
              ),
              TextField(
                controller: timeController,
                decoration:
                    const InputDecoration(labelText: 'Hora', hintText: 'HH:MM'),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final authBloc = BlocProvider.of<AuthHyBloc>(context);

                  final dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                      '${dateController.text} ${timeController.text}:00');
                  final formattedDateTime =
                      DateFormat('dd-MM-yyyy - HH:mm:ss').format(dateTime);
                  final currentUserLocation =
                      await locationRepository.getCurrentLocation().timeout(
                            const Duration(seconds: 10),
                            onTimeout: () => throw 'Location timeout limit',
                          );
                  final dataPost = SignModel.fromJson({
                    'phone_id': phoneModel.phoneId,
                    'group_phone_id': phoneModel.groupPhoneId,
                    'currentdate': DateFormat('yyyy-MM-dd').format(dateTime),
                    'currenttime': DateFormat('HH:mm:ss').format(dateTime),
                    'lat': currentUserLocation.latitude,
                    'lon': currentUserLocation.longitude,
                    'validated': true,
                    'type': "DP", // DP = Declaración de Presencia
                  });

                  final signServices = SignServices(authBloc);

                  await signServices.postSign(dataPost);

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Selected date and time: $formattedDateTime'),
                    ),
                  );
                } catch (e) {
                  String errorMessage = 'An error occurred. $e';

                  if (e is TimeoutException) {
                    errorMessage = e.message!;
                  }

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                }

                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}
