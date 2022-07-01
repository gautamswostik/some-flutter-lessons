class MapUrl {
  const MapUrl();

  static const String baseUrl = 'https://api.mapbox.com/styles/v1/';
  static const String acceesToken = '';
  static const String templteUrl =
      '$baseUrl/ckzxljoyd000u14pqy5u4dh5n/tiles/256/{z}/{x}/{y}@2x?access_token=$acceesToken';
  static const String id = 'mapbox.mapbox-streets-v8';
}
