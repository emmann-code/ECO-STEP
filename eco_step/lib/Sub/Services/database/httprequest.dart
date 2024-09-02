import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchRecyclingCenters(double minLat, double minLon, double maxLat, double maxLon) async {
  String overpassQuery = '''
  [out:json];
  (
    node["amenity"="recycling"]
    ($minLat,$minLon,$maxLat,$maxLon);
  );
  out body;
  ''';

  final response = await http.post(
    Uri.parse('https://overpass-api.de/api/interpreter'),
    body: {
      'data': overpassQuery,
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<Map<String, dynamic>> recyclingCenters = data['elements'].map<Map<String, dynamic>>((element) {
      return {
        'lat': element['lat'],
        'lon': element['lon'],
        'tags': element['tags'],
      };
    }).toList();

    return recyclingCenters;
  } else {
    throw Exception('Failed to load recycling centers');
  }
}
