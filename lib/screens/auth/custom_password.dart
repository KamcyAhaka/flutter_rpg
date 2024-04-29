import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword(this.controller, {super.key});

	final TextEditingController controller;

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
	bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
			controller: widget.controller,
			style: GoogleFonts.kanit(
				textStyle: Theme.of(context).textTheme.bodyMedium
			),
			cursorColor: AppColors.textColor,
			obscureText: _hidePassword,
			decoration: InputDecoration(
				prefixIcon: const Icon(Icons.key),
				label: const StyledText('Password'),
				suffixIcon: IconButton(
					onPressed: () {
						setState(() {
							_hidePassword = !_hidePassword;
						});
					}, 
					icon: Icon(
						_hidePassword ? 
							Icons.visibility : 
							Icons.visibility_off,

							color: Colors.grey[600],
					)
				)
			),
		);
  }
}
