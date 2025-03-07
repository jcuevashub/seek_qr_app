package com.example.seek_qr_app.auth

import android.app.AlertDialog
import android.text.InputType
import android.widget.EditText
import android.widget.Toast
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_WEAK
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import java.util.concurrent.Executor

class AuthApiImpl(private val activity: FragmentActivity) : AuthApi {
    private var resultCallback: ((Result<AuthResult>) -> Unit)? = null

    override fun authenticate(callback: (Result<AuthResult>) -> Unit) {
        resultCallback = callback

        val biometricManager = BiometricManager.from(activity)
        val executor: Executor = ContextCompat.getMainExecutor(activity)

        val biometricPrompt =
            BiometricPrompt(activity, executor, object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                  resultCallback!!.invoke( Result.success(
                      AuthResult(true, "Successfully authenticated")
                  ))
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    showPinAuthentication()
                }

                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    showPinAuthentication()
                }
            })

        when (biometricManager.canAuthenticate(BIOMETRIC_WEAK)) {
            BiometricManager.BIOMETRIC_SUCCESS -> {
                val promptInfo = BiometricPrompt.PromptInfo.Builder()
                    .setTitle("AndroidX Biometric")
                    .setSubtitle("Authenticate user via Biometric")
                    .setDescription("Please authenticate yourself here")
                    .setAllowedAuthenticators(
                        BIOMETRIC_WEAK
                    )
                    .setNegativeButtonText("Cancel")
                    .setConfirmationRequired(true)
                    .build()

                biometricPrompt.authenticate(promptInfo)
            }
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> showPinAuthentication()
            BiometricManager.BIOMETRIC_ERROR_UNSUPPORTED -> showPinAuthentication()
            else -> showPinAuthentication()
        }
    }

    private fun showPinAuthentication() {
        val builder = AlertDialog.Builder(activity)
        builder.setTitle("Enter PIN: 1234")
        val input = EditText(activity)
        input.inputType = InputType.TYPE_CLASS_NUMBER or InputType.TYPE_NUMBER_VARIATION_PASSWORD
        builder.setView(input)

        builder.setPositiveButton("OK") { _, _ ->
            val enteredPin = input.text.toString()
            if (validatePin(enteredPin)) {
                resultCallback!!.invoke( Result.success(
                    AuthResult(true, "Successfully authenticated")
                ))
            } else {
                Toast.makeText(activity, "Incorrect PIN", Toast.LENGTH_SHORT).show()
                resultCallback!!.invoke( Result.success(
                    AuthResult(false, "Incorrect PIN")
                ))
            }
        }

        builder.setNegativeButton("Cancel") { dialog, _ ->
            dialog.cancel()
            resultCallback!!.invoke( Result.success(
                AuthResult(false, "Authentication failed")
            ))
        }

        builder.show()
    }

    private fun validatePin(pin: String): Boolean {
        val correctPin = "1234" // Replace this with secure storage
        return pin == correctPin
    }

}