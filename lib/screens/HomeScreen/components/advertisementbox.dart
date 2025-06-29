import 'package:flutter/material.dart';
import 'dart:async';

class Advertisementbox extends StatefulWidget {
  const Advertisementbox({super.key});

  @override
  State<Advertisementbox> createState() => _AdvertisementboxState();
}

class _AdvertisementboxState extends State<Advertisementbox> {
  final List<Map<String, String>> _ads = [
    {
      'top': "🌿 100% Organic Nature Products",
      'bottom': "Buy Now & Feel the Earth’s Touch",
      'image': 'assets/images/nature.jpeg'
    },
    {
      'top': "🐾 Pure Animal-Based Products",
      'bottom': "From Farm to Home – Ethically Sourced",
      'image': 'assets/images/animal.jpeg'
    },
    {
      'top': "🏞️ Discover Hidden Gems",
      'bottom': "Plan Your Next Nature Adventure",
      'image': 'assets/images/tour.jpg'
    },
  ];

  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _index = (_index + 1) % _ads.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withOpacity(0.9), cs.secondary.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Animated Text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Text(
              _ads[_index]['top']!,
              key: ValueKey<String>(_ads[_index]['top']!),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: cs.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Central Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              _ads[_index]['image']!,
              height: 150,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // Bottom Animated Text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Text(
              _ads[_index]['bottom']!,
              key: ValueKey<String>(_ads[_index]['bottom']!),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: cs.onPrimary.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
