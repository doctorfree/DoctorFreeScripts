/* Magic Mirror Config Sample
 *
 * By Michael Teeuw http://michaelteeuw.nl
 * MIT Licensed.
 *
 * For more information how you can configurate this file
 * See https://github.com/MichMich/MagicMirror#configuration
 *
 */

var config = {
//    address: "localhost",
    address: "0.0.0.0", // Address to listen on, can be:
                          // - "localhost", "127.0.0.1", "::1" to listen on loopback interface
                          // - another specific IPv4/6 to listen on a specific interface
                          // - "", "0.0.0.0", "::" to listen on any interface
                          // Default, when address config is left out, is "localhost"
    port: 8080,
    // Set [] to allow all IP addresses
    // or add a specific IPv4 of 192.168.1.5 :
    // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
    // or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
    // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],
    ipWhitelist: [
        "127.0.0.1",
        "10.0.1.44", // Mac Mini
        "10.0.1.51", // Mac Pro
        "10.0.1.67", // Raspberry Pi MagicMirror
        "10.0.1.69", // iPad Air
        "10.0.1.76", // iPhone Max Xs
        "::ffff:127.0.0.1",
        "::1",
    //  "::ffff:10.0.1.0/26",
    //  "::ffff:10.0.1.64/27",
    //  "::ffff:10.0.1.96/30"
    ],

    language: "en",
    timeFormat: 12,
    units: "imperial",
    // serverOnly:  true/false/"local" ,
                 // local for armv6l processors, default 
                 //   starts serveronly and then starts chrome browser
                 // false, default for all  NON-armv6l devices
                 // true, force serveronly mode, because you want to.. no UI on this device
    
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
        //  position: 'top_bar',
        //  config: {
        //      customCommand: {},  // Optional, See "Using Custom Commands" below
        //      customMenu: "custom_menu.json", // Optional, See "Custom Menu Items" below
        //      showModuleApiMenu: true, // Optional, Enable the Module Controls menu
        //      apiKey: "",         // Optional, See API/README.md for details
        //  }
        },
        {
            module: "clock",
            position: "middle_center",
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
                    {
                        symbol: "calendar",
                        color: '#33FFFA',
                        url: "http://localhost:8080/modules/calendars/W14D7ECFB-D078-4696-9558-E422AE330A63.ics"
                    }
                ]
            }
        },
        {
            module: "currentweather",
            position: "top_right",
            config: {
                location: "Santa Cruz",
                // ID from http://bulk.openweathermap.org/sample/city.list.json.gz
                // unzip the gz file and find your city
                locationID: "5393052",
                units: "imperial",
                appid: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
            }
        },
        {
            module: "weatherforecast",
            position: "top_right",
            header: "Weather Forecast",
            config: {
                location: "Santa Cruz",
                // ID from http://bulk.openweathermap.org/sample/city.list.json.gz
                // unzip the gz file and find your city
                locationID: "5393052",
                units: "imperial",
                showRainAmount: "true",
                colored: "true",
                appid: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
     // {
     //     module: 'MMM-CoinMarketCap',
     //     position: 'lower_third', 
     //     header: "Cryptocurrencies",
     //     config: {
     //         currencies: ['bitcoin', 'ethereum', 'litecoin', 'stellar'],
     //         view: 'graphWithChanges',
     //         conversion: 'USD',
     //     }
     // },
     // {
     //     module: "MMM-AVStock",
     //     position: "lower_third", //"bottom_bar" is better for `mode:ticker`
     //     config: {
     //         apiKey : "xxxxxxxxxxxxxxxx", // https://www.alphavantage.co/
     //         timeFormat: "YYYY-MM-DD HH:mm:ss",
     //         symbols : ["AAPL", "GOOGL", "CGC", "ACB"],
     //         alias: ["Apple", "Google", "Canopy", "Aurora"],
     //         tickerDuration: 60, // Ticker will be cycled once per this second.
     //         chartDays: 90, //For `mode:series`, how much daily data will be taken. (max. 90)
     //         poolInterval : 1000*15, // (Changed in ver 1.1.0) - Only For Premium Account
     //         mode : "series", // "table", "ticker", "series"
     //         decimals: 4,
     //         candleSticks : true, //show candle sticks if mode is Series
     //         coloredCandles : true, //colored bars: red and green for negative and positive candles
     //         premiumAccount: false,
     //     }
     // },
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
//      {
//          module: 'MMM-ip',
//          position: 'bottom_bar',
//          config: {
//              showFamily: 'IPv4',
//              showType:    'both',
//              fontSize:    24,
//              dimmed:    'false',
//          }
//      },
        {
            module: 'MMM-stocks',
            position: 'bottom_bar',
            config: {
              apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
              crypto: 'BTCUSDT,LTCUSDT,ETHUSDT', // crypto symbols
              separator: '&nbsp;&nbsp;•&nbsp;&nbsp;', // separator between stocks
              stocks: 'CGC,AAPL,GOOG,ACB', // stock symbols
              updateInterval: 1000000 // update interval in milliseconds (16:40)
            }
        },
        {
            module: 'MMM-Solar',
            position: "middle_center",
        //  classes: "daytime",
            config: {
                apiKey: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                userId: "xxxxxxxxxxxxxxxxxx",
                systemId: "xxxxxx",
                basicHeader: "true",
            }
        },
        {
            module: "mmm-hue-lights",
            position: "lower_third",
        //  classes: "nighttime",
            config: {
                bridgeIp: "10.0.1.2",
                user: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            }
        },
        {
            module: 'MMM-ModuleScheduler',
            config: {
                // SHOW ALL MODULES AT FULL BRIGHTNESS AT 06:00 AND DIM THEM TO 20% AT 22:00
                // global_schedule: {from: '0 6 * * *', to: '0 22 * * *', dimLevel: '20' },
                global_schedule: [
                    // SHOW Class "daytime" MODULES AT 07AM AND HIDE AT 7PM EVERY DAY
                    //{from: '0 7 * * *', to: '0 19 * * *', groupClass: 'daytime'},
                    // SHOW Class "nighttime" MODULES AT 07PM AND HIDE AT 7AM EVERY DAY
                    //{from: '0 19 * * *', to: '59 23 * * *', groupClass: 'nighttime'},
                ],
                notification_schedule: [
                    // TURN THE MONITOR/SCREEN ON AT 06:45 EVERY DAY
                    //{
                    //    notification: 'REMOTE_ACTION',
                    //    schedule: '45 6 * * *',
                    //    payload: {action: "MONITORON"}
                    //},
                    // TURN THE MONITOR/SCREEN OFF AT 22:30 EVERY DAY
                    //{
                    //    notification: 'REMOTE_ACTION',
                    //    schedule: '30 22 * * *',
                    //    payload: {action: "MONITOROFF"}
                    //},
                    // RESTART THE MAGICMIRROR PROCESS AT 2am EVERY SUNDAY
                    //{
                    //    notification: 'REMOTE_ACTION',
                    //    schedule: '0 2 * * SUN',
                    //    payload: {
                    //        action: "RESTART"
                    //    }
                    //},
                    // TURN THE SCREEN BRIGHTNESS "DAY" AT 06:30 EVERY DAY
                    //{
                    //    notification: 'REMOTE_ACTION',
                    //    schedule: '30 6 * * *',
                    //    payload: {
                    //        action: "BRIGHTNESS",
                    //        value: "100"
                    //    }
                    //},
                    // TURN THE SCREEN BRIGHTNESS "NIGHT" AT 22:30 EVERY DAY
                    //{
                    //    notification: 'REMOTE_ACTION',
                    //    schedule: '30 22 * * *',
                    //    payload: {
                    //        action: "BRIGHTNESS",
                    //        value: "50"
                    //    }
                    //}
                ]
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
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Mac Mini",
                      icon: "desktop",
                      color: "#00ff00"},
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Mac Pro",
                      icon: "desktop",
                      color: "#ffff00"},
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Miner",
                      icon: "hammer",
                      color: "#ffff00"},
                    { ipAddress: "xx.x.x.xx",
                      name: "Raspberry Pi",
                      icon: "signal",
                      color: "#00ff00" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Philips Hue",
                      icon: "lightbulb",
                      color: "#00ff00" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Scale",
                      icon: "weight",
                      color: "#00ff00" },
                    { ipAddress: "xx.x.x.xx",
                      name: "iPad Air",
                      icon: "tablet",
                      color: "#FF8A65" },
                    { ipAddress: "xx.x.x.xx",
                      name: "iPhone Xs Max",
                      icon: "mobile",
                      color: "#FF8A65" },
                 // { macAddress: "xx:xx:xx:xx:xx:xx",
                 //     name: "Apple Watch",
                 //     icon: "dharmachakra",
                 //     color: "#FF8A65" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "AirPort Express",
                      icon: "wifi",
                      color: "#81C784" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "AirPort Express",
                      icon: "wifi",
                      color: "#81C784" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "AirPort Extreme",
                      icon: "network-wired",
                      color: "#81C784" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Enphase",
                      icon: "solar-panel",
                      color: "#ffff00" },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "TiVo",
                      icon: "tv",
                      color: "#26C6DA " },
                    { macAddress: "xx:xx:xx:xx:xx:xx",
                      name: "Sony TV",
                      icon: "tv",
                      color: "#26C6DA " },
                ],
            },
        },
        {
            module: "Hello-Lucy",
            disabled: false,
            position: "bottom_center",
            config: {
                // MUST BE CAPITALS to make Lucy start listening
                keyword: 'HELLO LUCY',
                // run "arecord -l" card# and device# of your microphone/sound card
                microphone: "1,0",
                // timeout listening for a command/sentence
                timeout: 15,
                defaultOnStartup: 'Hello-Lucy',
                standByMethod: 'HIDE',
                // welcome sound at startup. Add several for a random welcome sound
                sounds: ["MagicMirror-Welcome.mp3", "MagicMirror-Welcome-Two.mp3"],
                // when command is accepted. use your own or default
                confirmationSound: "ding.mp3",
                // if true, all modules start as hidden
                startHideAll: false,
                // default modules to show on page one/startup
                pageOneModules: ["Hello-Lucy", "alert", "clock", "calendar", "currentweather", "weatherforecast", "newsfeed", "MMM-SystemStats", "MMM-stocks", "MMM-Solar", "mmm-hue-lights", "MMM-NetworkScanner"],
                pageTwoModules: ["Hello-Lucy", "alert", "clock", "calendar", "currentweather", "weatherforecast", "newsfeed", "MMM-SystemStats", "mmm-hue-lights", "MMM-NetworkScanner"],
                pageThreeModules: ["Hello-Lucy", "alert", "clock", "calendar", "currentweather", "weatherforecast", "newsfeed", "MMM-SystemStats", "MMM-stocks", "MMM-Solar", "MMM-NetworkScanner"],
                pageFourModules: ["Hello-Lucy", "alert", "MMM-SystemStats", "MMM-stocks", "mmm-hue-lights"],
                pageFiveModules: [],
                pageSixModules: [],
                pageSevenModules: [],
                pageEightModules: [],
                pageNineModules: [],
                pageTenModules: []
            }
        },
