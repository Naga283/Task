import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadingAndDisableTextFormField extends ConsumerWidget {
  const HeadingAndDisableTextFormField({
    super.key,
    required this.heading,
    required this.hintText,
  });
  final String heading;
  final String hintText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 20,
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          enabled: false,
        ),
      ],
    );
  }
}
