package com.jacksoncuevas.qrscanner.auth

import android.app.KeyguardManager
import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import java.util.concurrent.Executor

class AuthApiImpl(private val activity: FragmentActivity) : AuthApi {
    private var resultCallback: ((Result<AuthResult>) -> Unit)? = null

    @RequiresApi(Build.VERSION_CODES.M)
    override fun authenticate(callback: (Result<AuthResult>) -> Unit) {
        resultCallback = callback


        val keyguardManager = activity.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        if (!keyguardManager.isDeviceSecure) {
            resultCallback!!.invoke(
                Result.success(
                    AuthResult(true, "No device credentials set.")
                )
            )
            return
        }

        val biometricManager = BiometricManager.from(activity)
        val authenticators = BiometricManager.Authenticators.BIOMETRIC_STRONG or DEVICE_CREDENTIAL
        val executor: Executor = ContextCompat.getMainExecutor(activity)

        val biometricPrompt =
            BiometricPrompt(activity, executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    resultCallback!!.invoke(
                        Result.success(
                            AuthResult(true, "Successfully authenticated")
                        )
                    )
                    return
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    resultCallback!!.invoke(
                        Result.success(
                            AuthResult(false, "Failed to authenticate")
                        )
                    )
                }

                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    resultCallback!!.invoke(
                        Result.success(
                            AuthResult(false, "Failed to authenticate")
                        )
                    )
                }
            })

        when (biometricManager.canAuthenticate(authenticators)) {
            BiometricManager.BIOMETRIC_SUCCESS -> {

                val promptInfo = BiometricPrompt.PromptInfo.Builder()
                    .setTitle("Authenticate")
                    .setSubtitle("Use biometrics or device credentials")
                    .setAllowedAuthenticators(authenticators)
                    .build()
                biometricPrompt.authenticate(promptInfo)
            }

            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE ->    resultCallback!!.invoke(
                Result.success(
                    AuthResult(false, "No biometric hardware found")
                )
            )
            BiometricManager.BIOMETRIC_ERROR_UNSUPPORTED ->    resultCallback!!.invoke(
                Result.success(
                    AuthResult(false, "Biometric authentication not supported")
                )
            )
            else ->    resultCallback!!.invoke(
                Result.success(
                    AuthResult(false, "Biometric authentication not available")
                )
            )
        }
    }

}