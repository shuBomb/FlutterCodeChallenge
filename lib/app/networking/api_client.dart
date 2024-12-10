import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'apis.dart';
import 'app_interceptor.dart';
part 'api_client.g.dart';


@RestApi(baseUrl: 'https://bb3-api.ashwinsrivastava.com/')
abstract class RestApiClient {
  factory RestApiClient() {
    Dio dio = Dio(BaseOptions(
      contentType: "application/json",
    ));

    dio.options = BaseOptions(
        headers: {},
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60));

    dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return _RestApiClient(dio);
  }


  @GET(Apis.storeProduct)
  Future<dynamic> getProduct();

  @GET(Apis.productSearch)
  Future<dynamic> searchProduct(@Query("q") String query);

}
