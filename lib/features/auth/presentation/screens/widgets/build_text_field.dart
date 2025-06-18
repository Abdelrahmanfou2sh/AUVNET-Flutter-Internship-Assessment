import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField({
  required String hint,
  required IconData prefix,
  String? Function(String?)? validator,
  Widget? suffix,
  bool obscure = false,
  TextEditingController? controller,
}) {
  return Container(
    width: 300.w,
    margin: EdgeInsets.symmetric(vertical: 8.h),
    decoration: BoxDecoration(
      color: const Color(0xFFC4C4C4).withOpacity(0.2),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: AppTextStyles.mulishLight14,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix, color: Colors.grey, size: 20.sp),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
      ),
    ),
  );
}
