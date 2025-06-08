import 'package:bytecart/models/constants/bottomnav.dart';
import 'package:bytecart/models/users/user_list.dart';
import 'package:bytecart/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  // Login logic and navigation
  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final user = users.where((u) => u.email == email && u.password == password);
    setState(() {
      if (user.isNotEmpty) {
        _error = null;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => BottomNav(user: user.first)),
          (_) => false,
        );
      } else {
        _error = 'Invalid email or password';
      }
    });
  }

  // Input decoration for text fields
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Theme.of(context).hintColor),
    prefixIcon: Icon(icon, color: Theme.of(context).hintColor),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    // Logo and header section
    final logoHeader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo/Logo L-R.webp',
          height: 55,
          cacheHeight: 110, // Optimize image memory usage
          filterQuality: FilterQuality.medium,
        ),
        const SizedBox(height: 24),
        const Text(
          'Login to your Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your email and password to log in',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );

    // Login form section
    final loginForm = Container(
      width: size.width > size.height ? 400 : double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width > size.height ? 0 : 18,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Social login buttons
          Row(
            children: [
              for (final asset in [
                'assets/images/icons/Google.svg',
                'assets/images/icons/Facebook.svg',
                isDark
                    ? 'assets/images/icons/Apple Dark.svg'
                    : 'assets/images/icons/Apple Light.svg',
              ])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            isDark
                                ? const Color(0xFF121212)
                                : colorScheme.surface,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(
                        asset,
                        height: 28,
                        width: 28,
                        fit: BoxFit.contain,
                        cacheColorFilter: true,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Divider with "Or login with"
          Row(
            children: [
              const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Or login with',
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            ],
          ),
          const SizedBox(height: 20),
          // Email input
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.onSurface,
            decoration: _inputDecoration(
              hint: 'Email',
              icon: Icons.email_outlined,
            ),
          ),
          const SizedBox(height: 16),
          // Password input
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.onSurface,
            decoration: _inputDecoration(
              hint: 'Password',
              icon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).hintColor,
                ),
                onPressed:
                    () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
          const SizedBox(height: 12),
          // Remember me and forgot password
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged:
                    (value) => setState(() => _rememberMe = value ?? false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.grey, width: 2),
                ),
                side: const BorderSide(color: Colors.grey, width: 2),
                activeColor: const Color(0xFF007BFF),
              ),
              Text(
                'Remember me',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Login button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sign up navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // Responsive layout
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          if (isLandscape) {
            // Landscape: split screen
            return Row(
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  height: size.height,
                  child: Container(
                    color: const Color(0xFF007BFF),
                    child: Center(child: logoHeader),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.55,
                  height: size.height,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 420,
                          minWidth: 320,
                        ),
                        child: loginForm,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          // Portrait: stacked layout
          return Stack(
            children: [
              Container(
                height: size.height * 0.45,
                width: double.infinity,
                color: const Color(0xFF007BFF),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.08),
                      logoHeader,
                      SizedBox(height: size.height * 0.07),
                      loginForm,
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
