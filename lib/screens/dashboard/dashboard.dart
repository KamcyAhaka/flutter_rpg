import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home/character_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/user_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


	@override
  void initState() {
		Provider.of<CharacterStore>(context, listen: false)
			.fetchCharactersOnce();

		Provider.of<UserStore>(context, listen: false)
			.startListeningToAuthChanges();

    super.initState();
  }

	String replaceFromSixth(String text) => text.length < 6 ? text : "${text.substring(0, 5)}***";

	void signUserOut() {
		Provider.of<UserStore>(context, listen: false)
		.signOut();

		Navigator.push(
			context, MaterialPageRoute(builder: (ctx) => const Home())
		);
	}


  @override
  Widget build(BuildContext context) {
		final characters = Provider.of<CharacterStore>(context).characters;

    return Scaffold(
			appBar: AppBar(
				title: const StyledTitle('Your Dashboard'),
			),
			body: Container(
				padding: const EdgeInsets.all(16),
				child: Consumer<UserStore>(
					builder: ((context, value, child) {
						return Column(
							children: [
								Container(
									padding: const EdgeInsets.all(16),
									color: AppColors.secondaryColor,
									child: Row(
										children: [
											const CircleAvatar(
												radius: 30,
												child: Icon(Icons.person, size: 50,),
											),
											const SizedBox(width: 10),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													StyledHeading(replaceFromSixth(value.currentUser!.uid)),
													Row(
														children: [
															StyledText(value.currentUser!.email!),
															const SizedBox(width: 10),
															value.currentUser!.emailVerified ? 
																const Icon(Icons.check_circle, color: Colors.green,)
																: Icon(Icons.cancel, color: Colors.redAccent.withOpacity(0.7), size: 15,)
														],
													)
												],
											),
										],
									),
								),
								const SizedBox(height: 20),
								Icon(Icons.code, color: AppColors.primaryColor,),
								const SizedBox(height: 20),
								const StyledHeading('All your characters'),
								const SizedBox(height: 20),

								// Show cards here
								characters.isEmpty ? 
								const Center(
									child: StyledText('No characters found')
								) // Display message if no characters
								: 
								ListView.builder(
									shrinkWrap: true, // Prevent list from expanding
									physics: const NeverScrollableScrollPhysics(), // Disable scrolling
									itemCount: characters.length,
									itemBuilder: (context, index) {
										final character = characters[index];
										return CharacterCard(character);
									},
								),
								const Expanded(child: SizedBox()),
								StyledButton(
									onPressed: signUserOut,
									child: const StyledTitle('Log out') 
								)
							],
						);
					})
				),
			),
		);
  }
}
