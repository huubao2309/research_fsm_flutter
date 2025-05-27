/// Generic API response model
class ApiResponse<T> {
  /// Status code of the response
  final int statusCode;
  
  /// Response data
  final T? data;
  
  /// Error message if any
  final String? errorMessage;

  /// Constructor
  ApiResponse({
    required this.statusCode,
    this.data,
    this.errorMessage,
  });

  /// Check if the response is successful
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Create a successful response
  factory ApiResponse.success(T data) {
    return ApiResponse(
      statusCode: 200,
      data: data,
    );
  }

  /// Create an error response
  factory ApiResponse.error(int statusCode, String message) {
    return ApiResponse(
      statusCode: statusCode,
      errorMessage: message,
    );
  }
}
