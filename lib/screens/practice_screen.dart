import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1117),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                'Practice',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Camera learning interface',
                style: TextStyle(fontSize: 13, color: Color(0xFF8B949E)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isScanning
                          ? const Color(0xFF00AEEF)
                          : const Color(0xFF00AEEF).withAlpha(60),
                      width: _isScanning ? 2 : 1,
                    ),
                  ),
                  child: _isScanning
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.radar, size: 72, color: Color(0xFF00AEEF)),
                            SizedBox(height: 20),
                            Text(
                              'Scanning...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF00AEEF),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Looking for braille dots',
                              style: TextStyle(fontSize: 13, color: Color(0xFF8B949E)),
                            ),
                          ],
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 64,
                              color: Color(0xFF30363D),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Camera feed will appear here',
                              style: TextStyle(fontSize: 14, color: Color(0xFF8B949E)),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: () => setState(() => _isScanning = !_isScanning),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isScanning
                        ? const Color(0xFF1F6FEB)
                        : const Color(0xFF00AEEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isScanning ? Icons.stop_circle_outlined : Icons.radar,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _isScanning ? 'Stop Scanning' : 'Scanning for dots...',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}