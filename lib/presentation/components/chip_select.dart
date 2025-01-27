import 'package:flutter/material.dart';

import '../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class ChipSelect extends StatefulWidget {
  const ChipSelect({
    super.key,
    required this.titles,
    required this.actions,
    required this.selectedChip,
  });

  final List<String> titles;
  final List<Function()> actions;
  final String selectedChip;

  @override
  State<ChipSelect> createState() => _ChipSelectState();
}

class _ChipSelectState extends State<ChipSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF4F6F9),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.actions[0],
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: widget.selectedChip == widget.titles[0].toUpperCase()
                      ? Colors.white
                      : const Color(0xFFF4F6F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.selectedChip == widget.titles[0].toUpperCase()
                        ? cPrimary
                        : Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.titles[0],
                    style: TextStyle(
                      color:
                          widget.selectedChip == widget.titles[0].toUpperCase()
                              ? cPrimary
                              : Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: widget.actions[1],
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: widget.selectedChip == widget.titles[1].toUpperCase()
                      ? Colors.white
                      : const Color(0xFFF4F6F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.selectedChip == widget.titles[1].toUpperCase()
                        ? cPrimary
                        : Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.titles[1],
                    style: TextStyle(
                      color:
                          widget.selectedChip == widget.titles[1].toUpperCase()
                              ? cPrimary
                              : Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
