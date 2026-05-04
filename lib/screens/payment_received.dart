import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/utils/app_utils.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/wallet_provider.dart';

class PaymentReceived extends ConsumerStatefulWidget {
  final String amount;

  const PaymentReceived ({super.key, required this.amount});

  @override
  ConsumerState createState() => _PaymentReceivedState();
}

class _PaymentReceivedState extends ConsumerState<PaymentReceived>
    with AppNavigator {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((callback) {
      ref.watch(walletProvider).callWalletBalance(context, innerCall: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/payment_received.png",
              width: 100,
              height: 100,
            )),
            30.verticalSpace,
            Center(
                child: Text(
              "Payment Received",
              style: header.copyWith(color: GlobalColors.blueColor),
            )),
            10.verticalSpace,
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "${AppUtils.formatAmount(widget.amount)}has been added to your account balance",
                style: normalText
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            50.verticalSpace,
            GestureDetector(
              onTap: () {
                pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: GlobalColors.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Go to Wallet",
                      style: boldText.copyWith(color: GlobalColors.blueColor),
                    )
                  ],
                ),
              ),
            ),
            // 20.verticalSpace,
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     "Fund Again",
            //     style: boldText.copyWith(color: GlobalColors.blueColor),
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}
