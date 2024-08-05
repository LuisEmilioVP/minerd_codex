import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acerca de',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0F539C),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage('icons/jesus.JPG'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Juan Pérez',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F539C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Matrícula: 12345678',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F539C),
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: Color(0xFF66A1DE),
                  ),
                  Text(
                    'Reflexión:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F539C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF9FD0FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'La educación es el arma más poderosa que puedes usar para cambiar el mundo. La supervisión escolar es el pilar que garantiza que esta arma se forje adecuadamente.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff48494a),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
