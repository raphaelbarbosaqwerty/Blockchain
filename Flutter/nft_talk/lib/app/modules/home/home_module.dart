import 'package:flutter_modular/flutter_modular.dart';
import 'package:nft_talk/app/widgets/nft_list/nft_list_store.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore(i.get())),
    Bind.lazySingleton((i) => NftListStore(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
