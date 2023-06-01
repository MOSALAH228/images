import 'package:dio/dio.dart';
import 'package:wa_photos/constants/strings.dart';
import 'package:wa_photos/module/photos_module.dart';

class PhotosApi {
  late Dio dio;

  PhotosApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
    );
    dio = Dio(options);
  }

  Future<List<PhotosModuel>> getPhotosData() async {
    List<PhotosModuel> photosList = [];
    try {
      Response response = await dio.get("photos");
      var data = response.data;
      print(response.data.toString());
      data.forEach(
        (element) {
          photosList.add(PhotosModuel.fromJson(element));
        },
      );
      return photosList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
