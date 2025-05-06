import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:signclock/api_services/listings_service.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/models/regfi_model.dart';

part 'listado_event.dart';
part 'listado_state.dart';

class ListadoBloc extends Bloc<ListadoEvent, ListadoState> {
  final AuthHyBloc authHyBloc;
  late final ListingService _listingService;

  ListadoBloc({
    required this.authHyBloc,
    required ListingService listingService,
  })  : _listingService = listingService,
        super(ListadoInitialState()) {
    on<LoadListadoEvent>(_handleLoadListado);
  }

  Future<void> _handleLoadListado(
    LoadListadoEvent event,
    Emitter<ListadoState> emit,
  ) async {
    // Verificar autenticación
    if (!await _validateAuth(emit)) return;

    emit(ListadoLoadingState());

    try {
      final phoneInfoData = authHyBloc.state.user!;
      final listRegs = await _listingService.getRegs(phoneInfoData);

      if (listRegs.status == "error") {
        // Error que emite el servidor desde la API
        emit(ListadoErrorState(listRegs.msg));
      } else if (listRegs.data == null || listRegs.data!.isEmpty) {
        emit(const ListadoEmptyState("La lista de registros está vacía"));
      } else {
        emit(ListadoLoadedState(listRegs.data!));
      }
    } catch (e) {
      emit(ListadoErrorState("Error inesperado: ${e.toString()}"));
    }
  }

  Future<bool> _validateAuth(Emitter<ListadoState> emit) async {
    if (!authHyBloc.state.isAuthenticated) {
      emit(const ListadoErrorState("Error: No autenticado"));
      return false;
    }

    if (authHyBloc.state.user == null) {
      emit(const ListadoErrorState(
          "Error: Información del usuario no disponible"));
      return false;
    }

    return true;
  }
}
