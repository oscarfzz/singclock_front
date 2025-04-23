class AppError {
  final String message;
  const AppError(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class ValidationError extends AppError {
  const ValidationError(super.message);
}