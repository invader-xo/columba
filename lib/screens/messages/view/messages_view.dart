import 'package:columba/shared/widgets/user_tile/user_tile.dart';
import 'package:flutter/material.dart';

class MessagesScreenView extends StatefulWidget {
  const MessagesScreenView({super.key});

  @override
  State<MessagesScreenView> createState() => _MessagesScreenViewState();
}

class _MessagesScreenViewState extends State<MessagesScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Messages',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              Image.network(
                'https://api.dicebear.com/7.x/pixel-art/png?seed=John&background=%23000000&radius=50',
                height: 40,
                width: 40,
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return UserTileWidget(
              profileImageUrl:
                  'https://api.dicebear.com/7.x/pixel-art/png?seed=$index&background=%23000000&radius=50',
              username: "John Doe",
              subtitle: "Hello World",
              rightText:
                  "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour > 12 ? "${DateTime.now().hour - 12 < 10 ? "0${DateTime.now().hour - 12}" : DateTime.now().hour - 12}" : DateTime.now().hour}:${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute}",
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
