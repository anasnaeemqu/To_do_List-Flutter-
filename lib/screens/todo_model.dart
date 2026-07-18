class TodoDataModel {
    TodoDataModel({
        required this.data,
        required this.message,
        required this.statusCode,
        required this.success,
    });

    final List<tododetail> data;
    final String? message;
    final int? statusCode;
    final bool? success;

    factory TodoDataModel.fromJson(Map<String, dynamic> json){ 
        return TodoDataModel(
            data: json["data"] == null ? [] : List<tododetail>.from(json["data"]!.map((x) => tododetail.fromJson(x))),
            message: json["message"],
            statusCode: json["statusCode"],
            success: json["success"],
        );
    }

}

class tododetail {
    tododetail({
        required this.v,
        required this.id,
        required this.createdAt,
        required this.description,
        required this.isDone,
        required this.title,
        required this.updatedAt,
    });

    final int? v;
    final String? id;
    final DateTime? createdAt;
    final String? description;
    final bool? isDone;
    final String? title;
    final DateTime? updatedAt;

    factory tododetail.fromJson(Map<String, dynamic> json){ 
        return tododetail(
            v: json["__v"],
            id: json["_id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            description: json["description"],
            isDone: json["isDone"],
            title: json["title"],
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}
