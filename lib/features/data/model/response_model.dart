import 'package:zana_storage/features/domain/entities/response_entity.dart';
class ResponseModel extends ResponseEntity{

    ResponseModel({
        Message message,
    int status,
    }):super(status: status,message: message);

    factory ResponseModel.fromJson(Map<String, dynamic> json) {
        return ResponseModel(
            message: json['message'] != null ? Message.fromJson(json['message']) : null, 
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

class Message {
    int invoice;
    String message;

    Message({this.invoice, this.message});

    factory Message.fromJson(Map<String, dynamic> json) {
        return Message(
            invoice: json['invoice'], 
            message: json['message'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['invoice'] = this.invoice;
        data['message'] = this.message;
        return data;
    }
}