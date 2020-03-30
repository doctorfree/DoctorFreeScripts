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
                apiKey: 'MMM-Remote-Control_API_Key'
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
//      {
//          module: 'MMM-SmartWebDisplay',
//          position: 'lower_third',    // This can be any of the regions.
//          config: {
//              //Set to true to get detailed debug logs. To see them : "Ctrl+Shift+i"
//              logDebug: false,
//              height:"100%", //hauteur du cadre en pixel ou %
//              width:"100%", //largeur
//              updateInterval: 0, //in min. Set it to 0 for no refresh (for videos)
//              //In min, set it to 0 not to have automatic URL change.
//              //If only 1 URL given, it will be updated
//              NextURLInterval: 0.5,
//              displayLastUpdate: true, //to display the last update of the URL
//              displayLastUpdateFormat: 'ddd - HH:mm:ss', //format of the date and time to display
//              url: [
//                    "https://en.wikipedia.org/wiki/Harry_Nilsson",
//                    "https://en.wikipedia.org/wiki/Harry_Nilsson#Early_life",
//                    "https://en.wikipedia.org/wiki/Harry_Nilsson_discography#Studio_albums",
//                   ],
//              scrolling: "no", // allow scrolling or not. html 4 only
//              //delay in miliseconds to video shut-off while using together with MMM-PIR-Sensor
//              shutoffDelay: 10000
//          }
//      },
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
                         "with-MMM-Youtube.js",
                         "mirror-script.js",
                         "Reboot-Restart-Shutdown.js"],
              profiles: {
                "default": {
                  profileFile: "default.json",
                  lang: "en-US"
                }
              },
              addons: false,
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
