import 'dart:async';
import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..post('/calc', _calcHandler);

FutureOr<Response> _rootHandler(Request req) async {
  var connection = PostgreSQLConnection("db", 5432, "postgres",
      username: "postgres", password: "postgres");
  await connection.open().then(
        (value) => print("DB CONNECTED!"),
      );
  List<List<dynamic>> results = await connection.query("SELECT * FROM users");

  for (final row in results) {
    var a = row[0];
    var b = row[1];
    var c = row[2];
    print("$a $b $c");
  }

  return Response.ok('Estes são os resultdos \n ${results.toString()}\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];

  return Response.ok('$message\n');
}

FutureOr<Response> _calcHandler(Request request) async {
  final body = await request.readAsString();
  final message = body.toString();

  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
