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
//	address: "localhost",
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
	serverOnly:  true,
	
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
//					{
//						symbol: "calendar",
//                        color: '#33FFFA',
//						url: "http://localhost:8080/modules/calendars/W14D7ECFB-D078-4696-9558-E422AE330A63.ics"
//                    }
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
				appid: "xx_OpenWeather-App-ID_xxxxxxxxxx"
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
				appid: "xx_OpenWeather-App-ID_xxxxxxxxxx"
			}
		},
		{
			module: "newsfeed",
			position: "top_bar",
        //  classes: "daytime",
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
     //     classes: "daytime",
     //     config: {
     //         apiKey : "xx_AVStock-API_x", // https://www.alphavantage.co/
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
            module: 'MMM-Tools',
            position: 'bottom_center',
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
            module: 'MMM-SystemStats',
			position: "bottom_right",
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
//              showType:	'both',
//              fontSize:	24,
//              dimmed:	'false',
//          }
//      },
        {
            module: 'MMM-stocks',
            position: 'bottom_bar',
            config: {
              apiKey: 'xxxxx_Weather-API-Key_xxxxxxxxxxxxx',
              crypto: 'BATUSDT,ADAUSDT,ETHUSDT,POLYBNB,ZRXUSDT,MCOUSDT', // crypto symbols
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
		        apiKey: "xxxxxx_Solar-API-Key_xxxxxxxxxxx",
		        userId: "Solar-USER-ID",
		        systemId: "Solar-System-ID",
		        basicHeader: "true",
	        }
        },
        {
            module: "mmm-hue-lights",
            position: "lower_third",
        //  classes: "nighttime",
            config: {
                bridgeIp: "10.0.1.2",
                user: "xxxxxxxxxx_Hue-Hub-User_xxxxxxxxxxxxxxxx",
            }
        },
        {
            module: 'MMM-NetworkScanner',
            position: "bottom_left",
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
                      name: "Scale",
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
                 // { macAddress: "F8:6F:C1:96:9B:0B",
                 //     name: "Apple Watch",
                 //     icon: "dharmachakra",
                 //     color: "#FF8A65" },
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
            module: 'MMM-BackgroundSlideshow',
            position: 'fullscreen_below',
            classes: 'scheduler',
            config: {
                imagePaths: [
                    'modules/MMM-BackgroundSlideshow/exampleImages/',
                    'modules/MMM-BackgroundSlideshow/pics/fractals/',
                ],
                slideshowSpeed: 15000, // 15 seconds
                transitionImages: true,
                randomizeImageOrder: true,
                recursiveSubDirectories: true,
                // DISPLAY THE SLIDE SHOW BETWEEN 6PM and 8PM then again between 10PM and Midnight
                module_schedule: [
                    {from: '0 18 * * *', to:   '0 20 * * *'},
                    {from: '0 22 * * *', to:   '59 23 * * *'}
                ]
            }
        },
        {
            module: 'MMM-TelegramBot',
            config: {
              telegramAPIKey : 'xxxxxx_Your-Telegram-API-Key_xxxxxxxxxxxxxxxxx',
              // This is NOT the username of bot.
              allowedUser : ['Your-Telegram-Username'],
              adminChatId : Your-Telegram-Chat-ID,
              useWelcomeMessage: true,
              verbose: false,
              favourites:["/hideall", "/showall", "/screenshot", "/shutdown"],
              screenshotScript: "scrot",
              detailOption: {},
              customCommands: [],
//            customCommands: [
//              {
//                command: "test",
//                callback: (command, handler) => {
//                  handler.reply("TEXT", "This is test command!")
//                }
//              },
//              {
//                command: "detailnews",
//                description: "For detail of current news article"
//                callback: (command, handler, self) => {
//                  self.sendNotification("ARTICLE_MORE_DETAILS")
//                  handler.reply("TEXT", "Yes, sir!")
//                }
//              },
//            ],
            }
        },
//      {
//          module: 'MMM-PlexSlideshow',
//          position: 'fullscreen_below',
//          classes: 'scheduler',
//          config: {
//            plex: {
//              hostname:"10.0.1.51",
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
