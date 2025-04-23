import 'package:signclock/model/phone_model.dart';

enum AppStatus {
  identified,
  unidentified,
}

class AppState {
  AppStatus _status;
  PhoneModel? _phone;
  String? _token; // Nueva propiedad para el token
  late void Function(AppState) _onChange;

  static late AppState _singleton;

  factory AppState() {
    return _singleton;
  }

  AppState.init(
      {required AppStatus status, PhoneModel? phoneModel, String? token})
      : _status = AppStatus.unidentified {
    _singleton = this;
  }

  static hydrate(AppState oldAppState) {
    _singleton = oldAppState;
  }

  void subscribe(void Function(AppState) onChange) {
    _onChange = onChange;
  }

  void authenticate(PhoneModel telInfo, String token) {
    _status = AppStatus.identified;
    _phone = telInfo;
    _token = token; // Establecemos el token al autenticar
    _onChange(this);
  }

  void unAuthenticate() {
    _status = AppStatus.unidentified;
    _phone = null;
    _token = null; // Limpiamos el token al desautenticar
    _onChange(this);
  }

  AppStatus get status => _status;
  PhoneModel? get phone => _phone;
  String? get token => _token; // Getter para el token
}
