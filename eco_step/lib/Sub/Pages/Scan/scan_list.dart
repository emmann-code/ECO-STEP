import 'package:eco_step/Sub/Pages/Scan/scanlist_details.dart';
import 'package:flutter/material.dart';
class PackagingTypesScreen extends StatefulWidget {
  @override
  State<PackagingTypesScreen> createState() => _PackagingTypesScreenState();
}

class _PackagingTypesScreenState extends State<PackagingTypesScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Plastic',
      'image': 'assets/plastics.png',
      'material': 'PET - polyethylene terephthalate',
      'capMaterial': 'HDPE - high-density polyethylene',
      'disposalRecommendations': [
        'Crumble the bottle so that it takes up less space',
        'Screw the cap back on the bottle',
        'Throw away in the yellow container mixed recycling',
      ],
    },
    {
      'name': 'Glass',
      'image': 'assets/glass.png',
      'material': 'Glass',
      'capMaterial': 'Metal or plastic',
      'disposalRecommendations': [
        'Remove the cap',
        'Rinse the glass to remove any residue',
        'Throw away in the green glass recycling container',
      ],
    },
    {
      'name': 'Paper',
      'image': 'assets/paper.png',
      'material': 'Paper',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Flatten the paper to save space',
        'Avoid mixing with wet waste',
        'Throw away in the blue paper recycling container',
      ],
    },
    {
      'name': 'Metal',
      'image': 'assets/metal.png',
      'material': 'Aluminum or Steel',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Rinse to remove food residue',
        'Flatten cans to save space',
        'Throw away in the yellow mixed recycling container',
      ],
    },
    {
      'name': 'Batteries',
      'image': 'assets/batery.png',
      'material': 'Lithium-ion or Alkaline',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Do not throw in regular trash',
        'Take to a designated battery recycling point',
        'Store in a cool, dry place until disposal',
      ],
    },
    {
      'name': 'Light Bulbs',
      'image': 'assets/lightbulb.png',
      'material': 'Glass and metal filament',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Do not throw in regular trash',
        'Take to a designated light bulb recycling point',
        'Handle with care to avoid breakage',
      ],
    },
    {
      'name': 'Cardboard',
      'image': 'assets/cardboard-removebg-preview.png',
      'material': 'Corrugated fiberboard',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Flatten to save space',
        'Remove any plastic or tape',
        'Throw away in the blue paper recycling container',
      ],
    },
    {
      'name': 'Electronics',
      'image': 'assets/tv.png',
      'material': 'Various metals and plastics',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Do not throw in regular trash',
        'Take to an e-waste recycling center',
        'Remove batteries before disposal',
      ],
    },
    {
      'name': 'Textiles',
      'image': 'assets/texile.png',
      'material': 'Cotton, Polyester, or Wool',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Donate if in good condition',
        'Cut into rags if unusable',
        'Throw away in designated textile recycling bins',
      ],
    },
    {
      'name': 'Tetra Pak',
      'image': 'assets/tetrapak-removebg-preview.png',
      'material': 'Paperboard, Aluminum, and Plastic',
      'capMaterial': 'Plastic',
      'disposalRecommendations': [
        'Rinse to remove residue',
        'Flatten to save space',
        'Throw away in the yellow container mixed recycling',
      ],
    },
    {
      'name': 'Wood',
      'image': 'assets/wood.png',
      'material': 'Treated or Untreated Wood',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Untreated wood can be composted or recycled',
        'Treated wood should be taken to a waste disposal facility',
        'Avoid burning treated wood',
      ],
    },
    {
      'name': 'Styrofoam',
      'image': 'assets/foam.png',
      'material': 'Polystyrene',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Avoid breaking into small pieces',
        'Check for local recycling options',
        'Throw away in the regular trash if no recycling available',
      ],
    },
    {
      'name': 'Ceramics',
      'image': 'assets/ceramic.png',
      'material': 'Clay and Glaze',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Do not throw in regular recycling',
        'Take to a local waste disposal site',
        'Reuse as garden decor or mosaic materials',
      ],
    },
    {
      'name': 'Food Waste',
      'image': 'assets/food.png',
      'material': 'Organic Waste',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Compost if possible',
        'Separate from non-organic waste',
        'Throw away in the green organic waste container',
      ],
    },
    {
      'name': 'Medicine',
      'image': 'assets/drugs-removebg-preview.png',
      'material': 'Various Chemicals',
      'capMaterial': 'Plastic or Glass',
      'disposalRecommendations': [
        'Do not flush down the toilet',
        'Take to a pharmacy for safe disposal',
        'Keep out of reach of children until disposal',
      ],
    },
    {
      'name': 'Rubber',
      'image': 'assets/rubber.png',
      'material': 'Natural or Synthetic Rubber',
      'capMaterial': 'None',
      'disposalRecommendations': [
        'Check for local recycling options',
        'Do not burn rubber',
        'Throw away in the regular trash if no recycling available',
      ],
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void _filterItems(String query) {
    final results = items.where((item) {
      final nameLower = item['name']!.toLowerCase();
      final materialLower = item['material']!.toLowerCase();
      final capMaterialLower = item['capMaterial']!.toLowerCase();
      final disposalRecommendations = (item['disposalRecommendations'] as List<String>)
          .join(' ')
          .toLowerCase();

      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          materialLower.contains(searchLower) ||
          capMaterialLower.contains(searchLower) ||
          disposalRecommendations.contains(searchLower);
    }).toList();

    setState(() {
      filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Types of packaging'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                hintText: 'Search',
                prefixIcon: IconButton(
                  onPressed: () {
                    _filterItems(searchController.text); // Fix here
                  },
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterItems, // This part is already correct
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredItems.length, // Use filteredItems
                itemBuilder: (context, index) {
                  final item = filteredItems[index]; // Use filteredItems
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(
                            itemName: item['name']!,
                            itemImage: item['image']!,
                            material: item['material']!,
                            capMaterial: item['capMaterial']!,
                            disposalRecommendations: item['disposalRecommendations']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['image']!, height: 80.0),
                          SizedBox(height: 10.0),
                          Text(
                            item['name']!,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
