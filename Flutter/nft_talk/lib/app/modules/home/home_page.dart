import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nft_talk/app/widgets/nft_list/nft_list_widget.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT Marketplace'),
        actions: [
          ScopedBuilder<HomeStore, Exception, bool>(
            store: store,
            onState: (_, isConnected) {
              if (isConnected) {
                return TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Wallet conected!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return TextButton(
                onPressed: () async {
                  await store.connect();
                },
                child: const Text(
                  "Connect to wallet",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: const NftListWidget(),
    );
  }
}
