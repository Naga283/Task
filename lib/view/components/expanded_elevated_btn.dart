import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/utils/colors.dart';

class ExpandedElevatedBtn extends ConsumerWidget {
  const ExpandedElevatedBtn({
    super.key,
    required this.btnName,
    required this.onTap,
    this.isLoading,
    this.height,
  });
  final String btnName;
  final Function() onTap;
  final bool? isLoading;
  final double? height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: (isLoading ?? false)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: appColors.whiteColor,
                  ),
                )
              : Text(
                  btnName,
                  style: TextStyle(
                    color: appColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
