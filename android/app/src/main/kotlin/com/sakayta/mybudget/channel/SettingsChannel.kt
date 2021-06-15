package com.sakayta.mybudget.channel

import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class SettingsChannel private constructor(context: Context) {

    companion object {

        private var instance: SettingsChannel? = null

        /**
         * Get singleton instance of this class.
         *
         * @return [SettingsChannel] instance.
         */
        @Synchronized
        fun instance(context: Context): SettingsChannel {
            if (instance == null) {
                instance = SettingsChannel(context)
            }
            return instance!!
        }
    }

    private val channel = "com.sakayta.mybudget/settings"

    // TO native actions.
    private val actionToCheckDateSettings = "ACTION_TO_CHECK_DATE_SETTINGS"
    private val actionToGotoSettings = "ACTION_TO_GO_TO_SETTINGS"

    private lateinit var _methodChannel: MethodChannel

    private val _context: Context = context

    private val result = 1

    /**
     * Setup method channel for communicating with flutter.
     *
     * @param flutterEngine
     */
    fun setupMethodChannel(flutterEngine: FlutterEngine) {
        _methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)

        _methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                actionToCheckDateSettings -> {
                    result.success(isNetworkProvidedTime(_context))
                }

                actionToGotoSettings -> {
                    gotoDateSettings(_context)
                    result.success(result)
                }

                else -> result.notImplemented()
            }
        }
    }

    /**
     * Check if time is network provided in settings.
     *
     * return 1 if true else 0
     */
    private fun isNetworkProvidedTime(c: Context): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            Settings.Global.getInt(c.contentResolver, Settings.Global.AUTO_TIME, 0)
        } else {
            Settings.System.getInt(c.contentResolver, Settings.System.AUTO_TIME, 0)
        }
    }

    /**
     * Navigate to date settings
     */
    private fun gotoDateSettings(c: Context) {
        c.startActivity(Intent(Settings.ACTION_DATE_SETTINGS));
    }
}
