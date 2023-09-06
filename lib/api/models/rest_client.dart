import 'package:dio/dio.dart';
import 'package:gender_app/api/models/answer.dart';

import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.genderize.io/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("")
  Future<Answer> getAnswer(
    @Query("name") String name,
    @Query("country_id") String countryId,
  );
}
