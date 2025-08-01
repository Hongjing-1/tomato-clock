import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // 預設的漸層顏色選項
    final gradients = [
      [Colors.purple.shade400, Colors.blue.shade300],
      [Colors.orange.shade400, Colors.pink.shade300],
      [Colors.green.shade400, Colors.teal.shade300],
      [Colors.indigo.shade400, Colors.cyan.shade300],
    ];

    void _chooseBackground() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose Background",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  children: List.generate(gradients.length, (index) {
                    final gradient = gradients[index];
                    return GestureDetector(
                      onTap: () {
                        appState.setBackgroundGradient(gradient); //存到 AppState
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: appState.backgroundGradient, //使用 AppState 的漸層
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const ListTile(title: Text('Account Settings')),
                        const Divider(),
                        ListTile(
                          title: const Text('Background'),
                          onTap: _chooseBackground,
                          trailing: const Icon(
                            Icons.color_lens,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Digital Mode'),
                          trailing: Switch(
                            value: appState.showMode,
                            onChanged: (bool value) {
                              appState.toggleShowMode(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
