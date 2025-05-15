import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/weather_provider.dart';

import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/providers/user_places.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    final weatherAsyncValue = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: weatherAsyncValue.when(
                  data: (weather) {
                    return ListTile(
                      title: Image.network(
                          'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                          scale: 0.2),
                      subtitle: Text(
                        'Hong Kong, ${weather.description[0].toUpperCase() + weather.description.substring(1)},  ${weather.temp.toString()}  °C',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.yellow),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  error: (err, stack) => Text('Error: $err'),
                  loading: () => const CircularProgressIndicator()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: _placesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : PlacesList(
                            places: userPlaces,
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
