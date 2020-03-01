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
        },
        {
            module: 'MMM-ModuleScheduler',
            config: {
                // SHOW ALL MODULES AT FULL BRIGHTNESS AT 06:00 AND DIM THEM TO 20% AT 22:00
                // global_schedule: {from: '0 6 * * *', to: '0 22 * * *', dimLevel: '20' },
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
            module: 'MMM-BackgroundSlideshow',
            position: 'fullscreen_below',
            // classes: 'scheduler',
            config: {
                imagePaths: [
                    'modules/MMM-BackgroundSlideshow/gif/Nature/',
                ],
                slideshowSpeed: 15000, // 15 seconds
                transitionImages: true,
                randomizeImageOrder: true,
                recursiveSubDirectories: true,
                //backgroundSize: "contain",
                // DISPLAY THE SLIDE SHOW BETWEEN 1PM and 6PM then again between 9PM and Midnight
                //module_schedule: [
                //  {from: '0 13 * * *', to:   '0 18 * * *'},
                //  {from: '0 21 * * *', to:   '59 23 * * *'}
                //]
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
	]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
