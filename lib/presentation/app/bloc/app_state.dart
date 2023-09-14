part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState(
    this.colors,
    this.status, {
    required this.calendar,
    required this.locale,
    required this.themeMode,
    required this.fontFamily,
    required this.mainPreferredCurrency,
    required this.preferredCurrencies,
  });
  final IColors colors;
  final AppStatus status;
  final ThemeMode themeMode;
  final Locale locale;
  final String fontFamily;
  final List<CurrencyType> preferredCurrencies;
  final CurrencyType mainPreferredCurrency;
  final Calendar calendar;

  @override
  List<Object> get props => [
        status,
        themeMode,
        locale,
        fontFamily,
        mainPreferredCurrency,
        preferredCurrencies
      ];

  AppState copyWith(AppStatus status,
          {ThemeMode? themeMode,
          Locale? locale,
          String? fontFamily,
          List<CurrencyType>? preferredCurrencies,
          CurrencyType? mainPreferredCurrency,
          Calendar? calendar}) =>
      AppState(
        colors,
        status,
        fontFamily: fontFamily ?? this.fontFamily,
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
        mainPreferredCurrency:
            mainPreferredCurrency ?? this.mainPreferredCurrency,
        preferredCurrencies: preferredCurrencies ?? this.preferredCurrencies,
        calendar: calendar ?? this.calendar,
      );

  ThemeData get theme => ThemeGenerator(colors)
      .generateTheme(mode: themeMode, fontFamily: fontFamily);
}
