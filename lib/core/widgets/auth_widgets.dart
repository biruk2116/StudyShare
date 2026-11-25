import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({
    super.key,
    required this.child,
    this.campusAtTop = false,
  });
  final Widget child;
  final bool campusAtTop;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lavender, Color(0xFFFAF9FF), Colors.white],
            stops: [0, .42, 1],
          ),
        ),
      ),
      const Positioned.fill(child: CustomPaint(painter: _WavePainter())),
      if (campusAtTop)
        Positioned(
          top: 14,
          right: -36,
          width: 210,
          height: 165,
          child: IgnorePointer(
            child: Opacity(
              opacity: .33,
              child: SvgPicture.asset(
                'assets/images/campus_bg.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      child,
    ],
  );
}

class _WavePainter extends CustomPainter {
  const _WavePainter();
  @override
  void paint(Canvas canvas, Size size) {
    final blob = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF7C5CF5), AppColors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, 180, 150));
    final corner = Path()
      ..moveTo(0, 0)
      ..lineTo(190, 0)
      ..cubicTo(160, 58, 114, 77, 0, 116)
      ..close();
    canvas.drawPath(corner, blob);
    final light = Paint()..color = const Color(0x66FFFFFF);
    final upperWave = Path()
      ..moveTo(0, 86)
      ..cubicTo(84, 63, 130, 55, 203, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(upperWave, light);
    final bottomPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.purple, Color(0xFF8C71F1)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, size.height - 90, size.width, 90));
    final bottom = Path()
      ..moveTo(0, size.height - 40)
      ..cubicTo(
        size.width * .3,
        size.height + 8,
        size.width * .69,
        size.height - 56,
        size.width,
        size.height - 15,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(bottom, bottomPaint);
    final pale = Paint()..color = const Color(0x77FFFFFF);
    final bottomShine = Path()
      ..moveTo(0, size.height - 18)
      ..cubicTo(
        size.width * .3,
        size.height + 20,
        size.width * .75,
        size.height - 48,
        size.width,
        size.height - 42,
      )
      ..lineTo(size.width, size.height - 18)
      ..cubicTo(
        size.width * .68,
        size.height - 20,
        size.width * .28,
        size.height + 15,
        0,
        size.height + 2,
      )
      ..close();
    canvas.drawPath(bottomShine, pale);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.showTagline = false});
  final bool showTagline;
  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 380;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: narrow ? 96 : 108,
          height: narrow ? 64 : 70,
        ),
        const SizedBox(height: 1),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: narrow ? 35 : 39,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.7,
                color: AppColors.navy,
              ),
              children: const [
                TextSpan(text: 'Study'),
                TextSpan(
                  text: 'Share',
                  style: TextStyle(color: AppColors.purple),
                ),
              ],
            ),
          ),
        ),
        if (showTagline) ...[
          const SizedBox(height: 3),
          const Text(
            'Learn Together. Share Knowledge.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
        ],
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.password = false,
    this.visible = false,
    this.onToggle,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool password;
  final bool visible;
  final VoidCallback? onToggle;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _focused = false;
  @override
  Widget build(BuildContext context) => Focus(
    onFocusChange: (value) => setState(() => _focused = value),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpace.radius),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: .16),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: .06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.password && !widget.visible,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          hintText: widget.label,
          prefixIcon: Icon(widget.icon, color: AppColors.purple, size: 23),
          suffixIcon: widget.password
              ? IconButton(
                  tooltip: widget.visible ? 'Hide password' : 'Show password',
                  onPressed: widget.onToggle,
                  icon: Icon(
                    widget.visible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: AppColors.hint,
                    size: 21,
                  ),
                )
              : null,
        ),
      ),
    ),
  );
}

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.options,
    required this.onChanged,
    this.showError = false,
  });
  final String? value;
  final String label;
  final IconData icon;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(AppSpace.radius),
    onTap: () async {
      final selection = await showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.white,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Choose $label',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...options.map(
                (option) => ListTile(
                  title: Text(
                    option,
                    style: const TextStyle(color: AppColors.navy),
                  ),
                  trailing: option == value
                      ? const Icon(Icons.check_rounded, color: AppColors.purple)
                      : null,
                  onTap: () => Navigator.pop(context, option),
                ),
              ),
            ],
          ),
        ),
      );
      if (selection != null) onChanged(selection);
    },
    child: InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.purple),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.navy,
        ),
        errorText: showError && value == null ? 'Choose a $label' : null,
      ),
      child: Text(
        value ?? label,
        style: TextStyle(
          fontSize: 16,
          color: value == null ? AppColors.hint : AppColors.navy,
        ),
      ),
    ),
  );
}

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
  });
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final active =
        widget.enabled && !widget.loading && widget.onPressed != null;
    return AnimatedScale(
      scale: _pressed && active ? .98 : 1,
      duration: const Duration(milliseconds: 100),
      child: Opacity(
        opacity: active ? 1 : .6,
        child: SizedBox(
          height: AppSpace.buttonHeight,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6D4AF0), Color(0xFF5233D6)],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: .30),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : const [],
            ),
            child: Listener(
              onPointerDown: active
                  ? (_) => setState(() => _pressed = true)
                  : null,
              onPointerUp: active
                  ? (_) => setState(() => _pressed = false)
                  : null,
              onPointerCancel: active
                  ? (_) => setState(() => _pressed = false)
                  : null,
              child: ElevatedButton.icon(
                onPressed: active ? widget.onPressed : null,
                icon: widget.loading
                    ? const SizedBox.square(
                        dimension: 21,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(widget.icon, color: Colors.white, size: 23),
                label: Text(
                  widget.loading ? 'Please wait…' : widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlinedSocialButton extends StatelessWidget {
  const OutlinedSocialButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 54,
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: const _GoogleGlyph(),
      label: const Text(
        'Continue with Google',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.navy,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColors.purple, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
  );
}

class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();
  @override
  Widget build(BuildContext context) => const SizedBox(
    width: 22,
    height: 22,
    child: CustomPaint(painter: _GooglePainter()),
  );
}

class _GooglePainter extends CustomPainter {
  const _GooglePainter();
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: size.width * .39);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.4
      ..strokeCap = StrokeCap.butt;
    for (final segment in [
      (const Color(0xFF4285F4), -45.0, 90.0),
      (const Color(0xFF34A853), 45.0, 90.0),
      (const Color(0xFFFBBC05), 135.0, 90.0),
      (const Color(0xFFEA4335), 225.0, 90.0),
    ]) {
      stroke.color = segment.$1;
      canvas.drawArc(
        rect,
        segment.$2 * 3.14159 / 180,
        segment.$3 * 3.14159 / 180,
        false,
        stroke,
      );
    }
    final bar = Paint()..color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromLTWH(center.dx, center.dy - 1.7, size.width * .36, 3.4),
      bar,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
