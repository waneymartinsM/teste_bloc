import 'package:teste/models/client.dart';

class ClientsRepository {
  final List<Client> _clients = [];

  List<Client> loadClients(){
    _clients.addAll([
      Client(name: 'Ana'),
      Client(name: 'Beatriz'),
      Client(name: 'Carlos'),
      Client(name: 'Diego'),
    ]);
    return _clients;
  }

  List<Client> addClient(Client client){
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client){
    _clients.remove(client);
    return _clients;
  }



}