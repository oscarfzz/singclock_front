part of 'listado_bloc.dart';

@immutable
abstract class ListadoState extends Equatable {
  const ListadoState();

  @override
  List<Object?> get props => [];
}

class ListadoInitialState extends ListadoState {}

class ListadoLoadingState extends ListadoState {
  @override
  List<Object?> get props => [];
}

// class ListadoLoadedState extends ListadoState {
//   final List<RegFiModel> signList;

//   const ListadoLoadedState(this.signList);
// }

class ListadoLoadedState extends ListadoState {
  final List<RegFiModel> signList;

  const ListadoLoadedState(this.signList);

  @override
  List<Object?> get props => [signList];
}

class ListadoErrorState extends ListadoState {
  final String? message;
  const ListadoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ListadoEmptyState extends ListadoState {
  final String message;

  const ListadoEmptyState(this.message);

  @override
  List<Object?> get props => [message];
}
