import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signclock/api_services/sign_services.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/phone_model.dart';
import 'package:signclock/model/sign_model.dart';
import 'package:signclock/sign/location_repo/location_repository.dart';

void showDateTimeDialog(BuildContext context, PhoneModel phoneModel) {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final locationRepository = LocationRepository();

  _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  // set time to 14:00
  _timeController.text = '14:00';
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
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Día'),
              ),
              TextField(
                controller: _timeController,
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
                  final dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                      '${_dateController.text} ${_timeController.text}:00');
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

                  final authBloc = BlocProvider.of<AuthHyBloc>(context);
                  final signServices = SignServices(authBloc);

                  final response = await signServices.postSign(
                    dataPost,
                  );

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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}
