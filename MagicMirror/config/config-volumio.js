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
        "10.0.1.44", // Mac Mini
        "10.0.1.51", // Mac Pro
        "10.0.1.82", // Mac Pro
        "10.0.1.67", // Raspberry Pi Ropieee
        "10.0.1.80", // Raspberry Pi Ropieee
        "10.0.1.86", // Raspberry Pi MagicMirror
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
                url: [ "http://10.0.1.80/playback" ],
                updateInterval: 30 * 60 * 1000, // rotate URLs every 30 minutes
                width: "1080", // width of iframe
                height: "1920", // height of iframe
                frameWidth: "1080"
            }
        },
        // {
        //     module: 'MMM-TelegramBot',
        //     config: {
        //       telegramAPIKey : 'xxxxxx_Your-Telegram-API-Key_xxxxxxxxxxxxxxxxx',
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
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
