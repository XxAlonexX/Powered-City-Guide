import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../widgets/place_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/map_view.dart';
import '../models/place.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  bool _isMapView = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final placesProvider = Provider.of<PlacesProvider>(context, listen: false);
    try {
      await placesProvider.fetchPlaces();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading places: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Guide'),
        actions: [
          IconButton(
            icon: Icon(_isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final placesProvider = Provider.of<PlacesProvider>(context, listen: false);
              await placesProvider.addSamplePlaces();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added sample places')),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const CustomSearchBar(),
                const CategoryFilter(),
                Expanded(
                  child: _isMapView
                      ? const MapView()
                      : Consumer<PlacesProvider>(
                          builder: (context, placesProvider, child) {
                            final places = placesProvider.places;

                            if (places.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('No places available'),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await placesProvider.addSamplePlaces();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Added sample places')),
                                        );
                                      },
                                      child: const Text('Add Sample Places'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                final place = places[index];
                                return PlaceCard(place: place);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new place screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
