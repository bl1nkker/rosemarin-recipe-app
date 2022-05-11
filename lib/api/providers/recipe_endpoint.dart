import 'dart:convert';
import 'package:dio/dio.dart';

class RecipeProvider {
  Dio _client;

  RecipeProvider(this._client);

  Future<Map<String, dynamic>> fetchAllProduct() async {
    try {
      // TODO: Set django url here
      final response = await _client.get('/product');
      // It's better to return a Model class instead but this is
      // only for example purposes only
      return json.decode(response.toString());
    } on DioError catch (ex) {
      // Assuming there will be an errorMessage property in the JSON object
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw new Exception(errorMessage);
    }
  }
}
