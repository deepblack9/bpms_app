package com.xinrui.bpms_app;

import android.os.Bundle;

import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BaiduMapOptions;
import com.baidu.mapapi.map.MapPoi;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.OverlayOptions;
import com.baidu.mapapi.map.PolylineOptions;
import com.baidu.mapapi.map.SupportMapFragment;
import com.baidu.mapapi.model.LatLng;
import com.utils.baidumap.MapRegistrant;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
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
        //设置折线的属性
        OverlayOptions mOverlayOptions = new PolylineOptions()
                .width(10)
                .color(0xAAFF0000)
                .points(linePoints)
                .dottedLine(true); //设置折线显示为虚线
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
  }
}
