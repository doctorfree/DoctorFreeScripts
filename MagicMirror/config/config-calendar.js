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
            module: "clock",
			position: "bottom_center",
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
			position: "fullscreen_below",
			config: {
                colored: true,
                maximumNumberOfDays: 28,
                maximumEntries: 100,
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
						url: "http://localhost:8080/modules/default/calendar/calendars/home.ics"
                    },
					{
						symbol: "calendar",
                        color: '#BAA3DC',
						url: "http://localhost:8080/modules/default/calendar/calendars/14D7ECFB-D078-4696-9558-E422AE330A63.ics"
                    },
//					{
//						symbol: "calendar",
//                       color: '#33FFFA',
//						url: "http://localhost:8080/modules/default/calendar/calendars/W14D7ECFB-D078-4696-9558-E422AE330A63.ics"
//                   }
				]
			}
		},
		{
			module: "currentweather",
			position: "bottom_left",
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
			position: "bottom_right",
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
        // {
        //     module: 'MMM-TelegramBot',
        //     config: {
        //       telegramAPIKey : 'xxxxxx_Your-Telegram-API-Key_xxxxxxxxxxxxxxxxx',
              // This is NOT the username of bot.
        //       allowedUser : ['Your-Telegram-Username'],
        //       adminChatId : Your-Telegram-Chat-ID,
        //       useWelcomeMessage: true,
        //       verbose: false,
        //       favourites:["/hideall", "/showall", "/screenshot", "/shutdown"],
        //       screenshotScript: "scrot",
        //       detailOption: {},
        //       customCommands: [],
        //     }
        // },
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
