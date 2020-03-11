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
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
