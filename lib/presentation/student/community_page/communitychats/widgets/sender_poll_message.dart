import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../polls_details/poll_details_page.dart';

class SenderPollMessage extends StatefulWidget {
  final String sender;
  final String time;
  final String title;
  final List<String> pollOptions;
  final int totalVotes;
  final List<double> votePercentages; // ✅ Correct way

  const SenderPollMessage({
    required this.sender,
    required this.pollOptions,
    required this.time,
    required this.title,
    required this.totalVotes,
    required this.votePercentages,
    Key? key,
  }) : super(key: key);

  @override
  State<SenderPollMessage> createState() => _SenderPollMessageState();
}

class _SenderPollMessageState extends State<SenderPollMessage> {
  // State to keep track of the locally selected poll option index.
  // Null means no option is selected yet.
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 10),
          child: UIHelper.customImage(img: "user-1.png", height: 32, width: 32),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 254,
            // Replace fixed height with minHeight constraint for flexibility
            constraints: const BoxConstraints(minHeight: 210),
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView( // allow scrolling if overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender Name & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.sender,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Poll Options
                        ...widget.pollOptions.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String option = entry.value;
                          final bool isSelected = _selectedOptionIndex == index;
                          final double votePercent = widget.votePercentages[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedOptionIndex = isSelected ? null : index;
                              });
                              print('Tapped on option: $option (Index: $index)');
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Circular indicator
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.blue.shade700
                                          : Colors.white,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.blue.shade700
                                            : Colors.grey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                        : null,
                                  ),
                                  const SizedBox(width: 12),

                                  // Option container with background fill
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        // Background fill bar based on percentage
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffCDDCF4),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width *
                                              votePercent *
                                              0.6,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        // Text label
                                        Container(
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            option,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Total Vote & Arrow
                  Row(
                    children: [
                      // Image on the left
                      UIHelper.customImage(
                        img: "cm-chat-img.png",
                        height: 24,
                        width: 56,
                      ),

                      const SizedBox(width: 8),

                      // Text and Icon spaced apart, take up remaining width
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Vote: ${widget.totalVotes}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(PollDetailsPage());
                                print("Arrow tapped! View poll details.");
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: UIHelper.customSvg(
                                  svg: "poll-detiasl-svg.svg",
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class SenderPollMessageDetails extends StatefulWidget {
  final String sender;
  final String time;
  final String title;
  final List<String> pollOptions;
  final int totalVotes;
  final List<double> votePercentages;

  const SenderPollMessageDetails({
    required this.sender,
    required this.pollOptions,
    required this.time,
    required this.title,
    required this.totalVotes,
    required this.votePercentages,
    Key? key,
  }) : super(key: key);

  @override
  _SenderPollMessageDetailsState createState() =>
      _SenderPollMessageDetailsState();
}

class _SenderPollMessageDetailsState extends State<SenderPollMessageDetails> {
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (){
      //   Get.to(PollDetailsPage());
      // },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poll Container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0FF0D5BB9),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Poll Options
                    ...widget.pollOptions.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String option = entry.value;
                      final bool isSelected = _selectedOptionIndex == index;
                      final double votePercent = widget.votePercentages[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOptionIndex = isSelected ? null : index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Option background + text
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffCDDCF4),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          votePercent *
                                          0.6,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
