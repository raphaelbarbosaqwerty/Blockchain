import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:nft_talk/app/utils/metamask.dart';

class HomeStore extends NotifierStore<Exception, bool> {
  final MetaMask metaMask;
  HomeStore(this.metaMask) : super(false) {
    metaMask.init();
  }

  init() {
    if (metaMask.isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        metaMask.clear();
      });
      ethereum!.onChainChanged((accounts) {
        metaMask.clear();
      });
    }
  }

  Future<void> connect() async {
    setLoading(true);
    var response = await metaMask.connect();
    update(response);
    setLoading(false);
  }

  logout() {
    setLoading(true);
    metaMask.clear();
    update(false);
    setLoading(false);
  }
}
