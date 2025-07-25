import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:scan_bonus_card_example/presentation/provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 80.h),
              _buildThemeSettingsCard(themeProvider),
              SizedBox(height: 30.h),
              _buildActionsCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSettingsCard(ThemeProvider themeProvider) {
    return Container(
      width: 340.w,
      height: 101.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 4.r,
            color: Colors.black.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Theme of design",
            style: GoogleFonts.montserrat(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: GoogleFonts.montserrat(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                _buildThemeSwitch(themeProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSwitch(ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme(!themeProvider.isDarkMode);
      },
      child: SizedBox(
        height: 20.h,
        child: Stack(
          alignment: themeProvider.isDarkMode
              ? Alignment.centerRight
              : Alignment.centerLeft,
          children: [
            Container(
                width: 34.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                )),
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? const Color(0xFF7DB700)
                    : const Color(0xFFB70000),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context) {
    return Container(
      width: 340.w,
      constraints: BoxConstraints(
        minHeight: 145.h, // Use minHeight instead of fixed height
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 4.r,
            color: Colors.black.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            context,
            "Rate Us",
            onTap: () async {
              await InAppReview.instance.openStoreListing(
                appStoreId: '6749011652',
              );
            },
          ),
          _buildActionButton(
            context,
            "Privacy Policy",
            onTap: () async {
              final Uri url = Uri.parse(
                'https://docs.google.com/document/d/1RuYxFzzxd3LmNl8EHeZybh5mbvkTfpNVLHaxNeu0gnU/mobilebasic',
              );
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          _buildActionButton(
            context,
            "Contact Us",
            onTap: () async {
              String? encodeQueryParameters(
                Map<String, String> params,
              ) {
                return params.entries
                    .map(
                      (MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
                    )
                    .join('&');
              }

              // ···
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'vahaanqulubese23382@gmail.com',
                query: encodeQueryParameters(<String, String>{
                  '': '',
                }),
              );
              try {
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  throw Exception(
                    "Could not launch $emailLaunchUri",
                  );
                }
              } catch (e) {
                log(
                  'Error launching email client: $e',
                ); // Log the error
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.montserrat(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.white
                    : Colors.black,
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
