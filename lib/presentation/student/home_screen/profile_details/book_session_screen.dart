import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:learning_guru_app/widgets/base_button.dart';

class BookSessionScreen extends StatefulWidget {
  const BookSessionScreen({super.key});

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  int selectedDayIndex = 2; // Wednesday (3rd)
  List<int> days = [1, 2, 3, 4, 5, 6, 7];
  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
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
                  Center(
                    child: Text(
                      'Book Session',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 40), // spacing filler
                ],
              ),
            ),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Selector
                  DynamicWeeklyCalendar(),
                  const SizedBox(height: 30),

                  // Time Title
                  UIHelper.boldText(
                    text: "Select Time Slot",
                    fontSize: 16,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 20),

                  // Time Picker Wheel
                  Container(
                    height: 216,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDDCF4),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TimeWheelPicker(),
                  ),
                ],
              ),
            ),

            //CupertinoTimePickerWheel(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 21),
        child: GradientButton(
          text: "Book Session",
          onTap: () {
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _arrowBtn(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9F0),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 24),
    );
  }
}

class TimeWheelPicker extends StatefulWidget {
  const TimeWheelPicker({super.key});

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedAmPm = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPicker(
            12,
            _selectedHour,
            (i) => '${(i + 1).toString().padLeft(2, '0')}',
            (i) {
              setState(() => _selectedHour = i);
            },
          ),
          const SizedBox(width: 12),
          _buildPicker(
            60,
            _selectedMinute,
            (i) => i.toString().padLeft(2, '0'),
            (i) {
              setState(() => _selectedMinute = i);
            },
          ),
          const SizedBox(width: 12),
          _buildPicker(2, _selectedAmPm, (i) => i == 0 ? 'AM' : 'PM', (i) {
            setState(() => _selectedAmPm = i);
          }),
        ],
      ),
    );
  }

  Widget _buildPicker(
    int itemCount,
    int selectedItem,
    String Function(int) itemLabel,
    ValueChanged<int> onChanged,
  ) {
    return SizedBox(
      width: 80,
      height: 50,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: selectedItem,
        ),
        itemExtent: 40,
        onSelectedItemChanged: onChanged,
        useMagnifier: true,
        magnification: 1.2,
        backgroundColor: AppColors.text,
        children: List.generate(
          itemCount,
          (index) => Center(
            child: Text(
              itemLabel(index),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoTimePickerWheel extends StatefulWidget {
  const CupertinoTimePickerWheel({super.key});

  @override
  State<CupertinoTimePickerWheel> createState() =>
      _CupertinoTimePickerWheelState();
}

class _CupertinoTimePickerWheelState extends State<CupertinoTimePickerWheel> {
  int _selectedHour = DateTime.now().hour % 12;
  int _selectedMinute = DateTime.now().minute;
  int _selectedAmPm = DateTime.now().hour >= 12 ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCupertinoPicker(
            itemCount: 12,
            selectedItem: _selectedHour,
            onSelectedItemChanged: (index) {
              setState(() => _selectedHour = index);
            },
            labelBuilder: (index) => (index + 1).toString().padLeft(2, '0'),
          ),
          _buildCupertinoPicker(
            itemCount: 60,
            selectedItem: _selectedMinute,
            onSelectedItemChanged: (index) {
              setState(() => _selectedMinute = index);
            },
            labelBuilder: (index) => index.toString().padLeft(2, '0'),
          ),
          _buildCupertinoPicker(
            itemCount: 2,
            selectedItem: _selectedAmPm,
            onSelectedItemChanged: (index) {
              setState(() => _selectedAmPm = index);
            },
            labelBuilder: (index) => index == 0 ? 'AM' : 'PM',
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoPicker({
    required int itemCount,
    required int selectedItem,
    required ValueChanged<int> onSelectedItemChanged,
    required String Function(int) labelBuilder,
  }) {
    return SizedBox(
      width: 75,
      height: 150,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: selectedItem,
        ),
        itemExtent: 40,
        onSelectedItemChanged: onSelectedItemChanged,
        useMagnifier: true,
        magnification: 1.1,
        backgroundColor: Colors.transparent,
        children: List<Widget>.generate(
          itemCount,
          (index) => Center(
            child: Text(
              labelBuilder(index),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollTimePickerWheel extends StatefulWidget {
  final Function(DateTime) onTimeChanged;

  const ScrollTimePickerWheel({super.key, required this.onTimeChanged});

  @override
  State<ScrollTimePickerWheel> createState() => _ScrollTimePickerWheelState();
}

class _ScrollTimePickerWheelState extends State<ScrollTimePickerWheel> {
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _ampmController =
      FixedExtentScrollController();

  int _selectedHour = 11;
  int _selectedMinute = 0;
  bool _isAm = true;

  @override
  void initState() {
    super.initState();
    _initializePickers();
  }

  void _initializePickers() {
    final now = DateTime.now();
    _selectedHour = now.hour % 12;
    _selectedMinute = now.minute;
    _isAm = now.hour < 12;

    _hourController.jumpToItem(_selectedHour);
    _minuteController.jumpToItem(_selectedMinute);
    _ampmController.jumpToItem(_isAm ? 0 : 1);
  }

  void _updateParent() {
    final hour = _selectedHour == 12 ? 0 : _selectedHour;
    final actualHour = _isAm ? hour : hour + 12;
    widget.onTimeChanged(DateTime(2024, 1, 1, actualHour, _selectedMinute));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          controller: _hourController,
          itemCount: 12,
          onSelectedItemChanged: (index) {
            setState(() => _selectedHour = index + 1);
            _updateParent();
          },
          selectedIndex: _selectedHour - 1,
          formatLabel: (index) => (index + 1).toString().padLeft(2, '0'),
        ),
        _buildPicker(
          controller: _minuteController,
          itemCount: 60,
          onSelectedItemChanged: (index) {
            setState(() => _selectedMinute = index);
            _updateParent();
          },
          selectedIndex: _selectedMinute,
          formatLabel: (index) => index.toString().padLeft(2, '0'),
        ),
        _buildPicker(
          controller: _ampmController,
          itemCount: 2,
          onSelectedItemChanged: (index) {
            setState(() => _isAm = index == 0);
            _updateParent();
          },
          selectedIndex: _isAm ? 0 : 1,
          formatLabel: (index) => index == 0 ? "AM" : "PM",
        ),
      ],
    );
  }

  Widget _buildPicker({
    required FixedExtentScrollController controller,
    required int itemCount,
    required ValueChanged<int> onSelectedItemChanged,
    required int selectedIndex,
    required String Function(int) formatLabel,
  }) {
    return SizedBox(
      width: 75,
      height: 150,
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 40,
            diameterRatio: 1.3,
            onSelectedItemChanged: onSelectedItemChanged,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                bool isSelected = index == selectedIndex;
                return Container(
                  alignment: Alignment.center,
                  child: TimeTileWidget(
                    time: formatLabel(index),
                    isSelected: isSelected,
                  ),
                );
              },
              childCount: itemCount,
            ),
          ),
          // Highlight
          Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeTileWidget extends StatelessWidget {
  final String time;
  final bool isSelected;

  const TimeTileWidget({
    super.key,
    required this.time,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: TextStyle(
        fontSize: 20,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.black : Colors.grey,
      ),
    );
  }
}

class DynamicWeeklyCalendar extends StatefulWidget {
  @override
  _DynamicWeeklyCalendarState createState() => _DynamicWeeklyCalendarState();
}

class _DynamicWeeklyCalendarState extends State<DynamicWeeklyCalendar> {
  DateTime currentDate = DateTime.now();
  int selectedDayIndex = 0;

  List<DateTime> getCurrentWeekDates(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  void goToPreviousWeek() {
    setState(() {
      currentDate = currentDate.subtract(Duration(days: 7));
    });
  }

  void goToNextWeek() {
    setState(() {
      currentDate = currentDate.add(Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = getCurrentWeekDates(currentDate);
    final monthYear = DateFormat('MMMM yyyy').format(weekDates[0]);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFECFBF3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Month and Arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 36,
                width: 211,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9F0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: UIHelper.boldText(
                    text: monthYear,
                    fontSize: 12,
                    color: AppColors.textblue,
                  ),
                ),
              ),

              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color(0xffCEDBF1),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ⬅️ Previous Month
                    GestureDetector(
                      onTap: goToPreviousWeek,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: UIHelper.customSvg(svg: "left-svg.svg"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    /// ➡️ Next Month
                    GestureDetector(
                      onTap: goToNextWeek,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: UIHelper.customSvg(svg: "right-svg.svg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Weekdays Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                .map(
                  (day) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: UIHelper.mediumText(
                      text: day,
                      fontSize: 10,
                      color: AppColors.textblue,
                    ),
                  ),
                )
                .toList(), // ⬅️ આ .toList() હમણાં સાચા સ્થાન પર છે
          ),
          const SizedBox(height: 10),

          // Day Numbers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = weekDates[index];
              final isSelected = selectedDayIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                  });
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : const Color(0xFFDCE9F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
