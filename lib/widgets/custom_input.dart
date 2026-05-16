import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final bool isLight; // Admin uses light theme input

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.suffix,
    this.isLight = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final bool isDark = !widget.isLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.dkSecondary : AppColors.ltSecondary,
            fontFamily: 'DMSans',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure && _hidden,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.dkText : AppColors.ltText,
            fontFamily: 'DMSans',
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: isDark ? AppColors.dkSecondary : const Color(0xFFB0BEC5),
              fontSize: 14,
            ),
            filled: true,
            fillColor: isDark ? AppColors.dkBg : AppColors.ltBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? AppColors.dkBorder : AppColors.ltBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? AppColors.dkBorder : AppColors.ltBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? AppColors.dkAccent : AppColors.ltPrimary,
              ),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.obscure
                ? GestureDetector(
              onTap: () => setState(() => _hidden = !_hidden),
              child: Icon(
                _hidden ? Icons.visibility_off : Icons.visibility,
                color: isDark ? AppColors.dkSecondary : AppColors.ltSecondary,
                size: 18,
              ),
            )
                : widget.suffix,
          ),
        ),
      ],
    );
  }
}