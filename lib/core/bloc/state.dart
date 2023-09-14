import 'package:equatable/equatable.dart';

enum BlocStatus {
  loading,
  success,
  ready,
  failure,
  empty;

  bool get isLoading => this == BlocStatus.loading;

  bool get isSuccess => this == BlocStatus.success;
  bool get isReady => this == BlocStatus.ready;

  bool get isFailure => this == BlocStatus.failure;

  bool get isEmpty => this == BlocStatus.empty;
}

abstract class BlocState extends Equatable {
  const BlocState(this.status, {this.message});
  final BlocStatus status;
  final String? message;

  /// returns a new [BlocState] with this states data but
  /// replaced with provided values
  BlocState copyWith(BlocStatus status, {String? message});
}
