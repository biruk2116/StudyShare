import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/auth_widgets.dart';
import '../application/auth_controller.dart';
import '../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _remember = true;
  bool _showPassword = false;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _restoreEmail();
  }

  Future<void> _restoreEmail() async {
    try {
      final saved = await _storage.read(key: 'studyshare.remembered_email');
      if (mounted && saved != null && saved.isNotEmpty) _email.text = saved;
    } catch (_) {
      // Secure storage is optional on devices where the platform service is unavailable.
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WaveBackground(
      campusAtTop: true,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 780;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const AuthHeader(showTagline: true),
                        SizedBox(height: compact ? 12 : 20),
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Your learning journey continues here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.navy),
                        ),
                        SizedBox(height: compact ? 8 : 14),
                        SizedBox(
                          height: compact ? 130 : 155,
                          width: double.infinity,
                          child: SvgPicture.asset(
                            'assets/images/login_illustration.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 7),
                        AppTextField(
                          controller: _email,
                          label: 'Email Address',
                          icon: Icons.mail_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _emailValidator,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller: _password,
                          label: 'Password',
                          icon: Icons.lock_rounded,
                          password: true,
                          visible: _showPassword,
                          onToggle: () =>
                              setState(() => _showPassword = !_showPassword),
                          textInputAction: TextInputAction.done,
                          validator: _passwordValidator,
                        ),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _remember,
                                  activeColor: AppColors.purple,
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (value) => setState(
                                    () => _remember = value ?? false,
                                  ),
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: AppColors.navy,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => _message(
                                context,
                                'Password recovery will be available soon.',
                              ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Consumer<AuthController>(
                          builder: (context, auth, _) => PrimaryButton(
                            label: 'Sign In',
                            icon: Icons.login_rounded,
                            loading: auth.isLoading,
                            onPressed: () => _submit(context, auth),
                          ),
                        ),
                        const SizedBox(height: 13),
                        const _OrDivider(),
                        const SizedBox(height: 12),
                        OutlinedSocialButton(
                          onPressed: () => _message(
                            context,
                            'Google sign-in is ready to connect.',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.go('/signup'),
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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
    ),
  );

  Future<void> _submit(BuildContext context, AuthController auth) async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await auth.signIn(_email.text.trim(), _password.text);
      try {
        await AuthRepository().saveRememberedEmail(
          _remember ? _email.text.trim() : null,
        );
      } catch (_) {
        // A storage failure must not turn a successful sign-in into an error.
      }
      if (context.mounted) {
        _message(
          context,
          'Welcome to StudyShare. Authentication is in demo mode.',
        );
      }
    } catch (_) {
      if (context.mounted) {
        _message(context, 'Unable to sign in right now. Please try again.');
      }
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(value) ||
        !RegExp(r'\d').hasMatch(value)) {
      return 'Use 8+ characters with a capital letter and number';
    }
    return null;
  }
}

void _message(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: Divider(color: AppColors.border)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text('OR', style: TextStyle(color: AppColors.navy)),
      ),
      Expanded(child: Divider(color: AppColors.border)),
    ],
  );
}
