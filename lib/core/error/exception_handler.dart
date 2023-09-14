import 'dart:developer';
import 'exceptions.dart';
import 'failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// If there is exception, handles them and turns theme to [Failure]. If  no exceptions occurred, returns the passed function result.
Future<Either<Failure, T>> handleExceptionsAsync<T>(Future<T> Function() future,
    {VoidCallback? onNoException}) async {
  try {
    final result = await future();
    onNoException?.call();
    return Right(result);
  } on ServerException catch (e) {
    log(e.toString());
    return Left(ServerFailure(errCode: e.errCode, message: e.message));
  } on NetworkException catch (e) {
    log(e.toString());
    return Left(NetworkFailure(errCode: e.errCode, message: e.message));
  } on LocalException catch (e) {
    return Left(LocalFailure(errCode: e.errCode, message: e.message));
  } catch (e) {
    rethrow;
  }
}

/// If there is exception, handles them and turns theme to [Failure]. If  no exceptions occurred, returns the passed function result.
Either<Failure, T> handleExceptions<T>(T Function() future,
    {VoidCallback? onNoException}) {
  try {
    final result = future();
    onNoException?.call();
    return Right(result);
  } on ServerException catch (e) {
    log(e.toString());
    return Left(ServerFailure(errCode: e.errCode, message: e.message));
  } on NetworkException catch (e) {
    log(e.toString());
    return Left(NetworkFailure(errCode: e.errCode, message: e.message));
  } on LocalException catch (e) {
    return Left(LocalFailure(errCode: e.errCode, message: e.message));
  } catch (e) {
    rethrow;
  }
}
