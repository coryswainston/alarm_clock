import 'package:dio/dio.dart';

final options = BaseOptions(
  validateStatus: (_) => true,
);
final dio = Dio(options);