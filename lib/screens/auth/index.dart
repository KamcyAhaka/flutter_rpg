import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:go_router/go_router.dart';

class AuthIndex extends StatelessWidget {
  const AuthIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: StyledTitle('Authentication'),
			),
			body: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						StyledButton(
							onPressed: () {
								context.go('/auth/signup');
							}, 
							child: const StyledTitle('Sign up')
						),
						StyledButton(
							onPressed: () {
								context.go('/auth/signin');
							}, 
							child: const StyledTitle('Sign in')
						),
					],
				),
			),
		);
  }
}
