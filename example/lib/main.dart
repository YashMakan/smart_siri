import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:smart_siri/smart_siri.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SimpleAudio.init();
  runApp(const CupertinoApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _siri = SmartSiri();
  final player = SimpleAudio();

  Future<void> onSuccess(bytes) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/output.wav';
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    player.open(filePath);
  }

  @override
  void initState() {
    super.initState();
    _siri.setOnSuccess(onSuccess);
    _siri.selectionsStream().listen(onQuery);
    unawaited(requestPermissions());
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.speech,
    ].request();

    if (statuses[Permission.microphone]!.isDenied ||
        statuses[Permission.speech]!.isDenied) {
      debugPrint("❌ Permissions denied!");
    } else {
      debugPrint("✅ Permissions granted!");
    }
  }

  Future<void> onQuery(String task) async {
    debugPrint("🔄 Processing task STARTED: $task");
    // server: https://www.kaggle.com/code/yashmakan/complete-api/edit/run/235924988
    const id = "e782-34-56-202-184";
    final url = Uri.parse('https://$id.ngrok-free.app/chat');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'query': task});
    final response = await post(url, headers: headers, body: body);
    await _siri.backgroundResponseUint8List(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text(
          'SmartSiri 🤖',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
    );
  }
}
