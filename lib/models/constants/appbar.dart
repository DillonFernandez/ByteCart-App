import 'package:flutter/material.dart';

/// AppBar section: Contains main app bar widget and helpers.
class app_bar {
  // Returns background color based on theme brightness
  static Color backgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? const Color(0xFF121212)
        : Theme.of(context).colorScheme.surface;
  }

  // Returns the app logo widget (do not modify)
  static Widget logo(BuildContext context) {
    return Image.asset('assets/images/logo/Logo.webp', height: 35);
  }

  // Main AppBar widget
  static PreferredSizeWidget mainAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 5),
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: backgroundColor(context),
          boxShadow:
              isLight
                  ? [
                    const BoxShadow(
                      color: Color.fromARGB(15, 0, 0, 0),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              logo(context),
              const SizedBox(width: 16),
              // Search bar section
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color:
                        theme.brightness == Brightness.dark
                            ? const Color(0xFF121212)
                            : colorScheme.surface,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 20,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      // Search TextField
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
