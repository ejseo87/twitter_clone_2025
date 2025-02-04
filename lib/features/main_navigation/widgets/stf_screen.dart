import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks = _clicks + 1;
    });
  }

  @override
  void dispose() {
    print("_clicks = $_clicks");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("in StfScreen, I am build.");
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _clicks.toString(),
              style: const TextStyle(
                fontSize: 51,
              ),
            ),
            TextButton(
              onPressed: _increase,
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 52,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
