import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String subtitle;
  final String rightText;

  const UserTileWidget({
    super.key,
    required this.profileImageUrl,
    required this.username,
    required this.subtitle,
    required this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Image.network(profileImageUrl, height: 40, width: 40,
            errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.person,
          );
        }),
        title: Text(username),
        subtitle: Text(subtitle),
        trailing: Text(rightText),
      ),
    );
  }
}
