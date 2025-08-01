import 'package:flutter/material.dart';

class ResearchScreen extends StatefulWidget {
  const ResearchScreen({super.key});

  @override
  State<ResearchScreen> createState() => _ResearchScreenState();
}

class _ResearchScreenState extends State<ResearchScreen> {
  final List<String> filters = [
    "All", "Animals", "Tourist Sites", "Evolution", "Conservation", "Forestry", "Climate Study"
  ];
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        centerTitle: false,
        title: const Text(
          "Research & Insights",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 12),
          CircleAvatar(
           /*  backgroundImage: AssetImage('assets/user.jpg'), */ // replace with actual avatar
            radius: 16,
          ),
          SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // Upload Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload, color: Colors.white),
              label: const Text("Upload Your Research"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tag Filters
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final tag = filters[index];
                final selected = tag == selectedFilter;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedFilter = tag);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? Colors.orange : const Color(0xFFEDEDED),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Research Posts
          _buildResearchCard(
            author: "Dr. Elena Petrova",
            timeAgo: "2 days ago",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs00IWOc0VXpYgp1qjeuEPOeKB8Ief-07GTQ&s",
            title: "Biodiversity Hotspots in Amazon Rainforest",
            description:
                "A comprehensive study on the unique flora and fauna found in the most biodiverse regions of the Amazon.",
            tags: ["Animals", "Evolution", "Conservation"],
            likes: 124,
            comments: 32,
          ),
          _buildResearchCard(
            author: "Prof. Mark Jensen",
            timeAgo: "4 days ago",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs00IWOc0VXpYgp1qjeuEPOeKB8Ief-07GTQ&s",
            title: "Impact of Ecotourism on Coral Reef Health",
            description:
                "Research evaluating sustainable ecotourism practices and their effects on coral reefs in the Pacific.",
            tags: ["Tourist Sites", "Conservation", "Marine Life"],
            likes: 98,
            comments: 15,
          ),
          _buildResearchCard(
            author: "Dr. Sarah Chen",
            timeAgo: "1 week ago",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs00IWOc0VXpYgp1qjeuEPOeKB8Ief-07GTQ&s",
            title: "Avian Migration Patterns in the Arctic",
            description:
                "An in-depth analysis of migration routes and breeding grounds of birds in the changing Arctic.",
            tags: ["Animals", "Evolution", "Climate Study"],
            likes: 76,
            comments: 9,
          ),
          _buildResearchCard(
            author: "Prof. David Lee",
            timeAgo: "2 weeks ago",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs00IWOc0VXpYgp1qjeuEPOeKB8Ief-07GTQ&s",
            title: "Ancient Trees: Sentinels of Ecological Change",
            description:
                "Investigating dendrochronology and the role of old-growth forests as indicators of ecological shifts.",
            tags: ["Evolution", "Forestry", "Ecology"],
            likes: 110,
            comments: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildResearchCard({
    required String author,
    required String timeAgo,
    required String imageUrl,
    required String title,
    required String description,
    required List<String> tags,
    required int likes,
    required int comments,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                 /*  backgroundImage: AssetImage('assets/avatar.jpg'), */ // author image
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    author,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  timeAgo,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 160,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 6),
                Text(description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      height: 1.4,
                    )),

                const SizedBox(height: 10),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: -8,
                  children: tags
                      .map((tag) => Chip(
                            backgroundColor: const Color(0xFFEAEAEA),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            label: Text(tag,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87)),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 10),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite_border, size: 20, color: Colors.redAccent),
                        const SizedBox(width: 4),
                        Text("$likes", style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 12),
                        const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text("$comments", style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    const Icon(Icons.bookmark_border),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
