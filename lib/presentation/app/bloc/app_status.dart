import 'package:equatable/equatable.dart';

abstract class AppStatus extends Equatable {
  const AppStatus();
  factory AppStatus.loading() => AppLoading();
  factory AppStatus.ready() => AppReady();
  factory AppStatus.error(String message) => AppError(message);
  @override
  List<Object?> get props => [];
}

class AppLoading extends AppStatus {}

class AppError extends AppStatus {
  const AppError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class AppReady extends AppStatus {}
