import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../sign/ui/sign_page.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(0, SignPage()));

  void navigateTo(int index, Widget body) {
    emit(NavigationState(index, body));
  }
}
