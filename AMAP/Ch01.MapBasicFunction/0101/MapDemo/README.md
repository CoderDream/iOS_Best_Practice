

## 地图基础功能

### [地图选点](https://lbs.amap.com/dev/demo/place-choose#iOS)

- 1、检索屏幕中心点周边的特征POI，帮助用户快速、准确的确认自己的位置。

- 2、第一次进到页面中，基于定位位置，在定位回调中进行POI搜索和逆地理编码。

```Swift
func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
    if !updatingLocation {
        return
    }
    if userLocation.location.horizontalAccuracy < 0 {
        return
    }
    // only the first locate used.
    if !self.isLocated {
        self.isLocated = true
        self.mapView.userTrackingMode = .follow
        self.mapView.centerCoordinate = userLocation.location.coordinate
        self.actionSearchAround(at: userLocation.location.coordinate)
    }
}
```
- 3、拖动地图时，在地图区域改变的回调中进行POI周边搜索。

```Swift
func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
    if !self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == .none {
        self.actionSearchAround(at: self.mapView.centerCoordinate)
    }
    self.isMapViewRegionChangedFromTableView = false
}
```
- 4、通过POI搜索回调和逆地理编码的回调获取数据填充到TableView中。

```Swift
func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {

    if isFromMoreButton {
        isFromMoreButton = false
    }
    else {
        self.searchPoiArray.removeAll()
        self.moreButton.setTitle(kMoreButtonTitle, for: UIControlState.normal)
        self.moreButton.isEnabled = true
        self.moreButton.backgroundColor = UIColor.white
    }

    if response.count == 0 {
        self.moreButton.setTitle("没有数据了...", for: UIControlState.normal)
        self.moreButton.isEnabled = false
        self.moreButton.backgroundColor = UIColor.gray
        self.selectedIndexPath = nil

        self.tableView.reloadData()

        return
    }

    self.searchPoiArray.append(contentsOf: response.pois)
    self.selectedIndexPath = nil
    self.tableView.reloadData()
}

func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {

    if response.regeocode != nil {
        self.currentAddress = response.regeocode.formattedAddress;
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.none)
    }
}
```

- Console
```
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
error :Optional(Error Domain=AMapSearchErrorDomain Code=1802 "The request timed out." UserInfo={NSLocalizedDescription=The request timed out.})
```
