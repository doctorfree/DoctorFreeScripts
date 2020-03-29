/**   Execute my mirror script  **/
/**   Vocal commands script              **/
/**   set pattern in your language       **/
/**   @ronrecord                         **/

var recipe = {
  transcriptionHooks: {
    "AMK2_MIRROR_DEFAULT": {
      pattern: "show default please",
      command: "AMK2_MIRROR_DEFAULT"
    },
    "AMK2_MIRROR_ALL": {
      pattern: "show all please",
      command: "AMK2_MIRROR_ALL"
    },
    "AMK2_MIRROR_ANIME": {
      pattern: "show anime please",
      command: "AMK2_MIRROR_ANIME"
    },
    "AMK2_MIRROR_BEACH": {
      pattern: "show beach please",
      command: "AMK2_MIRROR_BEACH"
    },
    "AMK2_MIRROR_BLANK": {
      pattern: "show blank please",
      command: "AMK2_MIRROR_BLANK"
    },
    "AMK2_SCREEN_ON": {
      pattern: "screen on",
      command: "AMK2_SCREEN_ON"
    },
    "AMK2_SCREEN_OFF": {
      pattern: "screen off",
      command: "AMK2_SCREEN_OFF"
    },
  },
  
  commands: {
    "AMK2_MIRROR_DEFAULT": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror default"
      } 
    },
    "AMK2_MIRROR_ALL": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror all"
      } 
    },
    "AMK2_MIRROR_ANIME": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror anime"
      } 
    },
    "AMK2_MIRROR_BEACH": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror beach"
      } 
    },
    "AMK2_MIRROR_BLANK": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror blank"
      } 
    },
    "AMK2_SCREEN_ON": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror screen on"
      } 
    },
    "AMK2_SCREEN_OFF": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror screen off"
      } 
    },
  }
}

exports.recipe = recipe // Don't remove this line.

all
anime
beach
boobs
calendar
celebrity
choker
coronavirus
crypto
euro
fictional
fractals
horse
iframe
moon
nature
news
nuts
owls
portal
sakimichan
smoke
sol
spread
stocks
test
tuigirl
water
weather
