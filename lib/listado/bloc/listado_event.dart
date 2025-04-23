part of 'listado_bloc.dart';

@immutable
abstract class ListadoEvent extends Equatable {
  const ListadoEvent();
  @override
  List<Object> get props => [];
}

class LoadListadoEvent extends ListadoEvent {}
