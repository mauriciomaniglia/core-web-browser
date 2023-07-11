let blockCryptomining =
"""
[
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?1q2w3\\.website","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?ad-miner\\.com","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?adless\\.io","load-type":["third-party"],"unless-domain":["*adless.io","*gridcash.net"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?alflying\\.date","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?alflying\\.win","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?analytics\\.blue","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?anybest\\.site","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?aster18cdn\\.nl","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?authedmine\\.com","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?authedwebmine\\.cz","load-type":["third-party"],"unless-domain":["*webmine.cz"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?belicimo\\.pw","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?besstahete\\.info","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?bitcoin-pay\\.eu","load-type":["third-party"],"unless-domain":["*crypto-webminer.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?bmst\\.pw","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?cashbeet\\.com","load-type":["third-party"],"unless-domain":["*cashbeet.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?cnhv\\.co","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?coin-hive\\.com","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?coinhive\\.com","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?coinpot\\.co","load-type":["third-party"],"unless-domain":["*coinpot.co"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?cryptaloot\\.pro","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?crypto-loot\\.com","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?crypto-webminer\\.com","load-type":["third-party"],"unless-domain":["*crypto-webminer.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?cryptolootminer\\.com","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?dinorslick\\.icu","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?ethpocket\\.de","load-type":["third-party"],"unless-domain":["*crypto-webminer.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?ethtrader\\.de","load-type":["third-party"],"unless-domain":["*crypto-webminer.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?feesocrald\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flashx\\.pw","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flightsy\\.bid","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flightsy\\.win","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flightzy\\.bid","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flightzy\\.date","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?flightzy\\.win","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?freecontent\\.bid","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?freecontent\\.date","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?freecontent\\.stream","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?gitgrub\\.pro","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?gramombird\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?gridcash\\.net","load-type":["third-party"],"unless-domain":["*adless.io","*gridcash.net"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?hashing\\.win","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?hostingcloud\\.racing","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?hostingcloud\\.science","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?istlandoll\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?jsecoin\\.com","load-type":["third-party"],"unless-domain":["*jsecoin.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?mepirtedic\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?mineralt\\.io","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?minescripts\\.info","load-type":["third-party"],"unless-domain":["*minescripts.info"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?minexmr\\.stream","load-type":["third-party"],"unless-domain":["*minexmr.stream"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?nerohut\\.com","load-type":["third-party"],"unless-domain":["*nerohut.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?nhsrv\\.cf","load-type":["third-party"],"unless-domain":["*nerohut.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?pampopholf\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?reauthenticator\\.com","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?serv1swork\\.com","load-type":["third-party"],"unless-domain":["*cashbeet.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?service4refresh\\.info","load-type":["third-party"],"unless-domain":["*service4refresh.info"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?sparechange\\.io","load-type":["third-party"],"unless-domain":["*sparechange.io"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?sslverify\\.info","load-type":["third-party"],"unless-domain":["*minescripts.info"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?statdynamic\\.com","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?swiftmining\\.win","load-type":["third-party"],"unless-domain":["*swiftmining.win"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?tercabilis\\.info","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?tulip18\\.com","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?vidzi\\.tv","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?webmine\\.cz","load-type":["third-party"],"unless-domain":["*webmine.cz"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?webmine\\.pro","load-type":["third-party"],"unless-domain":["*crypto-loot.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?webminepool\\.com","load-type":["third-party"],"unless-domain":["*webminepool.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?webmining\\.co","load-type":["third-party"],"unless-domain":["*webmining.co"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?wsservices\\.org","load-type":["third-party"],"unless-domain":["*authedmine.com","*coinhive.com"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?yololike\\.space","load-type":["third-party"],"unless-domain":["*mineralt.io","*vidzi.nu","*vidzi.tv"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?zymerget\\.bid","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}},
{"action":{"type":"block"},"trigger":{"url-filter":"^https?://([^/]+\\.)?zymerget\\.faith","load-type":["third-party"],"unless-domain":["*alflying.date","*alflying.win","*anybest.site","*flightsy.bid","*flightsy.win","*flightzy.bid","*flightzy.date","*flightzy.win","*zymerget.bid","*zymerget.faith"]}}
]
"""
