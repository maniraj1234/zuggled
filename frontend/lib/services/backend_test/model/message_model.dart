/// A model representing a simple message returned from the backend.
///
/// This model is used for deserializing the JSON response.
class MessageModel {
  String message;
  MessageModel({required this.message});
   factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(message: json['message']);
  }
}
