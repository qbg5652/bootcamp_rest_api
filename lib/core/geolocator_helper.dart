import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static Future<Position?> getPosition() async {
    final permission = await Geolocator.checkPermission();

    //1. 현재 권한이 허용되지 않았을 때, 권한 요청하기
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      final permission2 = await Geolocator.requestPermission();

      //2. 권한 요청 후 결과가 거부일 때, 리턴하기
      if (permission2 == LocationPermission.denied ||
          permission2 == LocationPermission.deniedForever) {
        return null;
      }
    }
    //3. Geolocator로 위치 정보 가져와서 리턴하기
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high, // 정확도는 100으로 높게.
        distanceFilter: 100, // 100m 이동할 때 마다 값을 갱신해라.
      ),
    );
    return position;
  }
}
