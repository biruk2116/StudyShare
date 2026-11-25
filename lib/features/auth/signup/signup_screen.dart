import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/auth_widgets.dart';
import '../application/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? _department;
  String? _year;
  bool _terms = false;
  bool _showDropdownErrors = false;
  bool _showPassword = false;
  bool _showConfirm = false;

  static const _departments = [
    'Computer Science',
    'Engineering',
    'Business',
    'Medicine',
    'Law',
    'Arts & Humanities',
    'Natural Sciences',
    'Other',
  ];
  static const _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    '5th Year',
    'Graduate',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WaveBackground(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 116,
            child: IgnorePointer(
              child: Opacity(
                opacity: .76,
                child: SvgPicture.asset(
                  'assets/images/campus_footer.svg',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 790;
                final gap = compact ? 8.0 : AppSpace.fieldGap;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 2, 24, 12),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: Material(
                                  color: const Color(0xFFE8E0FF),
                                  shape: const CircleBorder(),
                                  child: IconButton(
                                    onPressed: () => context.go('/login'),
                                    tooltip: 'Back to sign in',
                                    icon: const Icon(
                                      Icons.chevron_left_rounded,
                                      color: AppColors.navy,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const AuthHeader(),
                            SizedBox(height: compact ? 6 : 10),
                            Text(
                              'Join StudyShare',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Connect, learn, and share knowledge.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.navy,
                              ),
                            ),
                            SizedBox(height: compact ? 11 : 16),
                            AppTextField(
                              controller: _name,
                              label: 'Full Name',
                              icon: Icons.person_rounded,
                              textInputAction: TextInputAction.next,
                              validator: (v) => v == null || v.trim().length < 2
                                  ? 'Enter your full name'
                                  : null,
                            ),
                            SizedBox(height: gap),
                            AppTextField(
                              controller: _email,
                              label: 'Email Address',
                              icon: Icons.mail_rounded,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: _emailValidator,
                            ),
                            SizedBox(height: gap),
                            AppDropdownField(
                              value: _department,
                              label: 'Department',
                              icon: Icons.account_balance_rounded,
                              options: _departments,
                              showError: _showDropdownErrors,
                              onChanged: (value) =>
                                  setState(() => _department = value),
                            ),
                            SizedBox(height: gap),
                            AppDropdownField(
                              value: _year,
                              label: 'Academic Year',
                              icon: Icons.school_rounded,
                              options: _years,
                              showError: _showDropdownErrors,
                              onChanged: (value) =>
                                  setState(() => _year = value),
                            ),
                            SizedBox(height: gap),
                            AppTextField(
                              controller: _password,
                              label: 'Password',
                              icon: Icons.lock_rounded,
                              password: true,
                              visible: _showPassword,
                              onToggle: () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: _passwordValidator,
                            ),
                            SizedBox(height: gap),
                            AppTextField(
                              controller: _confirm,
                              label: 'Confirm Password',
                              icon: Icons.lock_rounded,
                              password: true,
                              visible: _showConfirm,
                              onToggle: () =>
                                  setState(() => _showConfirm = !_showConfirm),
                              textInputAction: TextInputAction.done,
                              validator: (v) => v != _password.text
                                  ? 'Passwords do not match'
                                  : null,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Checkbox(
                                  value: _terms,
                                  activeColor: AppColors.purple,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (value) =>
                                      setState(() => _terms = value ?? false),
                                ),
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      const Text(
                                        'I agree to the ',
                                        style: TextStyle(
                                          color: AppColors.navy,
                                          fontSize: 14,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _message(
                                          context,
                                          'Terms and Conditions will be available soon.',
                                        ),
                                        child: const Text(
                                          'Terms and Conditions',
                                          style: TextStyle(
                                            color: AppColors.purple,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Consumer<AuthController>(
                              builder: (context, auth, _) => PrimaryButton(
                                label: 'Create Account',
                                icon: Icons.person_add_alt_1_rounded,
                                enabled: _terms,
                                loading: auth.isLoading,
                                onPressed: _terms
                                    ? () => _submit(context, auth)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 11),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: AppColors.navy,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.go('/login'),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: AppColors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 94),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _submit(BuildContext context, AuthController auth) async {
    setState(() => _showDropdownErrors = true);
    if (!_formKey.currentState!.validate() ||
        _department == null ||
        _year == null) {
      return;
    }
    try {
      await auth.signUp(
        name: _name.text.trim(),
        email: _email.text.trim(),
        department: _department!,
        year: _year!,
        password: _password.text,
      );
      if (context.mounted) {
        _message(
          context,
          'Your account is ready. Authentication is in demo mode.',
        );
      }
    } catch (_) {
      if (context.mounted) {
        _message(
          context,
          'Unable to create your account right now. Please try again.',
        );
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
