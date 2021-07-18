import 'package:app/models/streaming_service.dart';
import 'package:app/viewmodels/linked_accounts_viewmodel.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkedAccountsScreen extends StatelessWidget {
  const LinkedAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Contas vinculadas',
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStreamingServiceTile(context, Netflix()),
          _buildStreamingServiceTile(context, DisneyPlus()),
          _buildStreamingServiceTile(context, HboMax()),
          _buildStreamingServiceTile(context, PrimeVideo()),
        ],
      ),
    );
  }

  Widget _buildStreamingServiceTile(
      BuildContext context, StreamingService svc) {
    return Consumer<LinkedAccountsViewmodel>(
      builder: (context, model, child) => Card(
        child: SizedBox(
          width: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwitchListTile(
              secondary: SizedBox(width: 100, child: svc.logo),
              // title: Text(svc.name),
              activeColor: Colors.orange,
              onChanged: (bool value) {
                model.toggleService(svc, value);
              },
              value: model.enabledServices.contains(svc),
            ),
          ),
        ),
      ),
    );
  }
}
