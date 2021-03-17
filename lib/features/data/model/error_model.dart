class ErrorModel {
    MessageModel message;
    int status;

    ErrorModel({this.message, this.status});

    factory ErrorModel.fromJson(Map<String, dynamic> json) {
        return ErrorModel(
            message: json['message'] != null ? MessageModel.fromJson(json['message']) : null,
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        if (this.message != null) {
            data['message'] = this.message.toJson();
        }
        return data;
    }
}

class MessageModel {
    List<String> products;

    MessageModel({this.products});

    factory MessageModel.fromJson(Map<String, dynamic> json) {
        return MessageModel(
            products: json['Products'] != null ? new List<String>.from(json['products']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.products != null) {
            data['products'] = this.products;
        }
        return data;
    }
}