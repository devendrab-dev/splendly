import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_colors.dart';

class AnimatedSegmentedControl extends StatefulWidget {
  const AnimatedSegmentedControl({
    super.key,
    required this.labels,
    this.onChanged,
  });

  final List<String> labels;
  final Function(int onChanged)? onChanged;

  @override
  State<AnimatedSegmentedControl> createState() =>
      _AnimatedSegmentedControlState();
}

class _AnimatedSegmentedControlState extends State<AnimatedSegmentedControl> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .symmetric(horizontal: 20, vertical: 12),
      padding: const .all(6),
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: .circular(14),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / widget.labels.length;
          return Stack(
            alignment: .centerLeft,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                left: selectedIndex * segmentWidth,
                child: Container(
                  width: segmentWidth,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: .circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withValues(alpha: 0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(widget.labels.length, (index) {
                  final isSelected = index == selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      behavior: .opaque,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          widget.onChanged?.call(index);
                        });
                      },
                      child: Container(
                        height: 42,
                        alignment: .center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: isSelected ? .w600 : .w500,
                            fontSize: 15,
                          ),
                          child: Text(widget.labels[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
