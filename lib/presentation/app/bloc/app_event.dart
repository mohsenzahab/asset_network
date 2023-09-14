part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  factory AppEvent.baseDataChanged(
          {required ThemeMode themeMode,
          required Locale locale,
          required String fontFamily}) =>
      AppBaseDataChanged(themeMode, locale, fontFamily);

  @override
  List<Object> get props => [];
}

class AppBaseDataChanged extends AppEvent {
  const AppBaseDataChanged(this.themeMode, this.locale, this.fontFamily);
  final ThemeMode themeMode;
  final Locale locale;
  final String fontFamily;
}
