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
                apiKey: 'MMM-Remote-Control_API_Key'
            }
        },
        {
            module: "MMM-COVID-19",
            header: "Coronavirus Daily Update",
            position: "bottom_bar",
            config: {
              debug:false,
//            scanInterval: 1000 * 60 * 60 * 3,
              scanInterval: 1000 * 60 * 60 * 12,
              rotateInterval: 1000 * 5, // 0 means no rotate
//            pinned: ["Mainland China", null],
//            pinned: ["Others", "Diamond Princess cruise ship"],
//            pinned: ["US", "Santa Clara, CA"],
              pinned: ["World", "US Total", "California, US"],
              myPosition: {
                  latitude: 36.970019,
                  longitude: -122.042212,
                  metric: "mile"
              },
              reportTimeFormat: "YYYY.MM.DD hh a",
              drawGraph: true,
              logTerritory: false
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
                        title: "Centers for Disease Control",
                        url: "https://tools.cdc.gov/api/v2/resources/media/403372.rss"
                    },
                    {
                        title: "Johns Hopkins Medicine",
                        url: "https://www.hopkinsmedicine.org/news/media/releases/?format=rss"
                    },
                    {
                        title: "World Health Organization",
                        url: "https://www.who.int/feeds/entity/csr/don/en/rss.xml"
                    },
                ],
                showSourceTitle: true,
                showPublishDate: true,
                broadcastNewsFeeds: true,
                broadcastNewsUpdates: true
            }
        },
        {
            module: "MMM-News",
            position: "top_center",
            config: {
              apiKey : "xxxxxxx_newsapi.org_xxxxxxxxxxx",
              type: "vertical",
              touchable: false,
              telegramBotOrderOpenDetail : true,
              query : [
                {
                  sources: "abc-news, bbc-news, cnn, google-news",
                },
                {
                  country: "us",
                  category: "general",
                },
                {
                  country: "uk",
                  category: "general",
                }
              ],
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
              recipes: [ "with-MMM-Hotword.js",
                         "with-MMM-TelegramBot.js",
                         "mirror-script.js",
                         "Reboot-Restart-Shutdown.js"],
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
              recipes: ["with-AMk2v3-noisy_smart-mirror.js"],
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
