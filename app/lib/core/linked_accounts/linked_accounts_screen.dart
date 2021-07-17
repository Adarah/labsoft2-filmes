import 'package:app/models/streaming_service.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LinkedAccountsScreen extends StatelessWidget {
  const LinkedAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Linked accounts',
      body: ListView(
        children: [
          _buildStreamingServiceTile(Netflix()),
          _buildStreamingServiceTile(DisneyPlus()),
          _buildStreamingServiceTile(HboMax()),
          _buildStreamingServiceTile(PrimeVideo()),
        ],
      ),
    );
  }

  Widget _buildStreamingServiceTile(StreamingService svc) {
    return Card(
      child: SwitchListTile(
        secondary: svc.logo,
        title: Text(svc.name),
        activeColor: Colors.orange,
        onChanged: (bool value) {},
        value: true,
      ),
    );
  }
}
