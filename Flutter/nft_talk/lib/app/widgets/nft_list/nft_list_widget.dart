import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nft_talk/app/modules/home/models/nft_model.dart';
import 'package:nft_talk/app/widgets/nft_list/nft_list_store.dart';
import 'package:asuka/asuka.dart' as asuka;

class NftListWidget extends StatelessWidget {
  const NftListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<NftListStore>();

    return ScopedBuilder<NftListStore, Exception, List<NftModel>>(
      store: store,
      onState: (_, list) {
        return ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var item = list[index];
            return Column(
              children: [
                Text('NFT #$index'),
                const Icon(Icons.person),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: item.address.contains("000000000")
                      ? () async {
                          final result = await store.buy(index);
                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('NFT #$index bought!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('ERROR!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      : null,
                  child: const Text('Buy'),
                )
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
