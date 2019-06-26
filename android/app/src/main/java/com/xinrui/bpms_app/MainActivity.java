package com.xinrui.bpms_app;

import android.os.Bundle;

import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BaiduMapOptions;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapPoi;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MarkerOptions;
import com.baidu.mapapi.map.Overlay;
import com.baidu.mapapi.map.OverlayOptions;
import com.baidu.mapapi.map.PolylineOptions;
import com.baidu.mapapi.map.SupportMapFragment;
import com.baidu.mapapi.model.LatLng;
import com.utils.baidumap.MapRegistrant;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  // 地图绘制
  private static final String CHANNEL = "baidumap.flutter.io/draw";

  MapView mapView = null;

  List<LatLng> linePoints = new ArrayList<LatLng>();
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // GeneratedPluginRegistrant.registerWith(this);
    mapView = new MapView(this);
    BaiduMapOptions options = new BaiduMapOptions();

    LatLng GEO_BEIJING = new LatLng(39.945, 116.404);
    LatLng GEO_SHANGHAI = new LatLng(31.227, 121.481);

    //上海为地图中心
    MapStatusUpdate status = MapStatusUpdateFactory.newLatLng(GEO_SHANGHAI);
    mapView.getMap().setMapStatus(status);

    MapRegistrant.registerWith(this, mapView);

    BaiduMap.OnMapClickListener listener = new BaiduMap.OnMapClickListener() {
      /**
       * 地图单击事件回调函数
       *
       * @param point 点击的地理坐标
       */
      @Override
      public void onMapClick(LatLng point) {
        linePoints.add(point);
        System.out.println("点数：" + linePoints.size());
        if (linePoints.size() == 1) {
          drawStartPoint(point);
        }

        if (linePoints.size() >= 2) {
          drawLine();
        }
      }

      /**
       * 地图内 Poi 单击事件回调函数
       *
       * @param mapPoi 点击的 poi 信息
       */
      @Override
      public boolean onMapPoiClick(MapPoi mapPoi) {
        return false;
      }
    };
//设置地图单击事件监听
//    mBaiduMap.setOnMapClickListener(listener);
    mapView.getMap().setOnMapClickListener(listener);

    // setMethodCallHandler在此通道上接收方法调用的回调
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          // 通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可
          if(methodCall.method.equals("undo")) {
            undo();
            result.success(1);
          } if(methodCall.method.equals("getLinePoints")) {
            result.success(getLinePoints());
          } else {
            result.notImplemented();
          }
        }
      }
    );
  }

  private void drawStartPoint(LatLng point) {
    //构建Marker图标
    BitmapDescriptor bitmap = BitmapDescriptorFactory
          .fromResource(android.R.drawable.ic_notification_overlay);
    //构建MarkerOption，用于在地图上添加Marker
    OverlayOptions option = new MarkerOptions()
          .position(point)
          .icon(bitmap);
    //在地图上添加Marker，并显示
    mapView.getMap().addOverlay(option);
  }

  private void drawLine() {
    //设置折线的属性
    OverlayOptions mOverlayOptions = new PolylineOptions()
          .width(10)
          .color(0xAAFF0000)
          .points(linePoints);
//                .dottedLine(true); //设置折线显示为虚线
    // 绘制折线
    Overlay mPolyline = mapView.getMap().addOverlay(mOverlayOptions);
  }

  private void undo() {
    System.out.println("undo");
    if(linePoints.size() > 0) {
      linePoints.remove(linePoints.size() - 1);
      mapView.getMap().clear();
      drawStartPoint(linePoints.get(0));
      if(linePoints.size() >= 2) {
        drawLine();
      }
    }
  }

  private String getLinePoints() {
    return "point";
  }
}
