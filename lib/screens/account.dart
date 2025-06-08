import 'package:bytecart/models/constants/appbar.dart';
import 'package:bytecart/models/users/user_type.dart';
import 'package:bytecart/screens/login.dart';
import 'package:bytecart/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Account Page Main Widget
class AccountPage extends StatelessWidget {
  final User user;

  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: app_bar.mainAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          // Landscape Layout
          if (isLandscape) {
            return Row(
              children: [
                // User Profile Section
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: _ProfileCard(
                    user: user,
                    isDark: isDark,
                    isLandscape: true,
                  ),
                ),
                // Account Content Section (Scrollable)
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      children: _buildAccountContent(context, isDark),
                    ),
                  ),
                ),
              ],
            );
          }
          // Portrait Layout
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                _ProfileCard(user: user, isDark: isDark, isLandscape: false),
                const SizedBox(height: 30),
                ..._buildAccountContent(context, isDark),
              ],
            ),
          );
        },
      ),
    );
  }

  // Account Content Section
  List<Widget> _buildAccountContent(BuildContext context, bool isDark) {
    return [
      // Account Info Section
      const Text(
        'Update your info to keep your account',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      accountSettings(
        icon: Icons.account_circle,
        title: 'Account information',
        color: Colors.blue,
      ),
      const SizedBox(height: 16),
      accountSettings(
        icon: Icons.payment,
        title: 'Billing',
        color: Colors.teal,
      ),
      const SizedBox(height: 30),
      // Preferences Section
      const Text(
        'Preferences',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      accountSettings(
        icon: Icons.notifications,
        title: 'Notifications',
        color: Colors.orange,
      ),
      const SizedBox(height: 16),
      accountSettings(
        icon: isDark ? Icons.nightlight_round : Icons.wb_sunny,
        title: isDark ? 'Change to Light Mode' : 'Change to Dark Mode',
        color: Colors.amber,
        onTap:
            () =>
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme(),
      ),
      const SizedBox(height: 30),
      // More Information Section
      const Text(
        'More Information',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      accountSettings(
        icon: Icons.info,
        title: 'About Us',
        color: Colors.blueGrey,
      ),
      const SizedBox(height: 16),
      accountSettings(
        icon: Icons.privacy_tip,
        title: 'Privacy',
        color: Colors.indigo,
      ),
      const SizedBox(height: 16),
      accountSettings(
        icon: Icons.contact_mail,
        title: 'Contact Us',
        color: Colors.green,
      ),
      const SizedBox(height: 30),
      // Account Actions Section
      const Text(
        'Account Actions',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      accountSettings(
        icon: Icons.logout,
        title: 'Logout',
        color: Colors.redAccent,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return AlertDialog(
                backgroundColor:
                    isDark ? const Color(0xFF121212) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    ];
  }

  // Account Setting Tile
  Widget accountSettings({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF121212) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: SizedBox(
                  height: 60,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: color.withOpacity(0.2),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// User Profile Card Widget (Stateless, for both orientations)
class _ProfileCard extends StatelessWidget {
  final User user;
  final bool isDark;
  final bool isLandscape;

  const _ProfileCard({
    required this.user,
    required this.isDark,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    if (isLandscape) {
      return Container(
        width: 320,
        height: 180,
        decoration: BoxDecoration(
          color:
              isDark
                  ? const Color(0xFF121212)
                  : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFF007BFF),
                child: Icon(Icons.person, size: 28, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF121212)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF007BFF),
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(user.email),
            ],
          ),
        ],
      ),
    );
  }
}
