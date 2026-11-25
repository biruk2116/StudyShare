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
  String? _department;
  String? _year;
  bool _terms = false;
  bool _showDropdownErrors = false;
  bool _showPassword = false;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WaveBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 740 ||
                MediaQuery.sizeOf(context).width < 360;
            final tiny = constraints.maxHeight < 650;
            final horizontalPadding = MediaQuery.sizeOf(context).width < 360
                ? 16.0
                : 24.0;
            final gap = compact ? 6.0 : AppSpace.fieldGap;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                2,
                horizontalPadding,
                12,
              ),
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
                            height: 40,
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
                        const AuthHeader(compact: true, prominent: true),
                        SizedBox(height: compact ? 2 : 6),
                        Text(
                          'Join StudyShare',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Connect, learn, and share knowledge.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.navy),
                        ),
                        SizedBox(height: tiny ? 1 : (compact ? 3 : 6)),
                        SizedBox(
                          height: tiny ? 55 : (compact ? 68 : 82),
                          width: double.infinity,
                          child: SvgPicture.asset(
                            'assets/images/login_illustration.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: tiny ? 2 : 5),
                        AppTextField(
                          controller: _name,
                          label: 'Full Name',
                          icon: Icons.person_rounded,
                          textInputAction: TextInputAction.next,
                          validator: (v) => v == null || v.trim().length < 2
                              ? 'Enter your full name'
                              : null,
                          compact: true,
                        ),
                        SizedBox(height: gap),
                        AppTextField(
                          controller: _email,
                          label: 'Email Address',
                          icon: Icons.mail_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _emailValidator,
                          compact: true,
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
                          compact: true,
                        ),
                        SizedBox(height: gap),
                        AppDropdownField(
                          value: _year,
                          label: 'Academic Year',
                          icon: Icons.school_rounded,
                          options: _years,
                          showError: _showDropdownErrors,
                          onChanged: (value) => setState(() => _year = value),
                          compact: true,
                        ),
                        SizedBox(height: gap),
                        AppTextField(
                          controller: _password,
                          label: 'Password',
                          icon: Icons.lock_rounded,
                          password: true,
                          visible: _showPassword,
                          onToggle: () =>
                              setState(() => _showPassword = !_showPassword),
                          textInputAction: TextInputAction.next,
                          validator: _passwordValidator,
                          compact: true,
                        ),
                        SizedBox(height: gap),
                        const SizedBox(height: 1),
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
                          builder: (context, auth, _) => Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 360),
                              child: PrimaryButton(
                                label: 'Create Account',
                                icon: Icons.person_add_alt_1_rounded,
                                enabled: _terms,
                                loading: auth.isLoading,
                                compact: true,
                                onPressed: _terms
                                    ? () => _submit(context, auth)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
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
                            TextButton(
                              onPressed: () => context.go('/login'),
                              style: TextButton.styleFrom(
                                minimumSize: const Size(48, 44),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                tapTargetSize: MaterialTapTargetSize.padded,
                              ),
                              child: const Text(
                                'Back to Sign In',
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: tiny ? 8 : 14),
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
