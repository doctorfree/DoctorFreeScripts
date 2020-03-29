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
        "127.0.0.1",
        "10.0.1.44", // Mac Mini
        "10.0.1.51", // Mac Pro
        "10.0.1.67", // Raspberry Pi MagicMirror
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
                apiKey: 'MMM-Remote-Control_API_Key'
            }
        },
        {
            module: "clock",
            position: "upper_third",
            config: {
                dateFormat: "dddd, LLL",
                displayType: "analog",
                analogFace: "face-009",
                analogSize: "200px",
                displaySeconds: "true",
                secondsColor: "#BAA3DC",
                timeFormat: "12",
                showPeriod: "true",
                showDate: "true",
                clockBold: "false",
                analogPlacement: "top",
                analogShowDate: "top",
            }
        },
        {
            module: "calendar",
            header: "Calendar Events",
            position: "top_left",
            config: {
                colored: true,
                maximumNumberOfDays: 10,
                maximumEntries: 20,
                showLocation: true,
                tableClass: "medium",
                timeFormat: "absolute",
                nextDaysRelative: true,
                displaySymbol: true,
                defaultSymbol: "calendar-alt",
                calendars: [
                    {
                        symbol: "calendar",
                        color: '#73FF33',
                        url: "http://localhost:8080/modules/calendars/home.ics"
                    },
                    {
                        symbol: "calendar",
                        color: '#BAA3DC',
                        url: "http://localhost:8080/modules/calendars/14D7ECFB-D078-4696-9558-E422AE330A63.ics"
                    },
                ]
            }
        },
        {
            module: "currentweather",
            position: "top_right",
            config: {
                location: "Santa Cruz",
                locationID: "5393052",
                units: "imperial",
                appid: "xx_OpenWeather-App-ID_xxxxxxxxxx"
            }
        },
        {
            module: "weatherforecast",
            position: "top_right",
            header: "Weather Forecast",
            config: {
                location: "Santa Cruz",
                locationID: "5393052",
                units: "imperial",
                showRainAmount: "true",
                colored: "true",
                appid: "xx_OpenWeather-App-ID_xxxxxxxxxx"
            }
        },
        {
            module: "newsfeed",
            position: "top_bar",
            config: {
                feeds: [
                    {
                        title: "New York Times",
                        url: "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
                    },
                    {
                        title: "Washington Post",
                        url: "http://feeds.washingtonpost.com/rss/national"
                    },
                    {
                        title: "Mercury News",
                        url: "https://www.mercurynews.com/feed"
                    },
                    {
                        title: "NBC Bay Area",
                        url: "https://www.nbcbayarea.com/news/top-stories/?rss=y",
                    }
                ],
                showSourceTitle: true,
                showPublishDate: true,
                broadcastNewsFeeds: true,
                broadcastNewsUpdates: true
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
            module: "MMM-AVStock",
            position: "bottom_bar", //"bottom_bar" is better for `mode:ticker`
            config: {
                apiKey : "xx_AVStock-API_x", // https://www.alphavantage.co/
                timeFormat: "YYYY-MM-DD HH:mm:ss",
                symbols : ["AAPL", "HEXO", "TLRY", "CGC", "ACB"],
                alias: ["Apple", "Hexo", "Tilray", "Canopy", "Aurora"],
                tickerDuration: 60, // Ticker will be cycled once per this second.
                chartDays: 90, //For `mode:series`, how much daily data will be taken. (max. 90)
                poolInterval : 1000*15, // (Changed in ver 1.1.0) - Only For Premium Account
                mode : "ticker", // "table", "ticker", "series"
                decimals: 4,
                candleSticks : true, //show candle sticks if mode is Series
                coloredCandles : true, //colored bars: red and green for negative and positive candles
                premiumAccount: false,
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
            module: "mmm-hue-lights",
            position: "lower_third",
            config: {
                bridgeIp: "10.0.1.2",
                user: "xxxxxxxxxx_Hue-Hub-User_xxxxxxxxxxxxxxxx",
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
                    { macAddress: "d4:dc:cd:f3:20:4c",
                      name: "Mac Mini",
                      icon: "desktop",
                      color: "#00ff00"},
                    { macAddress: "00:3e:e1:c8:14:5b",
                      name: "Mac Pro",
                      icon: "desktop",
                      color: "#ffff00"},
                    { macAddress: "b0:6e:bf:2b:3a:f8",
                      name: "Miner",
                      icon: "hammer",
                      color: "#ffff00"},
                    { ipAddress: "10.0.1.67",
                      name: "Raspberry Pi",
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
                    { ipAddress: "10.0.1.69",
                      name: "iPad Air",
                      icon: "tablet",
                      color: "#FF8A65" },
                    { ipAddress: "10.0.1.7",
                      name: "Apple TV",
                      icon: "tv",
                      color: "#26C6DA " },
                    { ipAddress: "10.0.1.68",
                      name: "Apple TV Gen 4",
                      icon: "tv",
                      color: "#26C6DA " },
                    { ipAddress: "10.0.1.76",
                      name: "iPhone Xs Max",
                      icon: "mobile",
                      color: "#FF8A65" },
                    { macAddress: "44:d8:84:6b:5f:b3",
                      name: "AirPort Express",
                      icon: "wifi",
                      color: "#81C784" },
                    { macAddress: "00:1f:f3:f4:52:47",
                      name: "AirPort Express",
                      icon: "wifi",
                      color: "#81C784" },
                    { macAddress: "24:a0:74:79:7f:9f",
                      name: "AirPort Extreme",
                      icon: "network-wired",
                      color: "#81C784" },
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
                ],
            },
        },
        {
            module: 'MMM-TelegramBot',
            config: {
              telegramAPIKey : 'xxxxxx_Your-Telegram-API-Key_xxxxxxxxxxxxxxxxx',
              allowedUser : ['Your-Telegram-Username'],
              adminChatId : Your-Telegram-Chat-ID,
              useWelcomeMessage: true,
              verbose: false,
              favourites:["/hideall", "/showall", "/screenshot", "/shutdown"],
              screenshotScript: "scrot",
              detailOption: {},
              customCommands: [],
            }
        },
        {
            module: "MMM-AssistantMk2",
            position: "fullscreen_above",
            config: {
              debug: false,
              ui: "Fullscreen", // Classic2 or Classic
              // if you want Google Home ui style
              // set Fullscreen ui AND fullscreen_above position
              assistantConfig: {
                // Required to use gaction.
                projectId: "Google_Assistant_Project_ID",
                // (OPTIONAL for gaction)
                modelId: "Google_Assistant_Model_ID",
                // (OPTIONAL for gaction)
                instanceId: "Mirror_of_Doctorwhen",
                latitude: 36.970019,
                longitude: -122.042212,
              },
              responseConfig: {
                useHTML5: false, // sound render by HTML5
                useScreenOutput: true,
                useAudioOutput: true,
                useChime: true,
                timer: 5000,
                myMagicWord: true,
                //Your prefer sound play program.
                //By example, if you are running this on OSX, `afplay` could be available.
                //by default mpg321 play program is enabled
                //if audio output cutting try with mpg123 or cvlc program
                playProgram: "mpg321",
                chime: {
                  beep: "beep.mp3",
                  error: "error.mp3",
                  continue: "continue.mp3",
                  open: "Google_beep_open.mp3",
                  close: "Google_beep_close.mp3",
                },
                // false - animated icons,
                // 'standby' - static icons only for standby state,
                // true - all static icons
                useStaticIcons: false
              },
              micConfig: { // put there configuration generated by auto-installer
                recorder: "arecord",
                device: "plughw:1",
              },
              customActionConfig: {
                autoMakeAction: false,
                // in RPI, gaction CLI might have some trouble.
                // current version should be 2.2.4, but for linux-arm,
                // Google haven't updated so leave this as false in RPI.
                // I don't know it is solved or not.
                autoUpdateAction: false,
                // At this moment, multi-languages are not supported, sorry. Someday I'll work.
                actionLocale: "en-US",
              },
              recipes: [
                         "with-MMM-Hotword.js",
                         "with-MMM-TelegramBot.js",
                         "mirror-script.js",
                         "Reboot-Restart-Shutdown.js",
                       ],
              profiles: {
                "default": {
                  profileFile: "default.json",
                  lang: "en-US"
                }
              },
              addons: true,
            },
        },
        {
            module: "MMM-Hotword",
            position: "top_right",
            config: {
              useDisplay: false,
              chimeOnFinish: "resources/ding.wav",
              recipes: [
                         "with-AMk2v3-noisy_smart-mirror.js",
//                       "mirror_mirror-personal_model.js",
                       ],
              mic: {
                recordProgram: "arecord",
                device: "plughw:1",
              },
            },
        },
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
