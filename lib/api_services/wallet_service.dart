import 'package:akugbe/api_response_models/all_banks_response.dart';
import 'package:akugbe/api_response_models/transaction_status_response.dart';
import 'package:akugbe/api_response_models/transfer_response.dart';
import 'package:akugbe/api_response_models/wallet_balance_model.dart';
import 'package:akugbe/api_response_models/wallet_deposit_response.dart';
import 'package:akugbe/api_response_models/wallet_withdrawal.dart';
import 'package:dio/dio.dart';

import '../network_config/network_base.dart';

mixin WalletService {
  Future<WalletDepositResponse> deposit(Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest("wallet/deposit", data, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return WalletDepositResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return WalletDepositResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<WalletWithdrawalResponse> withdraw(Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest("wallet/disburse", data, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return WalletWithdrawalResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return WalletWithdrawalResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<TransferResponse> transfer(Map<String, dynamic> data) async {
    try {
      var response = await NetworkConfig()
          .postRequest("wallet/transfer", data, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return TransferResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return TransferResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<WalletBalanceModel> walletBalance() async {
    try {
      var response = await NetworkConfig()
          .getRequest("wallet/balance", null, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return WalletBalanceModel.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return WalletBalanceModel.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<TransactionStatusResponse> confirmTransaction(String transactionReference) async {
    try {
      var response = await NetworkConfig()
          .getRequest("wallet/transaction-status/$transactionReference", null, needAuth: true);
      if ("${response.statusCode}".startsWith("2")) {
        return TransactionStatusResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return TransactionStatusResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }

  Future<GetAllBanksResponse> getBanks() async {
    try {
      var response = await NetworkConfig()
          .getRequest("getAllBanks", null, needAuth: false);
      if ("${response.statusCode}".startsWith("2")) {
        return GetAllBanksResponse.fromJson(response.data);
      } else {
        throw Exception("An error occurred");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Oops. Check your internet connection and try again.");
      } else if (e.type == DioExceptionType.badResponse) {
        return GetAllBanksResponse.fromJson(e.response!.data);
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
