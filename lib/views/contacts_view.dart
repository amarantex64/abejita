import 'package:abejita/app_constant.dart';
import 'package:abejita/layouts/main_layout.dart';
import 'package:abejita/models/models.dart';
import 'package:abejita/models/samples.dart';
import 'package:abejita/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ContactsView extends StatefulWidget {
  static const String routeName = '/contacts';

  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late List<UserModel> usersFiltered;

  @override
  void initState() {
    super.initState();
    usersFiltered = usersDatabase;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Clientes",
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        hoverElevation: 5,
        child: Icon(LucideIcons.user_round_plus),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.only(left: AppScreen.standardPadding, right: AppScreen.standardPadding, top: 8),
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar cliente',
                  prefixIcon: const Icon(LucideIcons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onChanged: (query) {
                  setState(() {
                    usersFiltered = query.isEmpty
                        ? usersDatabase
                        : usersDatabase
                              .where(
                                (u) =>
                                    u.name.toLowerCase().contains(query) ||
                                    u.surname.toLowerCase().contains(query) ||
                                    u.id.contains(query),
                              )
                              .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: usersFiltered.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.user_search, size: 64, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(
                          "No se encontraron resultados",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppScreen.standardPadding),
                      itemCount: usersFiltered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 2),
                      itemBuilder: (context, index) {
                        final user = usersFiltered[index];

                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
                          child: ListTile(
                            isThreeLine: true,
                            shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: CircleAvatar(radius: 26, backgroundImage: NetworkImage(user.avatarUrl)),
                            title: Text(
                              "${user.name} ${user.surname}",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.id.asCedulaFormat ?? "", style: Theme.of(context).textTheme.bodyMedium),
                                Text(user.email, style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                useSafeArea: true,
                                elevation: 2,
                                showDragHandle: true,
                                builder: (_) => _menuUsuario(context, user),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuUsuario(BuildContext context, UserModel user) {
    return Wrap(
      children: [
        ListTile(leading: const Icon(Icons.edit), title: const Text('Editar'), onTap: () => Navigator.pop(context)),
        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Eliminar'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
