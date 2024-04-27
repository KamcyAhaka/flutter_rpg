import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/theme.dart';

class Eye extends StatefulWidget {
  const Eye({super.key, required this.character});

	final Character character;

  @override
  State<Eye> createState() => _EyeState();
}

class _EyeState extends State<Eye> {


  @override
  Widget build(BuildContext context) {
    return IconButton(
			onPressed: () {
				setState(() {
					widget.character.toggleIsPublic();
				});
			},
			icon: Icon(
				widget.character.isPublic ? Icons.visibility : Icons.visibility_off,
				color: widget.character.isPublic ? AppColors.titleColor : Colors.grey[800],
			)
		);
  }
}
