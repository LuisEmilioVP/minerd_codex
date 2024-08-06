import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Códex Group',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0F539C),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMemberCard(
            name: 'Mileidy Nicole Mejía Leocadio',
            id: '2021-0118',
            imagePath: 'icons/mileidy_nicole.png',
          ),
          _buildMemberCard(
            name: 'Luis Emilio Valenzuela Peña',
            id: '2022-0675',
            imagePath: 'icons/luis_emilio.png',
          ),
          _buildMemberCard(
            name: 'Jesús Adrián Travieso Fernández',
            id: '2022-0066',
            imagePath: 'icons/jesus_adrian.png',
          ),
          _buildMemberCard(
            name: 'Fraimer Aquiles Carrasco Santana',
            id: '2022-0485',
            imagePath: 'icons/fraimer_aquiles.png',
          ),
          _buildMemberCard(
            name: 'Willenson Rafael Guillen Inirio',
            id: '2021-2406',
            imagePath: 'icons/willenson_rafael.png',
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
      {required String name, required String id, required String imagePath}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imagePath),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F539C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Matrícula: $id',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F539C),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
