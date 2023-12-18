import 'package:flutter/material.dart';

import '../../../shared/widgets/user_tile/user_tile.dart';
import '../../../util/helpers/random/random_helpers.dart';

class FindScreenView extends StatefulWidget {
  const FindScreenView({super.key});

  @override
  State<FindScreenView> createState() => _FindScreenViewState();
}

class _FindScreenViewState extends State<FindScreenView> {
  TextEditingController controller = TextEditingController(
    text: '',
  );

  int _randomNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                label: const Text(
                  'Search by id...',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(80.0),
                )),
                contentPadding: const EdgeInsets.all(8.0),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        controller.text = '';
                        _randomNumber = 0;
                      });
                    }),
                isDense: true,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
              ),
              onChanged: (value) {
                setState(() {
                  controller.text = value;
                  _randomNumber = pickARandomNumberInRange(1, 10);
                  if (value == '') {
                    _randomNumber = 0;
                  }
                });
              },
              controller: controller,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (controller.text != '')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Results for ${controller.text != '' ? '"${controller.text}"' : '...'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          const SizedBox(
            height: 16.0,
          ),
          Column(children: [
            for (int i = 0; i < _randomNumber; i++)
              UserTileWidget(
                  profileImageUrl:
                      'https://api.dicebear.com/7.x/pixel-art/png?seed=${getRandom5CharacterString()}&background=%23000000&radius=50',
                  username: "John Doe",
                  subtitle:
                      "ID: ${(controller.text + getRandom5CharacterString()).substring(0, 6)}",
                  rightText: "Add User")
          ])
        ],
      ),
    );
  }
}
