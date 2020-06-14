package com.jxy.flutter_app_test;

import android.os.Bundle;
import android.view.KeyEvent;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
  long mExitTime = 0;
  @Override
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_BACK) {
      if (System.currentTimeMillis() - mExitTime > 2000) {
        mExitTime = System.currentTimeMillis();
        //toast("再按一次关闭");
        Toast.makeText(MainActivity.this,"再按一次关闭",Toast.LENGTH_LONG).show();
      } else {
        //moveTaskToBack(true);
        finish();
        System.exit(0);
      }
      return true;
    }
    return super.onKeyDown(keyCode, event);
  }
}
