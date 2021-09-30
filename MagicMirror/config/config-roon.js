/* Magic Mirror Config
 *
 * By Michael Teeuw http://michaelteeuw.nl
 * Modified by Ron Record http://ronrecord.com
 * MIT Licensed.
 *
 * For more information how you can configurate this file
 * See https://github.com/MichMich/MagicMirror#configuration
 *
 */

var config = {
    address: "0.0.0.0", // Address to listen on, can be:
    port: 8080,
    ipWhitelist: [
        "0.0.0.0",
        "127.0.0.1",
        "10.0.1.88", // Mac Mini
        "10.0.1.51", // Mac Pro
        "10.0.1.57", // Mac Pro
        "10.0.8.130", // Mac Pro over Tunnelblick
        "10.0.1.80", // Pi-hole
        "10.0.1.81", // Roon Core
        "10.0.1.82", // Mac Pro
        "10.0.1.94", // Ropieee
        "10.0.1.67", // Raspberry Pi MagicMirror
        "10.0.1.85", // Raspberry Pi MagicMirror
        "10.0.1.69", // iPad Air
        "10.0.1.76", // iPhone Max Xs
        "::ffff:127.0.0.1",
        "::1",
    ],

    language: "en",
    timeFormat: 12,
    units: "imperial",
    
    modules: [
        {
            module: "alert",
        },
        {
            module: "updatenotification",
            position: "top_bar"
        },
        {
            module: 'MMM-Remote-Control',
            config: {
                apiKey: 'xxx_Remote-Control-API-Key_xxxxx'
            }
        },
        {
            module: 'MMM-iFrame',
            position: 'fullscreen_below',
            config: {
                url: [ "http://10.0.1.81:9100/display/" ],
                updateInterval: 30 * 60 * 1000, // rotate URLs every 30 minutes
                width: "1080", // width of iframe
                height: "756", // height of iframe
                frameWidth: "1080"
            }
        },
        {
            module: 'MMM-SystemStats',
            position: "bottom_left",
            config: {
                updateInterval: 10000, // every 10 seconds
                align: 'right', // align labels
                header: 'System Stats', // This is optional
                units: 'imperial', // default, metric, imperial
                view: 'textAndIcon',
            }
        },
        {
            module: 'MMM-Tools',
            position: 'bottom_left',
            config: {
              device : "RPI", // "RPI" is also available
              refresh_interval_ms : 10000,
              warning_interval_ms : 1000 * 60 * 5,
              enable_warning : true,
              warning : {
                CPU_TEMPERATURE : 65,
                GPU_TEMPERATURE : 65,
                CPU_USAGE : 75,
                STORAGE_USED_PERCENT : 80,
                MEMORY_USED_PERCENT : 80
              },
              warning_text: {
                CPU_TEMPERATURE : "The temperature of CPU is over %VAL%",
                GPU_TEMPERATURE : "The temperature of GPU is over %VAL%",
                CPU_USAGE : "The usage of CPU is over %VAL%",
                STORAGE_USED_PERCENT : "The storage is used over %VAL% percent",
                MEMORY_USED_PERCENT : "The memory is used over %VAL% percent",
              }
            }
        },
        {
            module: "mmm-hue-lights",
            position: "middle_center",
            // position: "lower_third",
            config: {
                bridgeIp: "10.0.1.20",
                displayType: "grid",
                minimalGrid: false,
                updateInterval: 180000,
                user: "xxxxxxxxxx_Hue-Hub-User_xxxxxxxxxxxxxxxx",
            }
        },
        {
            module: 'MMM-Solar',
            position: "middle_center",
            config: {
                apiKey: "xxxxxx_Solar-API-Key_xxxxxxxxxxx",
                userId: "Solar-USER-ID",
                systemId: "Solar-System-ID",
                basicHeader: "true",
            }
        },
        {
            module: 'MMM-NetworkScanner',
            position: "bottom_right",
            header: "",
            config: {
                showLastSeen: "true",
                colored: "true",
                devices: [
                    { macAddress: "98:10:e8:f1:77:6d",
                      name: "Mac Mini",
                      icon: "desktop",
                      color: "#00ff00"},
                    { macAddress: "00:3e:e1:c8:14:5b",
                      name: "Mac Pro",
                      icon: "desktop",
                      color: "#ffff00"},
                    { macAddress: "d4:90:9c:da:31:9e",
                      name: "Homepod Max",
                      icon: "music",
                      color: "#26C6DA " },
                    { macAddress: "58:d3:49:2a:9f:f7",
                      name: "Homepod Mini Left",
                      icon: "music",
                      color: "#26C6DA " },
                    { macAddress: "58:d3:49:0f:02:23",
                      name: "Homepod Mini Right",
                      icon: "music",
                      color: "#26C6DA " },
                    { macAddress: "b0:6e:bf:2b:3a:f8",
                      name: "Miner (doctor)",
                      icon: "hammer",
                      color: "#ffff00"},
//                  { macAddress: "30:85:a9:8d:02:9d",
//                    name: "Miner (vivo)",
//                    icon: "hammer",
//                    color: "#ffff00"},
                    { macAddress: "4c:cc:6a:27:be:6a",
                      name: "Miner (ronnie)",
                      icon: "hammer",
                      color: "#ffff00"},
                    { ipAddress: "10.0.1.80",
                      name: "Raspberry Pi 400",
                      icon: "signal",
                      color: "#00ff00" },
                    { ipAddress: "10.0.1.81",
                      name: "Roon ROCK",
                      icon: "music",
                      color: "#00ff00" },
                    { ipAddress: "10.0.1.94",
                      name: "RPi Ropieee",
                      icon: "signal",
                      color: "#00ff00" },
                    { ipAddress: "10.0.1.85",
                      name: "RPi MagicMirror",
                      icon: "signal",
                      color: "#00ff00" },
                    { macAddress: "00:17:88:49:1a:cd",
                      name: "Philips Hue",
                      icon: "lightbulb",
                      color: "#00ff00" },
                    { macAddress: "00:04:20:f4:ea:9c",
                      name: "Harmony Hub",
                      icon: "weight",
                      color: "#00ff00" },
                    { macAddress: "2E:0E:84:7B:ED:39",
                      name: "Ronnie's iPad",
                      icon: "tablet",
                      color: "#FF8A65" },
                    { macAddress: "C8:69:CD:84:EC:47",
                      name: "Apple TV",
                      icon: "tv",
                      color: "#26C6DA " },
                    { macAddress: "36:7F:9E:F1:78:5A",
                      name: "iPhone 12 Mini",
                      icon: "mobile",
                      color: "#FF8A65" },
                    { macAddress: "00:1d:c0:62:42:67",
                      name: "Enphase",
                      icon: "solar-panel",
                      color: "#ffff00" },
                    { macAddress: "00:11:d9:60:8b:54",
                      name: "TiVo",
                      icon: "tv",
                      color: "#26C6DA " },
                    { macAddress: "00:1d:ba:c3:c7:17",
                      name: "Sony TV",
                      icon: "tv",
                      color: "#26C6DA " },
                    // { macAddress: "44:d8:84:6b:5f:b3",
                    //   name: "AirPort Express",
                    //   icon: "wifi",
                    //   color: "#81C784" },
                    // { macAddress: "24:a0:74:79:7f:9f",
                    //   name: "AirPort Extreme",
                    //   icon: "network-wired",
                    //   color: "#81C784" },
                ],
            },
        },
//      {
//          module: 'MMM-stocks',
//          position: 'bottom_bar',
//          config: {
//            apiKey: 'xxxxx_Stocks-API-Key_xxxxxxxxxxxxx',
//            crypto: 'FILUSDT,ADAUSDT,ETHUSDT,GRTUSDT,ZRXUSDT,AGIUSDT,XLMUSDT',
//            separator: '&nbsp;&nbsp;•&nbsp;&nbsp;', // separator between stocks
//            stocks: 'CGC,AAPL,HEXO,ACB,TLRY', // stock symbols
//            updateInterval: 1000000 // update interval in milliseconds (16:40)
//          }
//      },
//      {
//          module: 'MMM-TelegramBot',
//          config: {
//            telegramAPIKey : 'xxxxxx_Your-Telegram-API-Key_xxxxxxxxxxxxxxxxx',
//            allowedUser : ['Your-Telegram-Username'],
//            adminChatId : Your-Telegram-Chat-ID,
//            useWelcomeMessage: true,
//            verbose: false,
//            favourites:["/hideall", "/showall", "/screenshot", "/shutdown"],
//            screenshotScript: "scrot",
//            detailOption: {},
//            customCommands: [],
//          }
//      },
        // {
        //     module: "MMM-GoogleAssistant",
        //     position: "top_right",
        //     config: {
        //         maxWidth: "100%",
        //         header: "",
        //     publishKey: 'xxxxxx_Your-GoogleVoice-Pub-Key_xxxxxxxx',
        //     subscribeKey: 'xxxxxx_Your-GoogleVoice-Sub-Key_xxxxxxxx',
        //     updateDelay: 500
        //     }
        // },
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
