/** addons.js **/
/** Allow to create personal addon on node_helper **/
/** (with external source) **/
/** /!\ Think to backup your file before update ! **/
/** @bugsounet **/
const AddAddonRecipe = require("../components/addAddonRecipe.js")


var _log = function() {
    var context = "[AMK2:ADDONS]"
    return Function.prototype.bind.call(console.log, console, context)
}()

var log = function() {
  //do nothing
}

var addonsConfig = {
  // /!\ do not remove TAG_AUTOINSERTCONFIG !
  briefToday: {
    useBriefToday: true,
    welcome: "Welcome to the Magic Mirror of Doctor When"
  },
  snowboy: {
    useSnowboy: true,
    audioGain: 2.0,
    applyFrontend: true,
    applyModel: "smart_mirror",
  },

  //_TAG_AUTOINSERTCONFIG_


  test: {
    useTest: true,
    messageConsole: "Hi there ! this is a test addon for show your configs !"
  },
};

class ADDONS {
  constructor(config) {
    this.config= config
    var debug = (this.config.debug) ? this.config.debug : false
    if (debug == true) log = _log
    this.debug = debug
    this.addonsConfig = addonsConfig
    this.addRecipe = new AddAddonRecipe(this.config)
  }
  doAddons (notification,payload,callback = () => {}){
    // /!\ do not remove TAG_AUTOINSERTADDONS !
    //briefToday addon
    if (notification == "INIT") {
      if (!this.addonsConfig.briefToday.useBriefToday) log("briefToday is disabled")
      else if (this.addRecipe.add("briefToday/with-briefToday.js", "briefToday", callback)) {
        callback("BRIEF_SEND", this.addonsConfig.briefToday.welcome)
      }
    }


    // test_plugin
    if (notification == "INIT") log("Test_plugin is " + (this.addonsConfig.test.useTest ? "enabled" : "disabled"))
    if (notification == "INIT" && this.addonsConfig.test.useTest) {
      console.log("[AMK2:ADDONS]", this.addonsConfig.test.messageConsole)
      //console.log("[AMK2:ADDONS] AMk2 Config:", this.config)
      console.log("[AMK2:ADDONS] addonsConfig:", this.addonsConfig)
      // for send socket notification "HELLO" and payload "TEST" for recipe instructions receive
      //callback("HELLO","TEST")
    }
  }
}

module.exports = ADDONS
