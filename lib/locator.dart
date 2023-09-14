import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'core/utils/api_data.dart';
import 'data/datasources/local/asset_provider.dart';
import 'data/datasources/remote/basket_api.dart';
import 'data/repositories/basket_repository.dart';
import 'domain/usecases/baskets/asset_basket/delete_asset.dart';
import 'domain/usecases/baskets/asset_basket/edit_fixed_asset.dart';
import 'domain/usecases/baskets/asset_basket/get_local_assets.dart';
import 'presentation/app/bloc/app_bloc.dart';
import 'core/localization/localizations.dart';
import 'core/utils/colors.dart';
import 'data/datasources/local/services/database.dart';
import 'domain/usecases/baskets/asset_basket/edit_current_asset.dart';
import 'domain/usecases/baskets/create_basket.dart';
import 'domain/usecases/current_asset_form/save_current_asset.dart';
import 'domain/usecases/fixed_asset_form/save_fixed_asset.dart';
import 'domain/usecases/search_stock.dart';
import 'presentation/blocs/asset_basket/asset_cubit.dart';

final sl = GetIt.instance;

/// will initialize app dependencies
Future<void> initBlocsAndDependencies() async {
  await _registerAppSettings();
  await _registerServices();
  _registerDataProviders();
  _registerRepositories();
  _registerUsecases();
  _registerBlocs();
}

Future<void> _registerAppSettings() async {
  sl.registerSingleton(await IColors().load(ThemeMode.light));
  sl.registerSingleton(await ILocalizations().load(const Locale('fa', 'IR')));
  sl.registerSingleton(ApiData());
}

Future<void> _registerServices() async {
  sl.registerSingleton(await DB.db);
}

void _registerDataProviders() {
  sl.registerSingleton(BasketProviderImpl(sl()));
  sl.registerSingleton(AssetLocalProviderImpl(sl()));
}

void _registerRepositories() =>
    sl.registerSingleton(BasketRepositoryImpl(sl<BasketProviderImpl>(), sl()));

void _registerUsecases() {
  sl.registerLazySingleton(() => CreateBasket(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(() => SearchStock(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(() => SaveFixedAsset(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(() => SaveCurrentAsset(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(() => GetLocalAssets(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(
      () => DeleteAssetUsecase(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(
      () => EditFixedAssetUsecase(sl<BasketRepositoryImpl>()));
  sl.registerLazySingleton(
      () => EditCurrentAssetUsecase(sl<BasketRepositoryImpl>()));
}

void _registerBlocs() {
  sl.registerSingleton(AppBloc(sl(), sl()));
  sl.registerLazySingleton(() => AssetCubit(sl(), sl(), sl()));
}
