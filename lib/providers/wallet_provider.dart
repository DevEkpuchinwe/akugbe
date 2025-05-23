import 'dart:async';

import 'package:akugbe/api_response_models/all_banks_response.dart';
import 'package:akugbe/api_response_models/transaction_status_response.dart';
import 'package:akugbe/api_response_models/wallet_balance_model.dart';
import 'package:akugbe/api_response_models/wallet_deposit_response.dart';
import 'package:akugbe/api_response_models/wallet_withdrawal.dart';
import 'package:akugbe/api_services/wallet_service.dart';
import 'package:akugbe/screens/withdrawal_successful.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/app_utils.dart';
import '../utils/navigator.dart';

final walletProvider = ChangeNotifierProvider<WalletProvider>((ref) {
  return WalletProvider();
});

class WalletProvider extends ChangeNotifier with WalletService, AppNavigator {
  WalletDepositResponse? walletDepositResponse;
  WalletWithdrawalResponse? walletWithdrawalResponse;
  WalletBalanceModel? walletBalanceModel;
  Timer? _timer;
  int _remainingSeconds = 0;
  int remainingMinutes = 0;
  TransactionStatusResponse? transactionStatusResponse;
  GetAllBanksResponse? getAllBanksResponse;
  Bank? selectedBank;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  final Dio paystackDio = Dio(BaseOptions(
    baseUrl: "https://api.paystack.co/bank/resolve",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 1000,
        enabled: true));

  void startTimer(VoidCallback onComplete) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        remainingMinutes = (_remainingSeconds / 60).ceil();
        print(remainingMinutes);
        notifyListeners();
      } else {
        _timer?.cancel();
        onComplete();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _remainingSeconds = 0;
    remainingMinutes = 0;
    notifyListeners();
  }

  void callWalletBalance(BuildContext context, {bool innerCall = false}) async {
    try {
      if (innerCall == false) {
        AppUtils.showLoadingDialog("Processing...", context);
      }
      walletBalanceModel = await walletBalance();
      if (innerCall == false) {
        AppUtils.popLoadingDialog(context);
      }
      if (walletBalanceModel!.status == true) {
      } else {
        AppUtils.showErrorMessage(context,
            walletBalanceModel!.message ?? "An error occurred", false, "Error");
      }
      notifyListeners();
    } on Exception catch (error) {
      if (innerCall == false) {
        AppUtils.popLoadingDialog(context);
      }
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  Future<bool> checkTransaction(
      BuildContext context, String transactionReference) async {
    try {
      AppUtils.showLoadingDialog("Processing...", context);
      transactionStatusResponse =
          await confirmTransaction(transactionReference);
      AppUtils.popLoadingDialog(context);
      if (transactionStatusResponse!.status == true &&
          transactionStatusResponse!.data!.monifyData!.requestSuccessful == true) {
        cancelTimer();
        return true;
      } else {
        AppUtils.showErrorMessage(
            context,
            transactionStatusResponse?.data?.monifyData!.responseMessage ??
                "An error occurred",
            false,
            "Error");
        return false;
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
      return false;
    }
  }

  Future<bool> callDeposit(BuildContext context, int amount) async {
    try {
      AppUtils.showLoadingDialog("Processing...", context);
      Map<String, dynamic> requestParams = {"amount": amount};
      walletDepositResponse = await deposit(requestParams);
      AppUtils.popLoadingDialog(context);
      if (walletDepositResponse!.status == true) {
        _remainingSeconds =
            walletDepositResponse!.data!.responseBody!.accountDurationSeconds;
        return true;
      } else {
        AppUtils.showErrorMessage(
            context,
            walletDepositResponse!.message ?? "An error occurred",
            false,
            "Error");
        return false;
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
      return false;
    }
  }

  void callWithdraw(BuildContext context, int amount) async {
    try {
      AppUtils.showLoadingDialog("Processing...", context);
      Map<String, dynamic> requestParams = {
        "amount": amount,
        "destinationBankCode": selectedBank!.code,
        "destinationAccountNumber": accountNumberController.text
     //   "sourceAccountNumber": "3934178936"
      };
      walletWithdrawalResponse = await withdraw(requestParams);
      AppUtils.popLoadingDialog(context);
      if (walletWithdrawalResponse!.status == true) {
        pushTo(context, WithdrawalSuccessful(amount: amount.toString()));
      } else {
        AppUtils.showErrorMessage(
            context,
            walletWithdrawalResponse!.message ?? "An error occurred",
            false,
            "Error");
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
    }
  }

  Future<bool> callGetAllBanks(BuildContext context) async {
    try {
      AppUtils.showLoadingDialog("Processing...", context);
      getAllBanksResponse = await getBanks();
      AppUtils.popLoadingDialog(context);
      if (getAllBanksResponse!.status == true) {
        return true;
      } else {
        AppUtils.showErrorMessage(
            context,
            getAllBanksResponse!.message ?? "An error occurred",
            false,
            "Error");
        return false;
      }
    } on Exception catch (error) {
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context,
          error.toString().replaceFirst('Exception: ', ''), false, "Error");
      return false;
    }
  }

  void selectBank(String bankName) {
    selectedBank =
        getAllBanksResponse!.data.where((bank) => bank.name == bankName).first;
    accountNameController.clear();
    accountNumberController.clear();
    notifyListeners();
  }

  Future verifyAccountNumber(BuildContext context) async {
    try{
      AppUtils.showLoadingDialog("Processing...", context);
      paystackDio.options.headers["Authorization"] =
      "bearer sk_live_b9a5977e03a26f5b6dbf0fad73a84588803d6ca4";
      final result = await paystackDio.get("", queryParameters: {
        "account_number": accountNumberController.text,
        "bank_code": selectedBank!.code
      });
      AppUtils.popLoadingDialog(context);
      if (result.statusCode == 200) {
        if (result.data["message"] == "Account number resolved") {
          accountNameController.text = result.data["data"]["account_name"];
          notifyListeners();
        }
      } else {
        accountNumberController.clear();
        notifyListeners();
        AppUtils.showErrorMessage(
            context, "Invalid Account Number", false, "Error");
      }
    }catch(e){
      AppUtils.popLoadingDialog(context);
      AppUtils.showErrorMessage(context, "Account Verification Failed, Try again!", false, "Error");
      accountNumberController.clear();
      notifyListeners();
    }

  }
}
