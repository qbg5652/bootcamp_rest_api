import 'package:dio/dio.dart';

class VworldRepository {
  final Dio dioClient = Dio(
    BaseOptions(
      // 설정 안하면 응답 실패시, throw 던져서 에러남.
      validateStatus: (status) {
        return true;
      },
    ),
  );

  //1. 이름으로 검색하는 기능
  // json 경로 : response > result > items >> title
  // https://api.vworld.kr/req/search
  // request=search
  // key=7662DE12-6B41-39FA-80AF-704C85D45F0E
  // query=신중동
  // type=DISTRICT
  // category=L4
  Future<List<String>> findByName(String query) async {
    try {
      final response = await dioClient.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'request': 'search',
          'key': '7662DE12-6B41-39FA-80AF-704C85D45F0E',
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
        },
      );
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'];
        final itemList = List.from(items);
        final iterable = itemList.map((item) {
          return '${item['title']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  //2. 위도, 경도로 검색하는 기능
  // json 경로 : response > result > featureCollection >features >> properties > full_nm
  // https://api.vworld.kr/req/data
  // request=GetFeature
  // key=7662DE12-6B41-39FA-80AF-704C85D45F0E
  // data=LT_C_ADEMD_INFO
  // geomFilter=POINT(126.7708711 37.5084907)
  // geometry=false
  // size=100
  Future<List<String>> findByLatLng(double lat, double lng) async {
    try {
      final response = await dioClient.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': '7662DE12-6B41-39FA-80AF-704C85D45F0E',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features =
            response
                .data['response']['result']['featureCollection']['features'];
        final featureList = List.from(features);
        final iterable = featureList.map((e) {
          return '${e['properties']['full_nm']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
