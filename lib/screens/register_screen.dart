import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? _department;
  String? _year;
  bool _terms = false;
  bool _showPassword = false;
  bool _showConfirm = false;

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
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.pageGutter,
            2,
            AppTheme.pageGutter,
            8,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 10).clamp(
                  0.0,
                  double.infinity,
                ),
                maxWidth: AppTheme.contentMaxWidth,
              ),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 36,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppTheme.navy,
                          ),
                        ),
                      ),
                    ),
                    const StudyShareBrand(compact: true),
                    const SizedBox(height: 9),
                    const Text(
                      'Join StudyShare',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Connect, learn, and share knowledge.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: AppTheme.navy),
                    ),
                    const SizedBox(height: 13),
                    AuthField(
                      controller: _name,
                      label: 'Full Name',
                      icon: Icons.person,
                      validator: (v) => v == null || v.trim().length < 2
                          ? 'Enter your full name'
                          : null,
                    ),
                    const SizedBox(height: AppTheme.fieldGap),
                    AuthField(
                      controller: _email,
                      label: 'Email Address',
                      icon: Icons.mail_rounded,
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppTheme.fieldGap),
                    _DropdownField<String>(
                      value: _department,
                      hint: 'Department',
                      icon: Icons.account_balance,
                      items: const [
                        'Computer Science',
                        'Business',
                        'Engineering',
                        'Education',
                        'Health Sciences',
                        'Other',
                      ],
                      onChanged: (v) => setState(() => _department = v),
                    ),
                    const SizedBox(height: AppTheme.fieldGap),
                    _DropdownField<String>(
                      value: _year,
                      hint: 'Academic Year',
                      icon: Icons.school,
                      items: const [
                        '1st Year',
                        '2nd Year',
                        '3rd Year',
                        '4th Year',
                        '5th Year',
                        'Postgraduate',
                      ],
                      onChanged: (v) => setState(() => _year = v),
                    ),
                    const SizedBox(height: AppTheme.fieldGap),
                    AuthField(
                      controller: _password,
                      label: 'Password',
                      icon: Icons.lock,
                      password: true,
                      visible: _showPassword,
                      onToggle: () =>
                          setState(() => _showPassword = !_showPassword),
                      validator: (v) => v == null || v.length < 6
                          ? 'Use at least 6 characters'
                          : null,
                    ),
                    const SizedBox(height: AppTheme.fieldGap),
                    AuthField(
                      controller: _confirm,
                      label: 'Confirm Password',
                      icon: Icons.lock,
                      password: true,
                      visible: _showConfirm,
                      onToggle: () =>
                          setState(() => _showConfirm = !_showConfirm),
                      validator: (v) =>
                          v != _password.text ? 'Passwords do not match' : null,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: _terms,
                          activeColor: AppTheme.purple,
                          onChanged: (v) => setState(() => _terms = v ?? false),
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              const Text(
                                'I agree to the ',
                                style: TextStyle(color: AppTheme.navy),
                              ),
                              GestureDetector(
                                onTap: () => _message(
                                  'Terms and Conditions will be available soon.',
                                ),
                                child: const Text(
                                  'Terms and Conditions',
                                  style: TextStyle(
                                    color: AppTheme.purple,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AuthButton(
                      text: 'Create Account',
                      icon: Icons.person_add_alt_1,
                      onPressed: () {
                        final valid = _form.currentState!.validate();
                        if (_department == null || _year == null || !_terms) {
                          _message(
                            !_terms
                                ? 'Please accept the Terms and Conditions.'
                                : 'Select your department and academic year.',
                          );
                        } else if (valid) {
                          _message(
                            'Your account details are ready for registration.',
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 11),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: AppTheme.navy),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppTheme.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Original campus artwork can be added here when supplied as an asset.
                    const Icon(
                      Icons.account_balance_rounded,
                      size: 42,
                      color: Color(0xFF8270DB),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  void _message(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.value,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onChanged,
  });
  final T? value;
  final String hint;
  final IconData icon;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    initialValue: value,
    validator: (v) => v == null ? 'Please select $hint' : null,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppTheme.purple),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: AppTheme.lavender, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: AppTheme.lavender, width: 1.5),
      ),
    ),
    hint: Text(hint, style: const TextStyle(color: AppTheme.muted)),
    items: items
        .map(
          (item) =>
              DropdownMenuItem<T>(value: item, child: Text(item.toString())),
        )
        .toList(),
    onChanged: onChanged,
  );
}
