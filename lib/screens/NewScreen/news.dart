import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nature News'),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Column(
          children: const [
            SizedBox(height: 10),
            NewsToggleButtons(),
            Expanded(child: NewsList()),
          ],
        ),
        /* backgroundColor: Colors.grey[100], */
      ),
    );
  }
}

class NewsToggleButtons extends StatelessWidget {
  const NewsToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: theme.onSurface,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Global News',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Local News',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      children: const [
        NewsCard(
          imageUrl: 'https://i.natgeofe.com/n/a85fdd13-73d1-4b51-8aab-4c4cbd31b665/01monsterfrog.jpg',
          category: 'New Discovery',
          title: 'Rare Amazonian Frog Discovered',
          description:
              'Scientists have announced the discovery of a vibrant, iridescent frog species deep within the unexplored regions of the Amazon rainforest.',
          date: 'Oct 26, 2023',
        ),
        SizedBox(height: 16),
        NewsCard(
          imageUrl: 'https://assets.thehansindia.com/h-upload/2021/12/05/1125167-deep-ocean-mission.webp',
          category: 'Conservation Crisis',
          title: 'Great Barrier Reef Faces New Bleaching Threat',
          description:
              'Marine biologists express grave concerns as rising ocean temperatures trigger another mass coral bleaching event across significant sections.',
          date: 'Oct 24, 2023',
        ),
        SizedBox(height: 16),
        NewsCard(
          imageUrl: 'https://earth.org/wp-content/uploads/2022/03/1024px-An_example_of_slash_and_burn_agriculture_practice_Thailand.jpg',
          category: 'Environmental Threat',
          title: 'Deforestation Rates Accelerate in Southeast Asia',
          description:
              'New satellite data reveals an alarming increase in deforestation across key biodiversity hotspots in Southeast Asia, posing an immediate threat to wildlife.',
          date: 'Oct 22, 2023',
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String description;
  final String date;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                // Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Text(
                      'Read More →',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
