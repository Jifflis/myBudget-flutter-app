package com.sakayta.mybudget

import android.content.Intent
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*

class MainActivity: FlutterActivity() {
    private val channel = "com.sakayta.mybudget/image"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
        // Note: this method is invoked on the image selector
            call, result ->



            when (call.method) {
                "showCamera" -> {

                    val takePictureIntent: Intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                    // Ensure the there's a camera activity to handle the intent
                    if(takePictureIntent.resolveActivity(packageManager) != null){
                        // Create the File where the photo should go
                        var photoFile: File? = null
                        try{
                            photoFile = createImageFile();
                        }catch (ex: IOException){
                            ex.stackTrace
                        }

                        // Continue only if the File was successfully created
                        if(photoFile != null){
                            val photoUri: Uri = FileProvider.getUriForFile(this,
                            "com.sakayta.mybudget.provider",
                            photoFile)
                            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri)
                            startActivityForResult(takePictureIntent, 1)
                        }
                    }
                }
                "showGallery" -> {
                    //
                }
                else -> {
                    result.notImplemented();
                }
            }
        }
    }

    private fun createImageFile(): File{
        // Create an image file name
        val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss").format(Date())
        val imageFileName = "JPEG_" + timeStamp + "_"
        val file: File = File(Environment.getExternalStorageState() + "/MyBudget");
        if(!file.exists()){
            file.mkdir()
        }
        return File.createTempFile(imageFileName, ".jpg");
    }




}