//      {
//          module: 'MMM-BackgroundSlideshow',
//          position: 'fullscreen_below',
//          classes: 'scheduler',
//          config: {
//              imagePaths: [
//                  'modules/MMM-BackgroundSlideshow/exampleImages/',
//                  'modules/MMM-BackgroundSlideshow/fractals/',
//              ],
//              slideshowSpeed: 10000, // 10 seconds
//              transitionImages: true,
//              randomizeImageOrder: true,
//              recursiveSubDirectories: true,
//              //backgroundSize: "contain",
//              // DISPLAY THE SLIDE SHOW BETWEEN 6PM and 8PM then again between 9PM and 11PM
//              module_schedule: [
//                  {from: '0 18 * * *', to:   '0 20 * * *'},
//                  {from: '0 21 * * *', to:   '0 23 * * *'}
//              ]
//          }
//      },
//      {
//          module: 'MMM-PlexSlideshow',
//          position: 'fullscreen_below',
//          classes: 'scheduler',
//          config: {
//            plex: {
//              hostname:"xx.x.x.xx",
//              port:32400,
//              username:"",
//              password:"",
//            },
//            transitionImages: true,
//            // DISPLAY THE PLEX FAVS WEEKENDS BETWEEN 6PM and 8PM then again between 9PM and 11PM
//            module_schedule: [
//                {from: '0 18 * * 0,6', to:   '0 20 * * 0,6'},
//                {from: '0 21 * * 0,6', to:   '0 23 * * 0,6'}
//            ]
//         }
//      }
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
