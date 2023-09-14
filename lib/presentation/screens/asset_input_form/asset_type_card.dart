import 'package:flutter/material.dart';
import '../../../config/values/layout.dart';

import '../../../config/values/styles.dart';
import '../../../core/enums/asset_category.dart';
import '../../../core/localization/localizations.dart';
import '../../../locator.dart';

class AssetCategoryCard extends StatelessWidget {
  const AssetCategoryCard({super.key, required this.category, this.onTap});
  final AssetCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusCategoryType)),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadiusCategoryType),
        onTap: onTap,
        child: Padding(
          padding: kPaddingCategoryCard,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(category.imageUrl),
                  kSpaceVertical16,
                  Text(
                    l(category.textId),
                    textAlign: TextAlign.center,
                    style: kStyleCategoryCard,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
