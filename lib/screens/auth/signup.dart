import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rpg/screens/dashboard/dashboard.dart';
import 'package:flutter_rpg/services/user_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

	final _usernameController = TextEditingController();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
  void dispose() {
		_usernameController.dispose();
		_emailController.dispose();
		_passwordController.dispose();
    super.dispose();
  }

	void signUserUp() {
		if (_usernameController.text.trim().isEmpty) {
			showDialog(context: context, builder: 
				(ctx) {
					return AlertDialog(
						title: const StyledHeading('Username cannot be empty'),
						content: const StyledText('Usernames are used to identify you in the community...'),
						actions: [
							StyledButton(
								onPressed: () {
									Navigator.pop(ctx);
								},
								child: const StyledHeading('Close'),
							)
						],
						actionsAlignment: MainAxisAlignment.center,
					);
				}
			);
			return;
		}
		if (_emailController.text.trim().isEmpty) {
			showDialog(context: context, builder: 
				(ctx) {
					return AlertDialog(
						title: const StyledHeading('Email cannot be empty'),
						content: const StyledText('Please input a valid email address...'),
						actions: [
							StyledButton(
								onPressed: () {
									Navigator.pop(ctx);
								},
								child: const StyledHeading('Close'),
							)
						],
						actionsAlignment: MainAxisAlignment.center,
					);
				}
			);
			return;
		}
		if (_passwordController.text.trim().isEmpty) {
			showDialog(context: context, builder: 
				(ctx) {
					return AlertDialog(
						title: const StyledHeading('Password cannot be empty'),
						content: const StyledText('Please input a strong password...'),
						actions: [
							StyledButton(
								onPressed: () {
									Navigator.pop(ctx);
								},
								child: const StyledHeading('Close'),
							)
						],
						actionsAlignment: MainAxisAlignment.center,
					);
				}
			);
			return;
		}

		Provider.of<UserStore>(context, listen: false)
			.signup(_emailController.text, _passwordController.text);


		Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Dashboard()));
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: const StyledTitle('Sign up'),
				leading: Builder(
					builder: (BuildContext context) {
						return IconButton(
							onPressed: () {
								context.go('/');
							}, 
							icon: const Icon(Icons.home)
						);
					}
				),
			),
			body:Padding(
				padding: const EdgeInsets.all(16),
				child: Container(
					padding: const EdgeInsets.all(16),
					child: SingleChildScrollView(
						child: Column(
							children: [
								TextField(
									controller: _usernameController,
									style: GoogleFonts.kanit(
										textStyle: Theme.of(context).textTheme.bodyMedium
									),
									cursorColor: AppColors.textColor,
									decoration: const InputDecoration(
										prefixIcon: Icon(Icons.account_circle),
										label: StyledText('Username')
									),
								),
								const SizedBox(height: 30),
								TextField(
									controller: _emailController,
									style: GoogleFonts.kanit(
										textStyle: Theme.of(context).textTheme.bodyMedium
									),
									cursorColor: AppColors.textColor,
									decoration: const InputDecoration(
										prefixIcon: Icon(Icons.mail),
										label: StyledText('Your email')
									),
								),
								const SizedBox(height: 30),
								TextField(
									controller: _passwordController,
									style: GoogleFonts.kanit(
										textStyle: Theme.of(context).textTheme.bodyMedium
									),
									cursorColor: AppColors.textColor,
									decoration: const InputDecoration(
										prefixIcon: Icon(Icons.key),
										label: StyledText('Password')
									),
								),
								const SizedBox(height: 50),
								GestureDetector(
									onTap: () {
										context.go('/auth/signin');
									},
									child: const StyledText('Already have an account? Sign in')
								),
								const SizedBox(height: 50),
								StyledButton(
									onPressed: signUserUp,
									child: const StyledTitle('Create account')
								),
							],
						),
					),
				),
			),
		);
  }
}
