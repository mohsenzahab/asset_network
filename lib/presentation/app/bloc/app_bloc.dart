import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl_date_picker/intl_date_picker.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/theme_generator.dart';

import '../../../core/enums/currency_type.dart';
import '../../../core/localization/localizations.dart';
import 'app_status.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  /// Whenever theme and locale changes, [colors] and [localizations] are used
  /// in order to update apps settings.
  AppBloc(IColors colors, ILocalizations localizations)
      : super(AppState(colors, AppStatus.ready(),
            calendar: Calendar.jalali,
            themeMode: ThemeMode.light,
            fontFamily: 'Titr',
            mainPreferredCurrency: CurrencyType.toman,
            preferredCurrencies: [
              CurrencyType.dollar,
              CurrencyType.toman,
              CurrencyType.rial
            ],
            locale: const Locale('fa', 'IR'))) {
    // when app base data like locale or theme changes, this handler will
    // be triggered
    on<AppBaseDataChanged>((event, emit) async {
      bool themeChanged = state.themeMode != event.themeMode;
      bool localeChanged = state.locale != event.locale;
      if (themeChanged || localeChanged) {
        emit(state.copyWith(AppStatus.loading()));
      }

      await _loadChanges(
          themeChanged, colors, event, localeChanged, localizations);

      emit(state.copyWith(
        AppStatus.ready(),
        fontFamily: event.fontFamily,
        locale: event.locale,
        themeMode: event.themeMode,
      ));
    });
  }

  // @override
  // void onChange(Change<AppState> change) {
  //   super.onChange(change);
  //   debugPrint(change.toString());
  //   debugPrint(change.currentState.toString());
  //   debugPrint(change.nextState.toString());
  // }

  Future<void> _loadChanges(
      bool themeChanged,
      IColors colors,
      AppBaseDataChanged event,
      bool localeChanged,
      ILocalizations localizations) async {
    await Future.wait([
      if (themeChanged) colors.load(event.themeMode),
      if (localeChanged) localizations.load(event.locale),
    ]);
  }

  void initialize(IColors colors, ILocalizations localizations) {
    Future.wait([
      colors.load(state.themeMode),
      localizations.load(state.locale),
    ]);
  }

  /// Initializes app bloc with the first base data that comes from initial route.
  void initData(
      {required Locale locale,
      required ThemeMode themeMode,
      required String fontFamily}) {
    add(AppEvent.baseDataChanged(
        themeMode: themeMode, locale: locale, fontFamily: fontFamily));
  }
}
