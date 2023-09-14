enum AssetCategory {
  stock('chart_stock.png', 'category_stock'),
  residentialHouse('icon_home.png', 'category_residential_house'),
  property('building.png', 'category_property'),
  garden('garden.png', 'category_garden'),
  gold('icon_gold.png', 'category_gold'),
  formalCurrency('cash.png', 'category_official_currency'),
  digitalCurrency('icon_bitcoin.png', 'category_digital_currency'),
  car('car.png', 'category_car'),
  other('more_other.png', 'category_other');

  const AssetCategory(this._imageName, this.textId);
  final String _imageName;
  final String textId;
  String get imageUrl => 'assets/image/$_imageName';
}
