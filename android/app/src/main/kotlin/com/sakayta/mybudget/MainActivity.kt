package com.sakayta.mybudget

import com.sakayta.mybudget.channel.SettingsChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        SettingsChannel.instance(this).setupMethodChannel(flutterEngine)
    }
}
