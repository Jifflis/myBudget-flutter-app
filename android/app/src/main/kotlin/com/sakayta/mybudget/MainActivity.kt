package com.sakayta.mybudget

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import androidx.core.app.ActivityCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException


class MainActivity: FlutterActivity() {
    private val channel = "com.sakayta.mybudget/image"
    private var mResult: MethodChannel.Result? = null

    private var mPhotoFile: File? = null
    private var mNameFile: String? = null

    private val cameraRequestCode: Int = 1;

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == cameraRequestCode && resultCode == Activity.RESULT_OK) {
           
            mResult?.success(mPhotoFile?.absolutePath)
        }
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
        // Note: this method is invoked on the image selector
            call, result ->

            mResult = result;

            when (call.method) {
                "showCamera" -> {

                    if(!isAllowed()) {
                        return@setMethodCallHandler
                    }

                    val name: String? = call.argument("name")
                    val takePictureIntent: Intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE);

                    /// Ensure there's a camera activity to handle the intent
                    /// Ensure permissions
                    ///
                    if(takePictureIntent.resolveActivity(packageManager) != null){
                        // Create the File where the photo should go
                        var photoFile: File? = null
                        try{
                            photoFile = createImageFile(name)
                            mPhotoFile = photoFile;
                            mNameFile = name;
                        }catch (ex: IOException){
                            ex.stackTrace
                        }

                        // Continue only if the File was successfully created
                        if(photoFile != null){

                            val photoUri: Uri = FileProvider.getUriForFile(this,
                            "com.sakayta.mybudget.provider",
                            photoFile)
                            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri)
                            startActivityForResult(takePictureIntent, cameraRequestCode)

                        }else{
                            result.error("404","File not found!",null)
                        }

                    }else{
                        println("did not proceed")
                    }
                }
                "showGallery" -> {
                    //
                }
                "getPath" -> {
                    if(!isAllowed()) {
                        return@setMethodCallHandler
                    }

                    val name: String? = call.argument("name")


                    try{
                        val newFile:File = File("/data/user/0/com.sakayta.mybudget/cache", "$name.jpg")

                        println(newFile.length())

                        if(newFile.exists() && newFile.length() > 0){
                            println(newFile.absolutePath)
                            result.success(newFile.absolutePath)
                        }else{
                            result.success(null)
                        }
                    }catch (ex: IOException){
                        ex.stackTrace
                    }
                }
                "saveImage" -> {
                    if(!isAllowed()) {
                        return@setMethodCallHandler
                    }

                    val name: String? = call.argument("name")
                    val path: String? = call.argument("path")

                    try{
                        val currentFile:File = File(path)
                        val newFile:File = File(currentFile?.parentFile, "$name.jpg")
                        currentFile.renameTo(newFile)
                        result.success(newFile.absolutePath)
                    }catch (ex: IOException){
                        ex.stackTrace
                        result.success(null)
                    }



                }
                else -> {
                    result.notImplemented();
                }
            }
        }
    }

    private fun createImageFile(name: String?): File {
        val file: File = File(Environment.getExternalStorageState() + "/MyBudget");
        if (!file.exists()) {
            file.mkdir()
        }

        return File.createTempFile(name, ".jpg")
    }


    private fun  isAllowed(): Boolean{

        val permissionCamera = 1
        val permissions = arrayOf(
            android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
            android.Manifest.permission.READ_EXTERNAL_STORAGE,
            android.Manifest.permission.CAMERA
        )

        return if (!hasPermissions(this, *permissions)) {
            ActivityCompat.requestPermissions(this, permissions, permissionCamera)
            false;
        }else{
            true;
        }
    }

    private fun hasPermissions(context: Context, vararg permissions: String): Boolean = permissions.all {
        ActivityCompat.checkSelfPermission(context, it) == PackageManager.PERMISSION_GRANTED
    }


}