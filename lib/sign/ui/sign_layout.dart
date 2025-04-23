import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/constant/assets.dart';
import 'package:signclock/constant/theme.dart';
import 'package:signclock/model/phone_model.dart';

import 'package:signclock/sign/bloc_location/location_bloc.dart';
import 'package:signclock/sign/ui/screens_sign/content_is_outside.dart';
import 'package:signclock/sign/ui/screens_sign/content_is_resting.dart';
import 'package:signclock/sign/ui/screens_sign/content_is_working.dart';

import 'screens_sign/content_loading.dart';
import 'datetime_dialog.dart';

class SignLayout extends StatelessWidget {
  const SignLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final newHeight = size.height - padding.top - padding.bottom;
    final hydratedInfo = context.read<AuthHyBloc>().state.user!;

    context.read<LocationBloc>().add(InitEvent());

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: newHeight,
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: <Widget>[
              _buildBackground(newHeight, size.width),
              Column(
                children: [
                  _buildLogo(newHeight, size.width),
                  Flexible(
                    child: _buildContent(
                        context, newHeight, size.width, hydratedInfo),
                  ),
                  _buildClock(newHeight),
                ],
              ),
              Positioned(
                  right: 20, bottom: 20, child: _buildManualSignButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(double newHeight, double width) {
    return Container(
      height: newHeight * 0.55,
      width: width,
      color: kPrimaryColor,
    );
  }

  Widget _buildLogo(double height, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height * 0.12,
        width: width * 0.5,
        child: Image.asset(Assets.logoBlancoS),
      ),
    );
  }

  Widget _buildContent(BuildContext context, double height, double width,
      PhoneModel hydratedInfo) {
    return SizedBox(
      height: height * 0.5,
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.status == LocationStateStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Ha ocurrido un error: ${state.errorMessage}"),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case LocationStateStatus.working:
              return const ContentIsWorking();
            case LocationStateStatus.resting:
              return const ContentIsResting();
            case LocationStateStatus.loading:
              return const ContentLoading();
            default:
              return ContentIsOutside(
                newHeight: height,
                width: width,
                myHydraInfo: hydratedInfo,
              );
          }
        },
      ),
    );
  }

  Widget _buildClock(double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: height * 0.1,
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                DateFormat('HH:mm').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 37.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildManualSignButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () =>
          showDateTimeDialog(context, context.read<AuthHyBloc>().state.user!),
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      label: const Text(
        'Declarar\nfichaje',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
