import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_group_controller.dart';
import 'package:findo/screens/error_screen.dart';
import 'package:findo/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class AccountGroupsScreen extends ConsumerWidget {
  const AccountGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(accountGroupsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.add_square,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/group_create");
            },
          )
        ],
      ),
      body: SafeArea(
        child: groups.when(
          error: (error, stackTrace) => ErrorScreen(
            msg: error.toString(),
          ),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          data: (data) {
            if (data.isEmpty) {
              return const NoDataScreen();
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                AccountsModel group = data[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      group.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of group"),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("This month",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith()),
                        const Text("12,650")
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/account_list",
                          arguments: group);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
