import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:nft_talk/app/modules/home/models/nft_model.dart';
import 'package:nft_talk/app/utils/metamask.dart';

const totalNfts = 10;

class NftListStore extends NotifierStore<Exception, List<NftModel>> {
  final MetaMask metaMask;
  NftListStore(this.metaMask) : super([]) {
    getNftById();
  }

  Future<void> getNftById() async {
    List<NftModel> tempList = [];
    for (var i = 0; i < totalNfts; i++) {
      final nft = await metaMask.getContract.call('getNftById', [
        BigInt.from(i),
      ]);
      tempList.add(NftModel(
        price: 100000000000000000,
        address: nft[1],
      ));
    }
    update(tempList);
  }

  Future<bool> buy(int index) async {
    final transaction = await metaMask.getContract.send(
        'buy',
        [BigInt.from(index)],
        TransactionOverride(value: BigInt.from(100000000000000000)));

    return transaction.hash.isNotEmpty;
  }
}
