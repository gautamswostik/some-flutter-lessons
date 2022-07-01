import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapUrl {
  const MapUrl();

  static String baseUrl = dotenv.get('BASEURL', fallback: '');
  static String acceesToken = dotenv.get('MAPBOXTOKEN', fallback: '');
  static String templteUrl =
      '$baseUrl/ckzxljoyd000u14pqy5u4dh5n/tiles/256/{z}/{x}/{y}@2x?access_token=$acceesToken';
  static const String id = 'mapbox.mapbox-streets-v8';
}
