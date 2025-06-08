import 'package:bytecart/models/constants/bottomnav.dart';
import 'package:bytecart/models/users/user_list.dart';
import 'package:bytecart/models/users/user_type.dart';
import 'package:bytecart/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers for input fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _error, _success;
  bool _obscurePassword = true;

  // Registration logic
  void _register() {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _error = 'All fields are required';
        _success = null;
      });
      return;
    }
    if (users.any((u) => u.email == email)) {
      setState(() {
        _error = 'Email already registered';
        _success = null;
      });
      return;
    }
    final newUser = User(fullName: fullName, email: email, password: password);
    users.add(newUser);
    setState(() {
      _error = null;
      _success = 'Registration successful! Logging in...';
    });
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => BottomNav(user: newUser)),
        (_) => false,
      );
    });
  }

  // Navigate to Login Page
  void _goToLogin() => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (_) => false,
  );

  // Input decoration for text fields
  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
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
    // Dispose controllers to free memory
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    // Logo/header section
    final logoHeader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo/Logo L-R.webp',
          height: 55,
          cacheHeight: 110, // Optimize image memory usage
        ),
        const SizedBox(height: 24),
        const Text(
          'Sign up for an Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your details to create an account',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );

    // Registration form section
    final registerForm = Container(
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
          // Social sign up buttons
          Row(
            children: List.generate(3, (i) {
              final assets = [
                'assets/images/icons/Google.svg',
                'assets/images/icons/Facebook.svg',
                isDark
                    ? 'assets/images/icons/Apple Dark.svg'
                    : 'assets/images/icons/Apple Light.svg',
              ];
              return Expanded(
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
                    child: SvgPicture.asset(assets[i], height: 28, width: 28),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          // Divider with "Or sign up with"
          Row(
            children: [
              const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Or sign up with',
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
          // Full Name input
          TextField(
            controller: _fullNameController,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.onSurface,
            decoration: _inputDecoration('Full Name', Icons.person_outline),
          ),
          const SizedBox(height: 16),
          // Email input
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.onSurface,
            decoration: _inputDecoration('Email', Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          // Password input
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.onSurface,
            decoration: _inputDecoration(
              'Password',
              Icons.lock_outline,
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
          if (_success != null) ...[
            const SizedBox(height: 12),
            Text(
              _success!,
              style: const TextStyle(color: Colors.green, fontSize: 14),
            ),
          ],
          const SizedBox(height: 16),
          // Sign Up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Link to Login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: _goToLogin,
                child: const Text(
                  'Log In',
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

    // Main layout
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          if (isLandscape) {
            // Landscape: left logo, right form
            return Row(
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height,
                  child: Container(
                    color: const Color(0xFF007BFF),
                    child: Center(child: logoHeader),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 420,
                          minWidth: 320,
                        ),
                        child: registerForm,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Portrait: top logo, below form
            return Stack(
              children: [
                Container(
                  height: size.height * 0.5,
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
                        registerForm,
                        SizedBox(height: size.height * 0.04),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
