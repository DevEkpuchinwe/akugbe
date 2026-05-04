import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/custom_widgets/filled_stateless_button.dart';
import 'package:akugbe/custom_widgets/text_fields.dart';
import 'package:akugbe/providers/wallet_provider.dart';
import 'package:akugbe/screens/payment_received.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../utils/app_utils.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> with AppNavigator {
  @override
  String _amount = "";
  bool exposeFigure = true;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((callback) {
      ref.watch(walletProvider).callWalletBalance(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet",
          style: boldText.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w300,
              color: GlobalColors.blueColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            PhysicalModel(
              color: GlobalColors.whiteColor,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Your balance",
                          style: boldText.copyWith(
                              fontSize: 11.sp, color: GlobalColors.blueColor),
                        ),
                        20.horizontalSpace,
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                exposeFigure = !exposeFigure;
                              });
                            },
                            child: Icon(
                              exposeFigure
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                            ))
                      ],
                    ),
                    10.verticalSpace,
                    Text(
                      textAlign: TextAlign.start,
                      exposeFigure
                          ? AppUtils.formatAmount(
                              wallet.walletBalanceModel?.data?.balance ?? "0")
                          : "*****",
                      style: normalTextBold.copyWith(
                          color: GlobalColors.blueColor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w100),
                    ),
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        if(wallet.getAllBanksResponse == null) {
                          final result = await wallet.callGetAllBanks(context);
                          if (result) {
                            showCustomKeypadWithdrawal(() {
                              showWithdrawDetails(context);
                            });
                          }
                        }else{
                          showCustomKeypadWithdrawal(() {
                            showWithdrawDetails(context);
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: GlobalColors.blueColor, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/Upload.png"),
                                10.horizontalSpace,
                                Text(
                                  "Withdraw",
                                  style: smallNormalTextBolder.copyWith(
                                      color: GlobalColors.blueColor,
                                      fontSize: 14.sp),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _amount = "";
                              showCustomKeypad(() async {
                                var result = await wallet.callDeposit(
                                    context, int.tryParse(_amount) ?? 0);
                                if (result) {
                                  showPaymentDetails(() {
                                    pushTo(
                                        context,
                                        PaymentReceived(
                                            amount: _amount));
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  color: GlobalColors.primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/Download.png",
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Add Funds",
                                    style: smallNormalTextBolder.copyWith(
                                        color: GlobalColors.whiteColor,
                                        fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            40.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transaction History"),
                Text(
                  "See All",
                  style: normalText.copyWith(color: Colors.grey),
                )
              ],
            ),
            20.verticalSpace,
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      wallet.walletBalanceModel?.data?.transaction.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PhysicalModel(
                            color: GlobalColors.whiteColor,
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              "assets/debit.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppUtils.capitalizeFirstLetter(wallet
                                    .walletBalanceModel!
                                    .data!
                                    .transaction[index]
                                    .type),
                                style: smallNormalTextBolder.copyWith(
                                    fontSize: 11.sp,
                                    color: GlobalColors.blueColor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal),
                              ),
                              4.verticalSpace,
                              Text(
                                DateFormat.yMMMEd().format(wallet
                                        .walletBalanceModel!
                                        .data!
                                        .transaction[index]
                                        .updatedAt ??
                                    DateTime.now()),
                                style: normalText.copyWith(
                                    color: Colors.grey, fontSize: 10.sp),
                              ),
                            ],
                          )),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppUtils.formatAmount(wallet.walletBalanceModel!
                                      .data!.transaction[index].amount),
                                  style: smallNormalTextBolder.copyWith(
                                      fontSize: 10.sp,
                                      color: GlobalColors.blueColor),
                                ),
                                4.verticalSpace,
                                Text(
                                  AppUtils.capitalizeFirstLetter(wallet
                                      .walletBalanceModel!
                                      .data!
                                      .transaction[index]
                                      .status),
                                  style: errorText.copyWith(
                                      fontSize: 10.sp,
                                      color: formatTransactionStatusColor(wallet
                                          .walletBalanceModel!
                                          .data!
                                          .transaction[index]
                                          .status)),
                                ),
                              ])
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }

  formatTransactionStatusColor(String status) {
    if (status == "pending") return Colors.orange;
    if (status == "failed") return Colors.red;
    return Colors.green;
  }

  Widget _buildKey({String? label, IconData? icon, VoidCallback? onTap}) {
    return InkWell(
      splashColor: GlobalColors.primaryColor.withOpacity(0.3),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 20, color: Colors.black)
              : Text(
                  label ?? '',
                  style: smallNormalTextBolder.copyWith(fontSize: 16.sp),
                ),
        ),
      ),
    );
  }

  void showCustomKeypad(Function securePayment) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (context) {
          String localAmount = _amount;
          return StatefulBuilder(builder: (BuildContext innerContext,
              StateSetter setModalState /*You can rename this!*/) {
            void onKeyTap(String value) {
              setModalState(() {
                localAmount += value;
              });
            }

            void onBackspaceTap() {
              setModalState(() {
                if (localAmount.isNotEmpty) {
                  localAmount =
                      localAmount.substring(0, localAmount.length - 1);
                }
              });
            }

            // Helper to format number as currency
            String formattedLocalAmount = localAmount.isEmpty
                ? "NGN 0"
                : NumberFormat.currency(
                        locale: "en_NG", symbol: "NGN ", decimalDigits: 0)
                    .format(int.tryParse(localAmount) ?? 0);

            return FractionallySizedBox(
                heightFactor: 0.65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    children: [
                      Text("Enter Amount",
                          style: normalText.copyWith(
                              color: GlobalColors.blackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      // Amount Display
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 247, 247, 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                              maxLines: 1,
                              formattedLocalAmount,
                              style: header.copyWith(
                                  color: GlobalColors.blackColor,
                                  fontSize: 16.sp)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Custom Numeric Keypad
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 1.sw / 4.5,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          if (index == 9) {
                            return const SizedBox
                                .shrink(); // Skip the placeholder
                          } else if (index == 11) {
                            return _buildKey(
                              icon: Icons.backspace_outlined,
                              onTap: onBackspaceTap,
                            );
                          } else {
                            String value = index == 10 ? "0" : "${index + 1}";
                            return _buildKey(
                              label: value,
                              onTap: () {
                                if (localAmount.length <= 6) {
                                  onKeyTap(value);
                                } else {
                                  AppUtils.showErrorMessage(
                                      context,
                                      "We allow max of 7 figures for now",
                                      false,
                                      "Max reached");
                                }
                              },
                            );
                          }
                        },
                      ),
                      30.verticalSpace,
                      // Secure Payment Button
                      GestureDetector(
                        onTap: () {
                          _amount = localAmount;
                          pop(context);
                          securePayment.call();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: GlobalColors.primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/secure_payment.png"),
                              20.horizontalSpace,
                              Text(
                                "Secure payment",
                                style: boldText.copyWith(
                                    color: GlobalColors.blueColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  void showCustomKeypadWithdrawal(Function secureWithdrawal) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (context) {
          var localAmount = "";
          return StatefulBuilder(builder: (BuildContext innerContext,
              StateSetter setModalState /*You can rename this!*/) {
            void onKeyTap(String value) {
              setModalState(() {
                localAmount += value;
              });
            }

            void onBackspaceTap() {
              setModalState(() {
                if (localAmount.isNotEmpty) {
                  localAmount =
                      localAmount.substring(0, localAmount.length - 1);
                }
              });
            }

            // Helper to format number as currency
            String formattedLocalAmount = localAmount.isEmpty
                ? "NGN 0"
                : NumberFormat.currency(
                        locale: "en_NG", symbol: "NGN ", decimalDigits: 0)
                    .format(int.tryParse(localAmount) ?? 0);

            return FractionallySizedBox(
                heightFactor: 0.65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    children: [
                      Text("Enter Amount",
                          style: normalText.copyWith(
                              color: GlobalColors.blackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      // Amount Display
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 247, 247, 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                              maxLines: 1,
                              formattedLocalAmount,
                              style: header.copyWith(
                                  color: GlobalColors.blackColor,
                                  fontSize: 16.sp)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Custom Numeric Keypad
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 1.sw / 4.5,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          if (index == 9) {
                            return const SizedBox
                                .shrink(); // Skip the placeholder
                          } else if (index == 11) {
                            return _buildKey(
                              icon: Icons.backspace_outlined,
                              onTap: onBackspaceTap,
                            );
                          } else {
                            String value = index == 10 ? "0" : "${index + 1}";
                            return _buildKey(
                              label: value,
                              onTap: () {
                                if (localAmount.length <= 6) {
                                  onKeyTap(value);
                                } else {
                                  AppUtils.showErrorMessage(
                                      context,
                                      "We allow max of 7 figures for now",
                                      false,
                                      "Max reached");
                                }
                              },
                            );
                          }
                        },
                      ),
                      30.verticalSpace,
                      // Secure Payment Button
                      GestureDetector(
                        onTap: () {
                          if (double.tryParse(localAmount)! >
                              double.tryParse(ref
                                      .read(walletProvider)
                                      .walletBalanceModel
                                      ?.data
                                      ?.balance ??
                                  "0")!) {
                            AppUtils.showErrorMessage(context,
                                "Insufficient Balance!", false, "Error");
                          } else {
                            _amount = localAmount;
                            pop(context);
                            secureWithdrawal.call();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: GlobalColors.primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/secure_payment.png"),
                              20.horizontalSpace,
                              Text(
                                "Withdraw",
                                style: boldText.copyWith(
                                    color: GlobalColors.blueColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  void showPaymentDetails(Function iHavePaid) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext innerContext,
              StateSetter setModalState /*You can rename this!*/) {
            ref.read(walletProvider).startTimer(() {
              pop(context);
            });
            return FractionallySizedBox(
                heightFactor: 0.7,
                child: PaymentDetails(checkTransactionStatus: () async {
                  var result = await ref.read(walletProvider).checkTransaction(
                      innerContext,
                      ref
                          .read(walletProvider)
                          .walletDepositResponse!
                          .data!
                          .responseBody!
                          .transactionReference);
                  if (result) {
                    if( ref
                        .read(walletProvider)
                        .transactionStatusResponse!
                        .data!
                        .monifyData!.responseBody!
                        .paymentStatus == "PAID"){
                      pop(context);
                      iHavePaid.call();
                    }
                  }
                }));
          });
        });
  }

  void showWithdrawDetails(BuildContext parentContext) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext innerContext,
              StateSetter setModalState /*You can rename this!*/) {

            return FractionallySizedBox(
                heightFactor: 0.8,
                child: WithdrawDetails(
                    amount: _amount,
                    withdraw: () {
                      pop(innerContext);
                      ref
                          .read(walletProvider)
                          .callWithdraw(parentContext, int.tryParse(_amount)!);
                    }));
          });
        });
  }
}

class PaymentDetails extends ConsumerStatefulWidget {
  final Function checkTransactionStatus;

  const PaymentDetails({super.key, required this.checkTransactionStatus});

  @override
  ConsumerState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends ConsumerState<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Transfer NGN",
            style: boldText.copyWith(color: GlobalColors.blueColor),
          ),
          10.verticalSpace,
          Text(
            "Pay with Bank Transfer",
            style: boldText.copyWith(color: GlobalColors.blueColor),
          ),
          10.verticalSpace,
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Account number expires in ",
                style: normalText.copyWith(color: GlobalColors.blueColor),
                children: [
                  TextSpan(
                      text: "${wallet.remainingMinutes} mins",
                      style: normalTextPrimaryColor)
                ])
          ])),
          20.verticalSpace,
          AppTextForm(
            readOnly: true,
            title: "Bank Name",
            controller: TextEditingController(
                text:
                    wallet.walletDepositResponse!.data!.responseBody!.bankName),
          ),
          20.verticalSpace,
          AppTextForm(
            readOnly: true,
            title: "Account Name",
            controller: TextEditingController(
                text: wallet
                    .walletDepositResponse!.data!.responseBody!.accountName),
          ),
          20.verticalSpace,
          AppTextForm(
            readOnly: true,
            title: "Account Number",
            controller: TextEditingController(
                text: wallet
                    .walletDepositResponse!.data!.responseBody!.accountNumber),
            suffixWidget: GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: "Copied"))
                      .then((_) {
                    AppUtils.showSuccessMessage(context, "Copied");
                  });
                },
                child: Icon(Icons.copy_rounded)),
          ),
          20.verticalSpace,
          AppTextForm(
            readOnly: true,
            title: "Amount",
            controller: TextEditingController(
                text: AppUtils.formatAmount(wallet
                    .walletDepositResponse!.data!.responseBody!.amount
                    .toString())),
            suffixWidget: GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: "Copied"))
                      .then((_) {
                    AppUtils.showSuccessMessage(context, "Copied");
                  });
                },
                child: Icon(Icons.copy_rounded)),
          ),
          20.verticalSpace,
          Text(
              textAlign: TextAlign.center,
              "Note: Kindly transfer exact amount to account details above"),
          20.verticalSpace,
          FilledStatelessButton(
              buttonColor: GlobalColors.primaryColor,
              textColor: GlobalColors.blackColor,
              text: "I have Paid",
              onTap: () {
                widget.checkTransactionStatus.call();
              })
        ],
      ),
    );
  }
}

