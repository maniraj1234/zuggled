import 'package:frontend/core/network/http_client.dart';
import 'package:frontend/features/backend_test/model/message_model.dart';
import 'package:http_status_code/http_status_code.dart';

/// This service class is responsible for fetching data from the backend API.
///
/// This class handles the network call to retrieve a simple message
/// and converts the response into a [MessageModel] object.
class MessageService {
  /// An instance of [HttpService] that handles the HTTP requests.
  final HttpService httpService = HttpService();

  /// Fetches a message from the backend API.
  ///
  /// Sends a GET request to the root (`'/'`) endpoint.
  /// Returns a [MessageModel] if the response status is 200.
  /// Throws an [Exception] if the request fails or returns any other status code.
  Future<MessageModel> getMessage() async {
    try {
      final response = await httpService.client.get('/');
      if (response.statusCode == StatusCode.OK) {
        // If the server returns a 200 OK response, parse the JSON
        return MessageModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load message');
      }
    } catch (e) {
      throw Exception('Failed to load message: $e');
    }
  }
}
