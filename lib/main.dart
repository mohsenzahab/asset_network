import 'package:bloc/bloc.dart';
import 'locator.dart';
import 'package:flutter/material.dart';
import 'presentation/app/app.dart';
import 'presentation/app/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppObserver();
  await initBlocsAndDependencies();
  runApp(const App());
}
