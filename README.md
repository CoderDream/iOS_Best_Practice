# iOS_Best_Practice


- [创建项目并集成LeanCloud](https://github.com/CoderDream/iOS_10_Development_QuickStart_Guide/blob/b61a0bfa2afb149bb9ca9cfa8e2e91d8befbdbe7/BookAssets/%E6%BA%90%E4%BB%A3%E7%A0%81/%E7%AC%AC1%E7%AB%A0/README.md)
- [创建项目并集成LeanCloud SDK](https://github.com/CoderDream/iOS_10_Development_QuickStart_Guide/blob/master/chapter01.md)
- [Swift SDK 安装指南](https://tab.leancloud.cn/docs/start.html)
- [数据存储开发指南 · Swift](https://leancloud.cn/docs/leanstorage_guide-swift.html)


```
2019-02-21 11:34:12.482873+0800 LeanCloudSwiftDemo[21624:561530] libMobileGestalt MobileGestalt.c:890: MGIsDeviceOneOfType is not supported on this platform.
2019-02-21 11:34:13.002041+0800 LeanCloudSwiftDemo[21624:561530] CredStore - performQuery - Error copying matching creds.  Error=-25300, query={
    class = inet;
    "m_Limit" = "m_LimitAll";
    ptcl = htps;
    "r_Attributes" = 1;
    sdmn = "app-router.leancloud.cn";
    srvr = "app-router.leancloud.cn";
    sync = syna;
}
[💙][Debug][LeanCloud][2019-02-21.11:34:12.890 HTTPClient.swift #372 log(request:)]: 

------ BEGIN LeanCloud HTTP Request
task: 1
curl: curl -v \
	-H "X-LC-Id: VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va" \
	-H "Accept: application/json" \
	-H "X-LC-Sign: ef27ccef9020ea3d0b37e9ee0dd01521,1550720052877" \
	-H "User-Agent: LeanCloud-Swift-SDK/15.0.0" \
	"https://app-router.leancloud.cn/2/route?appId=VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va"
------ END

2019-02-21 11:34:13.120907+0800 LeanCloudSwiftDemo[21624:561530] CredStore - performQuery - Error copying matching creds.  Error=-25300, query={
    class = inet;
    "m_Limit" = "m_LimitAll";
    ptcl = htps;
    "r_Attributes" = 1;
    sdmn = "vofcgion.api.lncldapi.com";
    srvr = "vofcgion.api.lncldapi.com";
    sync = syna;
}
[💙][Debug][LeanCloud][2019-02-21.11:34:13.120 HTTPClient.swift #372 log(request:)]: 

------ BEGIN LeanCloud HTTP Request
task: 1
curl: curl -v \
	-H "X-LC-Id: VOfCGionrepsdh1dly5lPlfX-9Nh9j0Va" \
	-H "Accept: application/json" \
	-H "X-LC-Sign: 2217358da276beb4241d70d13bd06723,1550720053118" \
	-H "User-Agent: LeanCloud-Swift-SDK/15.0.0" \
	"https://vofcgion.api.lncldapi.com/1.1/cloudQuery?cql=delete%20from%20Todo%20where%20objectId%3D%27155c6aad6f19a27c001aa6b065%27"
------ END

[💙][Debug][LeanCloud][2019-02-21.11:34:13.759 HTTPClient.swift #368 log(response:request:)]: 

------ BEGIN LeanCloud HTTP Response
task: 1
code: 200
data: {
    "api_server": "vofcgion.api.lncldapi.com",
    "engine_server": "vofcgion.engine.lncldapi.com",
    "play_server": "vofcgion.play.lncldapi.com",
    "push_server": "vofcgion.push.lncldapi.com",
    "rtm_router_server": "vofcgion.rtm.lncldapi.com",
    "stats_server": "vofcgion.stats.lncldapi.com",
    "ttl": 3600
}
------ END

[💙][Debug][LeanCloud][2019-02-21.11:34:14.123 HTTPClient.swift #368 log(response:request:)]: 

------ BEGIN LeanCloud HTTP Response
task: 1
code: 200
data: {
    "className": "Todo",
    "results": [
        {}
    ]
}
------ END

Todo Object delete success
2019-02-21 11:34:15.717174+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x60000235d200]: 1:57
2019-02-21 11:34:15.717406+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x60000235d200]: 1:57
2019-02-21 11:34:15.717677+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x60000235d200]: 1:57
2019-02-21 11:34:15.723035+0800 LeanCloudSwiftDemo[21624:561630] [BoringSSL] nw_protocol_boringssl_get_output_frames(1301) [C1.1:2][0x7fe18c402d90] get output frames failed, state 8196
2019-02-21 11:34:15.723339+0800 LeanCloudSwiftDemo[21624:561630] [BoringSSL] nw_protocol_boringssl_get_output_frames(1301) [C1.1:2][0x7fe18c402d90] get output frames failed, state 8196
2019-02-21 11:34:15.723852+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x0]: 1:57
2019-02-21 11:34:15.723958+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x0]: 1:57
2019-02-21 11:34:15.724212+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x0]: 1:57
2019-02-21 11:34:15.724350+0800 LeanCloudSwiftDemo[21624:561630] TIC Read Status [1:0x0]: 1:57


```