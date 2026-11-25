import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class StudyShareBrand extends StatelessWidget {
  const StudyShareBrand({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final small = width < 380;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.school_rounded,
          size: compact || small ? 48 : 58,
          color: AppTheme.purple,
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: compact || small ? 29 : 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
              color: AppTheme.navy,
            ),
            children: const [
              TextSpan(text: 'Study'),
              TextSpan(
                text: 'Share',
                style: TextStyle(color: AppTheme.purple),
              ),
            ],
          ),
        ),
        if (!compact) ...[
          const SizedBox(height: 6),
          Text(
            'Learn Together. Share Knowledge.',
            style: TextStyle(
              fontSize: small ? 13 : 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.navy,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.password = false,
    this.visible = false,
    this.onToggle,
    this.keyboardType,
    this.textInputAction,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool password;
  final bool visible;
  final VoidCallback? onToggle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    obscureText: password && !visible,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    decoration: InputDecoration(
      hintText: label,
      isDense: true,
      hintStyle: const TextStyle(color: AppTheme.muted, fontSize: 15),
      prefixIcon: Icon(icon, color: AppTheme.purple),
      suffixIcon: password
          ? IconButton(
              onPressed: onToggle,
              icon: Icon(
                visible ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.muted,
              ),
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: AppTheme.lavender, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: AppTheme.lavender, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: AppTheme.purple, width: 1.7),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.controlRadius),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    ),
  );
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 52,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6E35ED), Color(0xFF5730CC)],
        ),
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: AppTheme.purple.withValues(alpha: .23),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
      ),
    ),
  );
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Email is required';
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())) {
    return 'Enter a valid email address';
  }
  return null;
}
