
class CurrentLocationFailure implements Exception {
  CurrentLocationFailure({
    required this.error,
  });

  final String error;

}