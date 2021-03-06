import 'dart:convert';
import 'package:Postly/core/error/exception.dart';
import 'package:Postly/core/error/failure.dart';
import 'package:http/http.dart' as http;
import 'package:Postly/data/data_provider/api_url.dart';

// uri converter is used to convert url
uriConverter(String url) {
  print('${APIUrl.baseUrl}/$url');
  return Uri.parse(APIUrl.baseUrl + '/$url');
}

//Client for making network calls
class ApiClient {
  Future<dynamic> get(String url) async {
    Map<String, String> headers = APIUrl.headers;
    var response = await http.get(
      uriConverter(url),
      headers: headers,
    );
    var decoded = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['message']}');
      // throw Failure(decoded['message'] ?? response.reasonPhrase);
    }
  }
}
