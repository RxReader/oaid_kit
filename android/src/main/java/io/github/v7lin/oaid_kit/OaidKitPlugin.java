package io.github.v7lin.oaid_kit;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.bun.miitmdid.core.ErrorCode;
import com.bun.miitmdid.core.MdidSdkHelper;
import com.bun.miitmdid.interfaces.IIdentifierListener;
import com.bun.miitmdid.interfaces.IdSupplier;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** OaidKitPlugin */
public class OaidKitPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;
  private Handler mainHandler;

  // --- FlutterPlugin

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    channel = new MethodChannel(binding.getBinaryMessenger(), "v7lin.github.io/oaid_kit");
    channel.setMethodCallHandler(this);
    applicationContext = binding.getApplicationContext();
    mainHandler = new Handler(Looper.getMainLooper());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
    applicationContext = null;
    mainHandler.removeCallbacksAndMessages(null);
    mainHandler = null;
  }

  // --- MethodCallHandler

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
    if ("getOaid".equals(call.method)) {
      final AtomicBoolean completed = new AtomicBoolean(false);
      try {
        final int code = MdidSdkHelper.InitSdk(applicationContext, true, new IIdentifierListener() {
          @Override
          public void OnSupport(boolean isSupport, final IdSupplier supplier) {
            Runnable action = new Runnable() {
              @Override
              public void run() {
                Map<String, Object> map = new HashMap<>();
                map.put("is_supported", supplier.isSupported());
                map.put("oaid", supplier.getOAID());
                map.put("vaid", supplier.getVAID());
                map.put("aaid", supplier.getAAID());
                if (completed.compareAndSet(false, true)) {
                  result.success(map);
                }
              }
            };
            if (Looper.myLooper() == Looper.getMainLooper()) {
              action.run();
            } else {
              if (mainHandler != null) {
                mainHandler.post(action);
              }
            }
          }
        });
        switch (code) {
          case ErrorCode.INIT_ERROR_BEGIN:
            // do nothing
            break;
          case ErrorCode.INIT_ERROR_MANUFACTURER_NOSUPPORT:
            if (completed.compareAndSet(false, true)) {
              result.error(String.valueOf(ErrorCode.INIT_ERROR_MANUFACTURER_NOSUPPORT), "厂商不支持", null);
            }
            break;
          case ErrorCode.INIT_ERROR_DEVICE_NOSUPPORT:
            if (completed.compareAndSet(false, true)) {
              result.error(String.valueOf(ErrorCode.INIT_ERROR_DEVICE_NOSUPPORT), "设备不支持", null);
            }
            break;
          case ErrorCode.INIT_ERROR_LOAD_CONFIGFILE:
            if (completed.compareAndSet(false, true)) {
              result.error(String.valueOf(ErrorCode.INIT_ERROR_LOAD_CONFIGFILE), "配置文件加载失败", null);
            }
            break;
          case ErrorCode.INIT_ERROR_RESULT_DELAY:
            // do nothing
            // 信息将会延迟返回，获取数据可能在异步线程，取决于设备
            break;
          case ErrorCode.INIT_HELPER_CALL_ERROR:
            if (completed.compareAndSet(false, true)) {
              result.error(String.valueOf(ErrorCode.INIT_HELPER_CALL_ERROR), "反射调用失败", null);
            }
            break;
          case 1008616:
            if (completed.compareAndSet(false, true)) {
              result.error(String.valueOf(1008616), "配置文件不匹配", null);
            }
            break;
          default:
            // do nothing
            break;
        }
      } catch (Throwable e) {
        if (completed.compareAndSet(false, true)) {
          result.error("FAILED", e.getMessage(), null);
        }
      }
    } else {
      result.notImplemented();
    }
  }
}
