import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabad_darai/core/utils/common.dart';
import 'package:sabad_darai/presentation/blocs/asset_edit/property/property_asset_edit_cubit.dart';

import '../../../config/values/layout.dart';
import '../../../config/values/styles.dart';
import '../../../core/bloc/state.dart';
import '../../../core/enums/asset_category.dart';
import '../../../core/enums/personality.dart';
import '../../../core/enums/register_type.dart';
import '../../../core/localization/localizations.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/messenger.dart';
import '../../../core/utils/validator.dart';
import '../../../domain/entities/asset/fixed_asset/garden.dart';
import '../../../domain/entities/asset/fixed_asset/property.dart';
import '../../../domain/entities/asset/fixed_asset/residential_house.dart';
import '../../../domain/entities/asset/ownership.dart';
import '../../../domain/entities/location/location.dart';
import '../../../locator.dart';
import '../../app/bloc/app_bloc.dart';
import '../../widgets/form/custom_form_fields/multiline_text_form_field.dart';
import '../../widgets/form/custom_form_fields/number_form_field.dart';
import '../../widgets/form/form.dart';
import '../../widgets/form_section.dart';

class PropertyAssetEditScreen extends StatefulWidget {
  const PropertyAssetEditScreen({super.key, required this.asset});

  final Property asset;

  @override
  State<PropertyAssetEditScreen> createState() =>
      _PropertyAssetEditScreenState();
}

class _PropertyAssetEditScreenState extends State<PropertyAssetEditScreen> {
  late final GlobalKey<FormState> formKey;
  bool isChanged = false;

  String? title;
  Personality? personality;
  int? purchasePrice;
  int? currentPrice;
  int? salePrice;
  DateTime? purchaseDate;
  DateTime? saleDate;
  AssetOwnership? ownership;
  Province? province;
  City? city;
  District? district;
  String? mainStreet;
  String? bystreet;
  String? alley;
  String? plaque;
  int? floor;
  int? unit;
  String? moreDetails;
  Property get asset => widget.asset;

