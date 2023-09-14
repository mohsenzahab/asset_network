import 'package:flutter/material.dart';

import '../../../config/values/layout.dart';
import '../../../core/enums/asset_category.dart';
import 'asset_type_card.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.onCategoryTap});
  final void Function(AssetCategory category) onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: kSpaceCategoryGrid,
          mainAxisSpacing: kSpaceCategoryGrid,
          mainAxisExtent: 200,
          childAspectRatio: 1),
      semanticChildCount: 12,
      children: AssetCategory.values
          .map((category) => AssetCategoryCard(
                category: category,
                onTap: () => onCategoryTap(category),
              ))
          .toList(growable: false),
    );
  }
}
