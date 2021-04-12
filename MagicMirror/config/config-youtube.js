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
    address: "0.0.0.0",
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
    //  "::ffff:10.0.1.0/26",
    //  "::ffff:10.0.1.64/27",
    //  "::ffff:10.0.1.96/30"
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
            module: "MMM-YouTube",
            position: "top_center",
            config: {
              verbose:true,
              defaultQuality: "default",
              width: "1024px",
              height: "800px",
              volume: 100,
              disableCC: true,
              showPlayingOnly: true,
              defaultLoop: false,
              defaultShuffle: false,
              defaultAutoplay: true,
//            onStartPlay: null,
              onStartPlay: {
//              type: "id",
                type: "playlist",
//              Cake
//              id: "PL575DFB88A40C099F",
//              Harry Nilsson
                id: "PLh3A0cnoWYsytqDvDHE5S_RXVFPAqZXIy",
//              ZHU
//              id: "PLh3A0cnoWYsyGnl2aSitB1RBG7TGI94Su",
//              Muse
//              id: "PL48ED85D54606D0B8",
                shuffle: true,
                loop: true,
                autoplay: true,
              },
              playerVars: {
                controls: 0,
                hl: "en",
                enablejsapi: 1,
                showinfo: 1,
                rel: 0,
                cc_load_policy: 0,
              },
              telegramBotCommand: {
                YOUTUBE_LOAD_BY_URL: "yt",
                YOUTUBE_CONTROL: "yc"
              },
              outNotifications: {
                "-1": "UNSTARTED",
                "0": "ENDED",
                "1": "PLAYING",
                "2": "PAUSED",
                "3": "BUFFERING",
                "5": "VIDEO CUED",
              }
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
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
