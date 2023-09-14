import 'package:dio/dio.dart';
import 'exceptions.dart';

Future<Response<Map<String, dynamic>>> handleServerRequest(
    Future<Response<Map<String, dynamic>>> Function() future) async {
  try {
    final response = await future();
    if (response.statusCode == 200) {
      if (response.data!['Error_Id'] == '0') {
        return response;
      } else {
        throw ServerException(
            errCode: int.tryParse(response.data!['Error_Id']),
            message: response.data!['Error_Text']);
      }
    } else {
      throw ServerException(
          errCode: int.tryParse(response.data!['Error_Id']),
          message: response.data!['Error_Text']);
    }
  } on ServerException catch (_) {
    rethrow;
  } on DioError catch (e) {
    throw NetworkException(message: e.message);
  } catch (e) {
    throw LocalException(message: e.toString());
  }
}
