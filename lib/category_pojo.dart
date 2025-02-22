class ApiResponse {
  final String message;
  final List<Category_items> data;

  ApiResponse({required this.message, required this.data});

  // Factory method to convert JSON into an ApiResponse object
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      data: List<Category_items>.from(json['data'].map((item) => Category_items.fromJson(item))),
    );
  }
}

class Category_items {
  final int id;
  final String name;

  Category_items({required this.id, required this.name});

  // Factory method to convert JSON into a Category object
  factory Category_items.fromJson(Map<String, dynamic> json) {
    return Category_items(
      id: json['id'],
      name: json['name'],
    );
  }
}
