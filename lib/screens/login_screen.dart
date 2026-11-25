import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_widgets.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;
  bool _remember = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 720;
          final narrow = constraints.maxWidth < 360;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.pageGutter,
              8,
              AppTheme.pageGutter,
              12,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (constraints.maxHeight - 20).clamp(
                    0.0,
                    double.infinity,
                  ),
                  maxWidth: AppTheme.contentMaxWidth,
                ),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      const StudyShareBrand(),
                      SizedBox(height: compact ? 13 : 20),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: narrow ? 25 : 27,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Your learning journey continues here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: AppTheme.navy),
                      ),
                      SizedBox(height: compact ? 12 : 18),
                      // Original books artwork can be added here when supplied as an asset.
                      Container(
                        height: compact ? 82 : 105,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F2FF),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: compact ? 56 : 66,
                            color: const Color(0xFF7251DB),
                          ),
                        ),
                      ),
                      SizedBox(height: compact ? 11 : 16),
                      AuthField(
                        controller: _email,
                        label: 'Email Address',
                        icon: Icons.mail_rounded,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppTheme.fieldGap),
                      AuthField(
                        controller: _password,
                        label: 'Password',
                        icon: Icons.lock_rounded,
                        password: true,
                        visible: _showPassword,
                        onToggle: () =>
                            setState(() => _showPassword = !_showPassword),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Password is required'
                            : v.length < 6
                            ? 'Use at least 6 characters'
                            : null,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 0,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: _remember,
                                activeColor: AppTheme.purple,
                                onChanged: (v) =>
                                    setState(() => _remember = v ?? false),
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.navy,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => _message(
                              'Password recovery will be available soon.',
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 71, 19, 245),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AuthButton(
                        text: 'Sign In',
                        icon: Icons.login_rounded,
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _message(
                              'Sign in is ready for authentication integration.',
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 13),
                      const _OrDivider(),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () =>
                            _message('Google sign-in will be connected soon.'),
                        icon: const Text(
                          'G',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4285F4),
                          ),
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(49),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          side: const BorderSide(color: AppTheme.purple),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.controlRadius,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: AppTheme.navy),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            ),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: AppTheme.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );

  void _message(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: Divider(color: AppTheme.lavender)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text('OR', style: TextStyle(color: AppTheme.navy)),
      ),
      Expanded(child: Divider(color: AppTheme.lavender)),
    ],
  );
}
