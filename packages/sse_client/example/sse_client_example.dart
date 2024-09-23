import 'package:sse_dart_client/sse_dart_client.dart';

Future<void> main() async {
  final SSEClient sseClient = SSEClient(url: 'https://example.com/sse');
  sseClient.stream.listen(
    (data) {},
  );

  await sseClient.connect();
}
