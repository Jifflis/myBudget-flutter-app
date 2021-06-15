package com.kddi.PocketHealthcareDemo.channel

import android.content.Context
import com.amazonaws.mobile.config.AWSConfiguration
import com.amazonaws.mobileconnectors.cognitoidentityprovider.CognitoDevice
import com.amazonaws.mobileconnectors.cognitoidentityprovider.CognitoUserPool
import com.amazonaws.mobileconnectors.cognitoidentityprovider.CognitoUserSession
import com.amazonaws.mobileconnectors.cognitoidentityprovider.continuations.AuthenticationContinuation
import com.amazonaws.mobileconnectors.cognitoidentityprovider.continuations.AuthenticationDetails
import com.amazonaws.mobileconnectors.cognitoidentityprovider.continuations.ChallengeContinuation
import com.amazonaws.mobileconnectors.cognitoidentityprovider.continuations.MultiFactorAuthenticationContinuation
import com.amazonaws.mobileconnectors.cognitoidentityprovider.handlers.AuthenticationHandler
import com.amazonaws.mobileconnectors.cognitoidentityprovider.handlers.GenericHandler
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class SettingsChannel {

    companion object {
        // FROM native actions.
        val ACTION_FROM_CHECK_SETTINGS_DATE = "ACTION_FROM_CHECK_SETTINGS_DATE"

        private var _instance: SettingsChannel? = null

        /**
         * Get singleton instance of this class.
         *
         * @return [SettingsChannel] instance.
         */
        @Synchronized
        fun instance(context: Context) : SettingsChannel {
            if (_instance == null) {
                _instance = SettingsChannel(context)
            }
            return _instance!!
        }
    }

    private val CHANNEL = "com.kddi.PocketHealthcareDemo/cognitoaccount"

    // TO native actions.
    private val ACTION_TO_CHECK_DATE_SETTINGS = "ACTION_TO_CHECK_DATE_SETTINGS"

    private val RESULT_SUCCESS = 1
    private val RESULT_FAILED = 0

    private lateinit var _methodChannel: MethodChannel

    private val _context: Context

    private constructor(context: Context) {
        _context = context
    }

    /**
     * Setup method channel for communicating with flutter.
     *
     * @param flutterEngine
     */
    fun setupMethodChannel(flutterEngine: FlutterEngine) {
        _methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        _methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                ACTION_TO_CHECK_DATE_SETTINGS -> {
                    _userPool = CognitoUserPool(
                        _context,
                        AWSConfiguration(JSONObject(call.arguments as String))
                    )
                    result.success(RESULT_SUCCESS)
                }

                else -> result.notImplemented()
            }
        }
    }
}
