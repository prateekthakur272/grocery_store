import 'dart:async';
import 'dart:io';
import 'package:category_repository/category_repository.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch(context.request.method){

    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.patch:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final categoryRepository = context.read<CategoryRepository>();
  final categories = await categoryRepository.getCategories();
  return Response.json(body: categories);
}
