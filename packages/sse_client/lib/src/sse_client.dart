import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

/// [SSEClient] is a class that allows connecting to a server that sends
/// events using Server-Sent Events (SSE). It provides a stream to receive
/// the data sent by the server.
///
/// Example usage:
///
/// ```dart
/// final client = SSEClient(
///   url: 'https://example.com/sse',
///   headers: {'Authorization': 'Bearer token'},
/// );
///
/// client.stream.listen((data) {
///   print('Event received: $data');
/// });
///
/// await client.connect();
/// ```

class SSEClient {
  /// Constructor for the [SSEClient] class.
  ///
  /// [url] is the URL of the server you want to connect to using SSE.
  /// [headers] is an optional map of HTTP headers that will be sent
  /// along with the request. If not provided, empty headers will be used
  /// by default.
  SSEClient({
    required this.url,
    this.headers = const <String, String>{},
  });

  /// The URL of the server the client is connecting to.
  final String url;

  /// Map of HTTP headers that will be sent with the request.
  final Map<String, String> headers;

  /// Internal StreamController used to manage the data received from the server.
  final StreamController<String> _controller = StreamController<String>();

  /// Public stream that exposes the data received from the SSE server.
  ///
  /// You can subscribe to this stream to receive events emitted by the server.
  Stream<String> get stream => _controller.stream;

  /// Method to initiate the connection to the SSE server.
  ///
  /// This method sends a GET request to the server specified by the URL.
  /// If the connection is successful (status code 200), data in text format
  /// starts to be received. If an error occurs, it is added to the stream.
  Future<void> connect() async {
    final Request request = Request(
      'GET',
      Uri.parse(url),
    );
    request.headers.addAll(headers);
    final StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      _controller.addError(
        'Failed to connect with status code: ${response.statusCode}',
      );
    } else {
      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            _onData,
            onError: _onError,
            onDone: _onDone,
          );
    }
  }

  /// Private method to handle the received data.
  ///
  /// If the received line is empty or starts with a comment character `:`,
  /// it is ignored. Otherwise, it is added to the stream.
  void _onData(String data) {
    if (data.isEmpty || data.startsWith(':')) return;
    _controller.add(data);
  }

  /// Private method that handles errors during event streaming.
  ///
  /// Adds the error to the stream so that listeners can handle it.
  void _onError(Object error) {
    _controller.addError(error);
  }

  /// Private method called when the connection to the server is finished.
  ///
  /// Closes the stream to indicate that no more data will be received.
  void _onDone() {
    _controller.close();
  }

  /// Method to close the SSE client and release the associated resources.
  ///
  /// This method closes the StreamController and stops any ongoing stream.
  Future<void> close() async {
    _controller.close();
  }
}
