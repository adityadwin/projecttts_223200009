import 'package:projecttts_223200009/app/common/config.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("${Config.baseUrl}/province");
  final response = await http.get(url, headers: {"key": Config.apiKey});
  print(response.statusCode);
  print(response.body);
}
