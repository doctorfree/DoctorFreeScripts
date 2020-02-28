/* Magic Mirror Config
 *
 * By Michael Teeuw http://michaelteeuw.nl
 * Modified by Ronald Joe Record http://ronrecord.com
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
        //      apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        //  }
        },
        {
            module: "clock",
			position: "top_center",
            config: {
                dateFormat: "dddd, LLL",
                displayType: "analog",
                analogFace: "face-009",
                analogSize: "200px",
                displaySeconds: true,
                secondsColor: "#BAA3DC",
                timeFormat: "12",
                showPeriod: true,
                showDate: true,
                clockBold: false,
                analogPlacement: "top",
                analogShowDate: "top",
            }
        },
		{
            module: "MMM-DarkSkyForecast",
            header: "Dark Sky Weather Forecast",
            position: "top_center",
            classes: "default everyone",
            disabled: false,
            config: {
              apikey: "c4aaf67ae4c33e63c7630ceeb2b45ee5",
		      latitude: "36.970019",
		      longitude: "-122.042212",
              iconset: "5c",
              concise: false,
			  units: "us",
              forecastLayout: "tiled"
            }
         },
         {
             module: 'MMM-RAIN-RADAR',
             position: 'top_center',
             disabled: false,
             config: {
                 useHeader: false, // true if you want a header
                 lat: "36.970019",
                 lon: "-122.042212",
                 area: 'CA', // US State
                 zoomLevel: 8,
                 mapType: 1, //0-Road Map 1-Satellite 2-Dark Map 3-OpenStreetMaps 4-Light Map
                 color: 3, //0-Original 1-Universal Blue 2-TITAN 3-The Weather Channel
                           //5-NEXRAD Level-III 6-RAINBOW @ SELEX-SI
                 snow: 1,
                 smoothing: 1,
                 opacity: 88,
                 fastAnimation: 0,
                 coverage: 0,
                 darkTheme: 1,
                 UTCtime: 0,
                 legend: 1,
                 legendMin: 0, //set legend to 1 if you want legendMin to show
                 animate: 1,
                 // 1: after updateInterval, weather warnings for your US states will be used
                 // to determine if module should be hidden. 0 module is perpertually displayed
                 updateOnWarning: 1,
                 // number of milliseconds. change 5 to 60 and it will update each 10 minutes
                 updateInterval: 60 * 60 * 1000,
             }
         },
         {
            module: 'MMM-TelegramBot',
            config: {
              telegramAPIKey : 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
              // This is NOT the username of bot.
              allowedUser : ['xxxxxxxxx'],
              adminChatId : xxxxxxxxxx,
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
//		{
//		    module: "weather",
//			position: "top_left",
//		    config: {
//			    type: 'current',
//				degreeLabel: true,
//				showHumidity: true,
//				location: "Santa Cruz",
//				locationID: "5393052",
 //               units: "imperial",
//				apiKey: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
//		    }
//		},
//		{
//		    module: "weather",
//			position: "top_right",
//		    config: {
//			    type: 'forecast',
//				tableClass: 'medium',
//				colored: true,
//				showPrecipitationAmount: true,
//				degreeLabel: true,
//				location: "Santa Cruz",
//				locationID: "5393052",
 //               units: "imperial",
//				apiKey: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
//		    }
//		},
//		{
//			module: "currentweather",
//			position: "top_left",
//			config: {
//				showHumidity: true,
//				location: "Santa Cruz",
//				locationID: "5393052",
 //               units: "imperial",
//				appid: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
//			}
//		},
//		{
//			module: "weatherforecast",
//			position: "top_right",
//			header: "Weather Forecast",
//			config: {
//				showRainAmount: true,
//				tableClass: 'medium',
//				location: "Santa Cruz",
//				locationID: "5393052",
 //               units: "imperial",
  //              colored: true,
   //             scale: true,
	//			appid: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	//		}
	//	},
//       {
//           module: "MMM-DarkSkyRadar",
//           position: "lower_third",
//           header: "Radar",
//           config: {
//         lat: "36.970019",
//         lon: "-122.042212",
//               height: "600px",  //optional default
//               width: "350px",   //optional default
//               zoomLevel: 9,     //optional default (the larger the more zoomed in)
//               updateInterval: 15 * 60 * 1000,  //optional default (15 minutes)
//           }
//       },
	]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
