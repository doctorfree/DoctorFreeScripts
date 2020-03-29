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
		    module: "MMM-DateOnly",
		    position: "top_bar",
		    config: {
                showWeek: false,
                dateFormat: "dddd, LLL",
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
            module: "MMM-News",
            position: "top_bar",
            config: {
              apiKey : "xxxxxxx_newsapi.org_xxxxxxxxxxx",
              type: "horizontal",
              touchable: false,
              telegramBotOrderOpenDetail : true,
              query : [
                {
                  sources: "abc-news, bbc-news, cnn, google-news",
                },
                {
                  country: "us",
                  category: "business",
                },
                {
                  country: "uk",
                  category: "business",
                }
              ],
            }
        },
        {
            module: 'MMM-stocks',
            position: 'bottom_bar',
            config: {
              apiKey: 'xxxxx_Weather-API-Key_xxxxxxxxxxxxx',
              crypto: 'BATUSDT,ADAUSDT,ETHUSDT,POLYBNB,ZRXUSDT,MCOUSDT', // crypto symbols
              separator: '&nbsp;&nbsp;•&nbsp;&nbsp;', // separator between stocks
              stocks: 'CGC,AAPL,HEXO,ACB,TLRY', // stock symbols
              updateInterval: 1000000 // update interval in milliseconds (16:40)
            }
        },
        {
            module: "MMM-AVStock",
            position: "upper_third", //"bottom_bar" is better for `mode:ticker`
            config: {
                apiKey : "xx_AVStock-API_x", // https://www.alphavantage.co/
                timeFormat: "YYYY-MM-DD HH:mm:ss",
                symbols : ["AAPL", "HEXO", "TLRY", "CGC", "ACB"],
                alias: ["Apple", "Hexo", "Tilray", "Canopy", "Aurora"],
                tickerDuration: 60, // Ticker will be cycled once per this second.
                chartDays: 90, //For `mode:series`, how much daily data will be taken. (max. 90)
                poolInterval : 1000*15, // (Changed in ver 1.1.0) - Only For Premium Account
                mode : "series", // "table", "ticker", "series"
                decimals: 4,
                candleSticks : true, //show candle sticks if mode is Series
                coloredCandles : true, //colored bars: red and green for negative and positive candles
                premiumAccount: false,
            }
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
