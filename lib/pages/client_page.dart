import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste/blocs/client_bloc.dart';
import 'package:teste/blocs/client_events.dart';
import 'package:teste/blocs/client_state.dart';
import 'package:teste/models/client.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final random = Random();
    return ['Ana', 'Beatriz', 'Carlos', 'Diego'].elementAt(random.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.inputClient
                    .add(AddClientEvent(client: Client(name: randomName())));
              },
              icon: const Icon(Icons.person_add_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: StreamBuilder<ClientState>(
            stream: bloc.stream,
            builder: (context, AsyncSnapshot<ClientState> snapshot) {
              final clientsList = snapshot.data?.clients ?? [];
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Text(clientsList[index].name.substring(0, 1)),
                      ),
                    ),
                    title: Text(clientsList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          bloc.inputClient.add(RemoveClientEvent(client: clientsList[index]));
                        }, icon: const Icon(Icons.remove)),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: clientsList.length,
              );
            }),
      ),
    );
  }
}
