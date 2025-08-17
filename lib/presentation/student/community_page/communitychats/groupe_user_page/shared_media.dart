import 'package:flutter/material.dart';
import '../../../../../utils/ui_helper.dart';

class SharedMedia extends StatefulWidget {
  const SharedMedia({super.key});

  @override
  State<SharedMedia> createState() => _SharedMediaState();
}

class _SharedMediaState extends State<SharedMedia> {
  int selectedTabIndex = 0;

  final List<String> tabs = ["Media", "Document", "Links"];
  final List<String> icons = ["community-svg.svg", "subject-svg.svg", "Courses.svg"];
  final TextEditingController _searchController = TextEditingController();

  String searchText = "";

  // ✅ Media Tab: Using Picsum Photos
  final List<String> sampleCommunity = List.generate(
    20,
        (index) => 'https://picsum.photos/200/300?random=$index',
  );

  final List<String> sampleSessions = [
    "Flutter Roadmap.pdf",
    "Resume_Template.docx",
    "Presentation_Design.pptx",
    "API_Documentation.pdf",
  ];

  final List<String> sampleCourses = [
    "https://flutter.dev",
    "https://dart.dev",
    "https://getx.dev",
    "https://firebase.google.com",
  ];

  List<String> get filteredCommunity => _filterList(sampleCommunity);
  List<String> get filteredSessions => _filterList(sampleSessions);
  List<String> get filteredCourses => _filterList(sampleCourses);

  List<String> _filterList(List<String> list) {
    if (searchText.isEmpty) return list;
    return list
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: _buildAppBar(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  _buildTabs(),
                  const SizedBox(height: 8),
                  _buildUnderline(),
                  Expanded(child: _buildTabContent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeBackground() => UIHelper.customSvg(svg: "bg.svg");

  Widget _buildAppBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFCEDBF1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
            ),
          ),
          const Text(
            'Shared Media',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          //const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFCDDCF4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(3.0),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF03002F),
            ),
            child: Center(
              child: SizedBox(
                height: 16,
                width: 16,
                child: UIHelper.customSvg(svg: "serch-icon-svg.svg"),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  searchText = val;
                });
              },
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search for Media, Documents, Links...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return GestureDetector(
          onTap: () => setState(() => selectedTabIndex = index),
          child: _buildTab(
            tabs[index],
            selectedTabIndex == index,
            icons[index],
          ),
        );
      }),
    );
  }

  Widget _buildTab(String label, bool selected, String icon) {
    return Row(
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: UIHelper.customSvg(
            svg: icon,
            color: selected ? Colors.black : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.black : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildUnderline() {
    final tabWidth = MediaQuery.of(context).size.width / tabs.length;
    return Stack(
      children: [
        Container(height: 2, width: double.infinity),
        AnimatedAlign(
          alignment:
          Alignment(-1 + (selectedTabIndex * (2 / (tabs.length - 1))), 0),
          duration: const Duration(milliseconds: 300),
          child: Container(
            height: 2,
            width: tabWidth - 32,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    if (selectedTabIndex == 0) {
      return _buildListCommunity(filteredCommunity);
    } else if (selectedTabIndex == 1) {
      return _buildListSessions(filteredSessions);
    } else {
      return _buildListCourses(filteredCourses);
    }
  }

  Widget _buildListCommunity(List<String> items) {
    return GridView.builder(
      itemCount: sampleCommunity.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 102,
            width: 102,
            child: Image.network(
              sampleCommunity[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }


  Widget _buildListSessions(List<String> items) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xFFCDDCF4),
            borderRadius: BorderRadius.circular(46),
          ),
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Color(0xFF9DB8E7), // Hex color
                  shape: BoxShape.circle,   // Makes it round
                ),
                alignment: Alignment.center,
                child: UIHelper.customSvg(
                  svg: "pdf-svg.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  items[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListCourses(List<String> items) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            print("Open link: ${items[index]}");
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFCDDCF4),
              borderRadius: BorderRadius.circular(80),
            ),
            child: Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFF9DB8E7), // Hex color
                    shape: BoxShape.circle,   // Makes it round
                  ),
                  alignment: Alignment.center,
                  child: UIHelper.customSvg(
                    svg: "link-svg-m.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
