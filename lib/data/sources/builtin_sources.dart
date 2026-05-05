import 'maccms_source.dart';

/// 15 builtin maccms video sources.
List<MaccmsSource> createBuiltinSources() {
  return [
    MaccmsSource(name: '量子资源', apiBase: 'https://cj.lziapi.com/api.php/provide/vod/'),
    MaccmsSource(name: '森林资源', apiBase: 'https://slapibf.com/api.php/provide/vod'),
    MaccmsSource(name: '海外看', apiBase: 'https://haiwaikan.com/api.php/provide/vod/'),
    MaccmsSource(name: '飞鱼资源', apiBase: 'https://www.feisuzyapi.com/api.php/provide/vod/'),
    MaccmsSource(name: '爱坤资源', apiBase: 'https://ikunzyapi.com/api.php/provide/vod/'),
    MaccmsSource(name: '卧龙资源', apiBase: 'https://wlzy.tv/api.php/provide/vod/'),
    MaccmsSource(name: '闪电资源', apiBase: 'https://shandianzy.com/api.php/provide/vod/'),
    MaccmsSource(name: '樱花动漫', apiBase: 'https://m.yhdmz.org/api.php/provide/vod/'),
    MaccmsSource(name: '光速资源', apiBase: 'https://api.guangsuapi.com/api.php/provide/vod/'),
    MaccmsSource(name: '红牛资源', apiBase: 'https://www.hongniuzy2.com/api.php/provide/vod/'),
    MaccmsSource(name: '无尽资源', apiBase: 'https://api.wujinapi.me/api.php/provide/vod/'),
    MaccmsSource(name: '新浪资源', apiBase: 'https://api.xinlangapi.com/xinlangapi.php/provide/vod/'),
    MaccmsSource(name: '多多资源', apiBase: 'https://www.ddzyz1.com/api.php/provide/vod/'),
    MaccmsSource(name: '酷点资源', apiBase: 'https://kudian10.com/api.php/provide/vod/'),
    MaccmsSource(name: '星空资源', apiBase: 'https://js.xonono.top/api.php/provide/vod/'),
  ];
}
