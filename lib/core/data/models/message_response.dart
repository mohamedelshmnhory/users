import 'response_model.dart';

class MessageResponse extends ResponseModel {
  const MessageResponse({
    super.status,
    super.message,
    super.errors,
  });

  factory MessageResponse.fromMap(Map<String, dynamic> map) => MessageResponse(
        status: map['status'],
        message: map['message'],
        errors: map['errors'],
      );


}
