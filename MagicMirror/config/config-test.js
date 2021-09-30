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
        "10.0.1.67", // Raspberry Pi MagicMirror
        "10.0.1.80", // Raspberry Pi MagicMirror
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
        // {
        //     module: "MMM-Coinbase-Pro",
        //     position: "middle_center",
        //     header: "Coinbase Pro", // optional
        //         config: {
        //             apiKey: "0844c1b293b7ab2fed5c96a7556b2146",
        //             apiSecret: "Qrpnrl/8HOL6q9MZl7wWzVPm8yS2jj5zu9zpI+ocNcdpuv7qwi4sbLu+tmB0OyrrpYJSXRsXvlEDbVaEiO5g3g==",
        //             wallet: ["FIL", "ZRX"], // list of currencies to display
        //             icons: false, // currently only Ethereum and Bitcoin supported
        //             label: true,  // shows currency labels (e.g. BTC, ETH and so on)
        //         }
        // },
    ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