  @override
  void initState() {
    setInitialValues();
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  void setInitialValues() {
    title = asset.title;
    personality = asset.personality;
    purchasePrice = asset.purchasePrice;
    currentPrice = asset.currentPrice;
    salePrice = asset.salePrice;
    purchaseDate = asset.purchaseDate;
    saleDate = asset.saleDate;
    ownership = asset.ownership;
    province = asset.province;
    city = asset.city;
    district = asset.district;
    mainStreet = asset.mainStreet;
    bystreet = asset.bystreet;
    alley = asset.alley;
    plaque = asset.plaque;
    floor = asset.floor;
    unit = asset.unit;
    moreDetails = asset.moreDetails;
  }

  @override
  Widget build(BuildContext context) {
    final appData = BlocProvider.of<AppBloc>(context).state;
    final cubit = BlocProvider.of<PropertyAssetEditCubit>(context);

    final l = sl<ILocalizations>();
    final c = sl<IColors>();
    void registerSale() {
      cubit.registerType = RegisterType.sale;
      registerData(context, cubit);
    }

    void registerPurchase() {
      cubit.registerType = RegisterType.purchase;
      registerData(context, cubit);
    }

    void registerSellOrder() {
      cubit.registerType = RegisterType.sellOrder;
      registerData(context, cubit);
    }

    return Scaffold(
        appBar: AppBar(
          title:
              Text('${l('title_asset_info')} ${l(widget.asset.type.textId)}'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: kSizeIcon,
              )),
          // actions: [
          //   IconButton(
          //       color: c('iconDone'),
          //       onPressed: () => saveChanges(context),
          //       icon: const Icon(
          //         Icons.done,
          //         size: kSizeIcon,
          //       ))
          // ]
        ),
        body: BlocListener<PropertyAssetEditCubit, PropertyAssetEditState>(
          listener: (context, state) {
            if (state.status == BlocStatus.failure) {
              Messenger(context, l)
                  .showSnackBarFailure(state.message ?? 'Somethings wrong');
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormSection(
                    alignment: CrossAxisAlignment.start,
                    children: [
                      MTextFormField(
                          initialValue: title,
                          label: l('title_asset_registration'),
                          onSaved: (newValue) => title = newValue,
                          validator: (value) => Validator.requiredValidate(
                              value, l('validate_title'))),
                      kSpaceVertical16,
                      ChoiceChips<Personality>(
                        title: l('personality'),
                        initialValue: personality,
                        choices: const [
                          Personality.private,
                          Personality.juridical,
                        ],
                        asString: (personality) => l(personality.name),
                        onSelected: (newValue) {
                          if (newValue == Personality.juridical) {
                            return false;
                          }
                          personality = newValue;
                          return true;
                        },
                      ),
                      kSpaceVertical16,
                      Row(
                        children: [
                          Expanded(
                            child: NumberFormField(
                              label: l('purchase_price', [
                                '(${l(appData.mainPreferredCurrency.name)})'
                              ]),
                              initialValue: purchasePrice,
                              onSaved: (newValue) => purchasePrice = newValue,
                              validator: (value) {
                                if (cubit.registerType ==
                                    RegisterType.purchase) {
                                  return Validator.requiredNumericValidate(
                                      value, l('validate_purchase_price'));
                                }
                                return null;
                              },
                            ),
                          ),
                          kSpaceHorizontal16,
                          Expanded(
                            child: NumberFormField(
                              label: l('sale_price', [
                                '(${l(appData.mainPreferredCurrency.name)})'
                              ]),
                              initialValue: salePrice,
                              onSaved: (newValue) => salePrice = newValue,
                              validator: (value) {
                                final type = cubit.registerType;
                                debugPrint(type?.name);
                                if (type == RegisterType.sale ||
                                    type == RegisterType.sellOrder) {
                                  return Validator.requiredNumericValidate(
                                      value, l('validate_sale_price'));
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      kSpaceVertical16,
                      DatePickerFormField(
                        title: l('purchase_date'),
                        calendar: appData.calendar,
                        initialValue: purchaseDate,
                        onChanged: (newValue) => purchaseDate = newValue,
                      ),
                      DatePickerFormField(
                        title: l('sale_date'),
                        calendar: appData.calendar,
                        initialValue: saleDate,
                        onChanged: (newValue) => saleDate = newValue,
                      ),
                      kSpaceVertical16,
                      SuggestionTextField<AssetOwnership>(
                          label: l('ownership'),
                          initialValue: ownership,
                          itemAsString: ((item) => item.title),
                          onSelected: (newValue) => ownership = newValue,
                          validator: (value) => Validator.requiredValidate(
                              value?.title, l('validate_ownership')),
                          getSuggestions: (query) async {
                            return <AssetOwnership>[
                              AssetOwnership(1, 'me'),
                              AssetOwnership(2, 'spouse'),
                              AssetOwnership(3, 'son'),
                              AssetOwnership(4, 'doughter'),
                              AssetOwnership(5, 'father'),
                            ];
                          }),
                    ],
                  ),
                  // kSpaceVertical16,
                  Text(l('location'), style: kStyleInputTitle),
                  const Divider(thickness: 2),
                  FormSection(children: [
                    Row(
                      children: [
                        Expanded(
                          child: SuggestionTextField<Province>(
                              label: l('province'),
                              initialValue: province,
                              itemAsString: ((item) => item.name),
                              onSelected: (newValue) => province = newValue,
                              validator: (value) => Validator.requiredValidate(
                                  value?.name, l('validate_province')),
                              getSuggestions: (query) async {
                                return [
                                  Province(1, 'Tehran'),
                                  Province(2, 'Fars'),
                                  Province(3, 'West Azarbayjan'),
                                  Province(4, 'Ilam'),
                                ];
                              }),
                        ),
                        kSpaceHorizontal16,
                        Expanded(
                          child: SuggestionTextField<City>(
                              label: l('city'),
                              initialValue: city,
                              itemAsString: ((item) => item.name),
                              onSelected: (newValue) => city = newValue,
                              validator: (value) => Validator.requiredValidate(
                                  value?.name, l('validate_city')),
                              getSuggestions: (query) async {
                                return [
                                  City(1, 'Tehran'),
                                  City(2, 'Shiraz'),
                                  City(3, 'Tabriz'),
                                  City(4, 'Urmia'),
                                ];
                              }),
                        )
                      ],
                    ),
                    kSpaceVertical16,
                    Row(
                      children: [
                        Expanded(
                          child: SuggestionTextField<District>(
                              label: l('district'),
                              // showSearch: true,
                              initialValue: district,
                              itemAsString: ((item) => item.name),
                              onSelected: (newValue) => district = newValue,
                              validator: (value) => Validator.requiredValidate(
                                  value?.name, l('validate_district')),
                              getSuggestions: (query) async {
                                return [
                                  District(1, 'Azadi'),
                                  District(2, 'Saat'),
                                  District(3, 'Kahrizak'),
                                  District(4, 'IslamAbad'),
                                ];
                              }),
                        ),
                        kSpaceHorizontal16,
                        Expanded(
                            child: MTextFormField(
                          label: l('main_street_name'),
                          initialValue: mainStreet,
                          keyboardType: TextInputType.streetAddress,
                          onSaved: (newValue) => mainStreet = newValue,
                          validator: (value) => Validator.requiredValidate(
                              value, l('validate_street')),
                        )),
                      ],
                    ),
                    kSpaceVertical16,
                    Row(
                      children: [
                        Expanded(
                          child: MTextFormField(
                            label: l('bystreet_name'),
                            initialValue: bystreet,
                            keyboardType: TextInputType.streetAddress,
                            onSaved: (newValue) => bystreet = newValue,
                            validator: (value) => Validator.requiredValidate(
                                value, l('validate_bystreet')),
                          ),
                        ),
                        kSpaceHorizontal16,
                        Expanded(
                            child: MTextFormField(
                                label: l('alley'),
                                initialValue: alley,
                                keyboardType: TextInputType.streetAddress,
                                onSaved: (newValue) => alley = newValue,
                                validator: (value) =>
                                    Validator.requiredValidate(
                                        value, l('validate_alley')))),
                      ],
                    ),
                    kSpaceVertical16,
                    Row(
                      children: [
                        Expanded(
                          child: MTextFormField(
                              label: l('plaque'),
                              initialValue: plaque,
                              onSaved: (newValue) => plaque = newValue,
                              validator: (value) => Validator.requiredValidate(
                                  value, l('validate_plaque'))),
                        ),
                        kSpaceHorizontal16,
                        Expanded(
                            child: NumberFormField(
                                label: l('floor'),
                                initialValue: floor,
                                onSaved: (newValue) => floor = newValue,
                                validator: (value) =>
                                    Validator.requiredNumericValidate(
                                        value, l('validate_floor')))),
                        kSpaceHorizontal16,
                        Expanded(
                            child: NumberFormField(
                          label: l('unit'),
                          initialValue: unit,
                          onSaved: (newValue) => unit = newValue,
                          validator: (value) =>
                              Validator.requiredNumericValidate(
                                  value, l('validate_unit')),
                        )),
                      ],
                    ),
                  ]),
                  Text(l('condition'), style: kStyleInputTitle),
                  const Divider(thickness: 2),
                  FormSection(
                    alignment: CrossAxisAlignment.stretch,
                    children: [
                      FilterChips<String>(
                          title: l('general_facilities'),
                          options: {
                            'elevator': false,
                            'balcony': false,
                            'telephone': false,
                          },
                          asString: (str) => l(str),
                          onChanged: (newValue) {}),
                      kSpaceVertical16,
                      ChoiceChips<String>(
                          title: l('parking'),
                          initialValue: 'have_not',
                          choices: ['have_not', '1', '2', '3'],
                          // onSelected: saveParking,
                          asString: (str) {
                            if (int.tryParse(str.trim()) != null) {
                              return MaterialLocalizations.of(context)
                                  .formatDecimal(int.parse(str));
                            }
                            return l(str);
                          }),
                      kSpaceVertical16,
                      ChoiceChips<String>(
                          title: l('water'),
                          initialValue: l('have_not'),
                          choices: [l('have_not'), l('separate_meter')],
                          // onSelected: saveWater,
                          asString: (str) => str),
                      ChoiceChips<String>(
                          title: l('gas'),
                          initialValue: l('have_not'),
                          // onSelected: saveGas,
                          choices: [l('have_not'), l('separate_meter')],
                          asString: (str) => str),
                      kSpaceVertical16,
                      MultilineTextFormField(
                          label: l('more_details'),
                          onSaved: (newValue) => moreDetails = newValue),
                    ],
                  ),
                  Text(l('unit_inside_facilities'), style: kStyleInputTitle),
                  const Divider(thickness: 2),
                  kSpaceVertical32,
                  kSpaceVertical32,

                  Text(l('nearby_facilities_and_access'),
                      style: kStyleInputTitle),
                  const Divider(thickness: 2),
                  kSpaceVertical32,
                  kSpaceVertical32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionChip(
                        label: Text(l('i_bought')),
                        backgroundColor: Colors.green,
                        onPressed: registerPurchase,
                      ),
                      ActionChip(
                        label: Text(l('i_sold')),
                        backgroundColor: Colors.red,
                        onPressed: registerSale,
                      ),
                      ActionChip(
                        label: Text(l('i_want_to_sell')),
                        backgroundColor: Colors.orange,
                        onPressed: registerSellOrder,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void registerData(BuildContext context, PropertyAssetEditCubit cubit) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    final editedAsset = _createAsset();
    cubit.updateFixedAsset(editedAsset!).then((isSuccess) {
      if (isSuccess) {
        Navigator.pop(context, editedAsset);
      }
    });
  }

  Property? _createAsset() {
    switch (asset.type) {
      case AssetCategory.residentialHouse:
        return ResidentialHouse(
            id: asset.id,
            title: title!,
            purchaseDate: purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: personality!,
            ownership: ownership!,
            salePrice: salePrice,
            saleDate: saleDate,
            purchasePrice: purchasePrice,
            currentPrice: currentPrice,
            province: province!,
            city: city!,
            district: district!,
            mainStreet: mainStreet!,
            bystreet: bystreet!,
            alley: alley!,
            plaque: plaque!,
            floor: floor!,
            unit: unit!,
            moreDetails: moreDetails);
      case AssetCategory.property:
        return Property(
            id: asset.id,
            title: title!,
            purchaseDate: purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: personality!,
            ownership: ownership!,
            salePrice: salePrice,
            saleDate: saleDate,
            purchasePrice: purchasePrice,
            currentPrice: currentPrice,
            province: province!,
            city: city!,
            district: district!,
            mainStreet: mainStreet!,
            bystreet: bystreet!,
            alley: alley!,
            plaque: plaque!,
            floor: floor!,
            unit: unit!,
            moreDetails: moreDetails);
      case AssetCategory.garden:
        return Garden(
            id: asset.id,
            title: title!,
            purchaseDate: purchaseDate,
            amount: 0, // todo: this was suppose to be area size
            personality: personality!,
            ownership: ownership!,
            salePrice: salePrice,
            saleDate: saleDate,
            purchasePrice: purchasePrice,
            currentPrice: currentPrice,
            province: province!,
            city: city!,
            district: district!,
            mainStreet: mainStreet!,
            bystreet: bystreet!,
            alley: alley!,
            plaque: plaque!,
            floor: floor!,
            unit: unit!,
            moreDetails: moreDetails);
      default:
        return null;
    }
  }
}
