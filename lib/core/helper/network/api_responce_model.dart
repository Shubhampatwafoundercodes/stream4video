class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int? code;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.code,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, {
        T Function(dynamic json)? parser,
      }) {
    return ApiResponse<T>(
      success: json['status'] == true,
      message: json['message'] ?? 'Something went wrong',
      code: json['code'],
      data: parser != null ? parser(json['data']) : json['data'],
    );
  }
}
