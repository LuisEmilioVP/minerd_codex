import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/usuario_controller.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final usuarioController = Provider.of<UsuarioController>(context);
    final user = usuarioController.user;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Mi Perfil',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF0F539C),
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
                    const CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nombre: ${user?.nombre ?? ''}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F539C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Apellido: ${user?.apellido ?? ' '}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F539C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Teléfono: ${user?.telefono ?? ' '}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F539C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${user?.correo ?? ' '}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F539C),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 2,
                      color: Color(0xFF66A1DE),
                    ),
                    const Text(
                      'Reflexión:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F539C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9FD0FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'La educación es el arma más poderosa que puedes usar para cambiar el mundo. La supervisión escolar es el pilar que garantiza que esta arma se forje adecuadamente.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff48494a),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/change_password');
                      },
                      child: const Text('Cambiar Contraseña'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
