import 'package:flutter_web3/flutter_web3.dart';
import 'package:nft_talk/app/utils/abi_api.dart';

class MetaMask {
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isEnabled => ethereum != null;
  static const operatingChain = 1337;
  String currentAddress = '';
  int currentChain = -1;

  Future<bool> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();
      return true;
    }
    return false;
  }

  bool clear() {
    currentAddress = '';
    currentChain = -1;
    return false;
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }

  Contract get getContract {
    return Contract(contractAddres, abi, provider!.getSigner());
  }
}
