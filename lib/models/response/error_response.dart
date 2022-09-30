import 'package:dio/dio.dart';

class ErrorResponse implements Exception {
  int? errorCode; //Error code
  String? errorMessage = ""; //Error message

  ErrorResponse({this.errorCode, this.errorMessage});

  // ErrorResponse.fromJson(Map<String, dynamic> json)
  //     : errorCode = json['errorCode'],
  //       errorMessage = json['errorMessage'];
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        errorCode: json['errorCode'], errorMessage: json['errorMessage']);
  }

  Map<String, dynamic> toJson() =>
      {'errorCode': errorCode, 'errorMessage': errorMessage};

  ErrorResponse.withError({DioError? error}) {
    _handleError(error!);
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        errorMessage =
            "Received invalid status code: ${error.response!.statusCode}";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Receive timeout in send request";
        break;
    }
    return errorMessage;
  }
}
