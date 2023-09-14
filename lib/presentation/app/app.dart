import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../core/utils/api_data.dart';
import '../../locator.dart';
import '../blocs/asset_basket/asset_cubit.dart';
import '../screens/asset_basket/asset_basket.dart';
import '../screens/stock_basket/stock_basket.dart';
import 'bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: sl()),
        BlocProvider<AssetCubit>.value(value: sl()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          initialRoute: 'sabad-darai?id=12',
          // builder: (context, child) {
          //   return child!;
          // },
          // onGenerateInitialRoutes: (route) {
          //   if (route != 'sabad-darai') {
          //     log('unknown route.');
          //   }
          //   log('route str: ${route}');

          //   return [
          //     MaterialPageRoute(
          //       settings: RouteSettings(),
          //       builder: (context) => SabadDarai(),
          //     )
          //   ];
          // },
          onGenerateRoute: (settings) {
            const apiKey =
                '''13951-xnCFCdfEZFRxyBvqdkAkpEiPxThUDytSvzlxJBCTgOiujRGtGm''';
            const baseUrl = 'https://api.moneytoo.ir/api/';
            sl<ApiData>().init(
              apiKey: apiKey,
              baseUrl: baseUrl,
              userProfileId: 94181,
            );

            const mode = ThemeMode.light;
            const font = 'IRANSans';
            const locale = Locale('fa', 'IR');
            // const route = 'stockBasket';
            const route = 'assetBasket';
            BlocProvider.of<AppBloc>(context)
                .initData(fontFamily: font, themeMode: mode, locale: locale);
            if (route == 'assetBasket') {
              return MaterialPageRoute(
                settings: const RouteSettings(name: 'assetBasket'),
                builder: (context) => const AssetBasketTabContent(),
              );
            } else if (route == 'stockBasket') {
              return MaterialPageRoute(
                settings: const RouteSettings(name: 'stockBasket'),
                builder: (context) => const StockBasketTabContent(),
              );
            }
          },
          locale: state.locale,
          supportedLocales: const [Locale('fa', 'IR'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          //TODO: add dark theme to darkTheme parameter
          // themeMode: ,
          // darkTheme: ,
          theme: state.theme,
        );
      },
    );
  }
}