class WithdrawDetails extends ConsumerStatefulWidget {
  final String amount;
  final Function withdraw;

  const WithdrawDetails(
      {super.key, required this.amount, required this.withdraw});

  @override
  ConsumerState createState() => _WithdrawDetailsState();
}

class _WithdrawDetailsState extends ConsumerState<WithdrawDetails> {
  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Text(
            "Enter Withdrawal Details",
            style: boldText.copyWith(color: GlobalColors.blueColor),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Choose Bank",style: smallNormalTextBold),
              ],
            ),
          ),
          10.verticalSpace,
          CustomDropdown(
              value: wallet.selectedBank?.name,
              onChanged: (value) {
                wallet.selectBank(value);
              },
              items: wallet.getAllBanksResponse!.data
                  .map((bank) => bank.name)
                  .toList(),
              hint: Text(
                "Choose bank",
                style: normalTextPrimaryColor
                    .copyWith(color: Color.fromRGBO(196, 196, 196, 1)),
              )),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppTextForm(
              onChanged: (value){
                if(value.length == 10){
                  wallet.verifyAccountNumber(context);
                }else{
                  setState(() {
                    wallet.accountNameController.clear();
                  });
                }
              },
                hintText: "Enter account number",
                readOnly: false,
                maxlength: 10,
                title: "Account Number",
                controller: wallet.accountNumberController),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppTextForm(
              hintText: "Account Name",
              readOnly: true,
              title: "Account Name",
              controller: wallet.accountNameController,
            ),
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppTextForm(
              readOnly: true,
              title: "Amount",
              controller: TextEditingController(
                  text: AppUtils.formatAmount(widget.amount)),
            ),
          ),
          20.verticalSpace,
          wallet.accountNameController.text.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FilledStatelessButton(
                buttonColor: GlobalColors.primaryColor,
                textColor: GlobalColors.blackColor,
                text: "Continue",
                onTap: () {
                  widget.withdraw.call();
                }),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
