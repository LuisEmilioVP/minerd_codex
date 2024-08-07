import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/horoscopo/horoscope_provider.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen> {
  final List<String> _signs = [
    'aries',
    'taurus',
    'gemini',
    'cancer',
    'leo',
    'virgo',
    'libra',
    'scorpio',
    'sagittarius',
    'capricorn',
    'aquarius',
    'pisces'
  ];
  String _selectedSign = 'aries';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchHoroscope();
    });
  }

  void _fetchHoroscope() {
    Provider.of<HoroscopeProvider>(context, listen: false)
        .fetchHoroscope(_selectedSign);
  }

  @override
  Widget build(BuildContext context) {
    final horoscopeProvider = Provider.of<HoroscopeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horóscopo'),
        backgroundColor: const Color(0xff0F539C),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: _selectedSign,
                items: _signs.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value.toUpperCase(),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSign = newValue!;
                  });
                  _fetchHoroscope();
                },
                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(fontSize: 18),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: horoscopeProvider.horoscope != null
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: 1, // Solo un horóscopo a la vez
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 8.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              horoscopeProvider.horoscope!.description,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
