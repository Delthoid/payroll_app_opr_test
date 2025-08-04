class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? message;
  final String? error;

  ApiResponse({this.data, this.success = false, this.message, this.error});
}