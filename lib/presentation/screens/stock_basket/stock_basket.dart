import 'package:flutter/material.dart';
import 'stock_basket_info.dart';
import '../../widgets/add_button.dart';
import '../../widgets/default_container.dart';
import '../../../../../config/values/layout.dart';
import '../../../../core/localization/localizations.dart';
import '../../../../locator.dart';

class StockBasketTabContent extends StatelessWidget {
  const StockBasketTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l = sl<ILocalizations>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Padding(
            padding: kPaddingContent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockBasketInfoWidget(),
                      )),
                  child: DefaultContainer(
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/basket.png',
                                              height: 32,
                                            ),
                                            Column(
                                              children: [
                                                const Text('یک'),
                                                const Text('(۰سهم)  ')
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('۱۰۰۰۰۰تومان'),
                                            const Text('ارزش کل سبد'),
                                          ],
                                        )
                                      ],
                                    ),
                                    // Placeholder(),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('عمرسبد: ۹روز'),
                                        Text('به روز رسانی: ۱۴۰۱/۷/۲'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 64.0,
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.teal,
                              child: Column(
                                children: [
                                  const Text('۰%'),
                                  const Text('یک هفته',
                                      style: TextStyle(fontSize: 12)),
                                  kSpaceVertical16,
                                  const Text('۰%'),
                                  const Text('یک ماه',
                                      style: TextStyle(fontSize: 12)),
                                  kSpaceVertical16,
                                  const Text('۰%'),
                                  const Text('سه ماه',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                kSpaceVertical16,
                const AddButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
