/**   Execute my mirror script  **/
/**   Vocal commands script              **/
/**   set partern in your language       **/
/**   @ronrecord                         **/

var recipe = {
  transcriptionHooks: {
    "AMK2_MIRROR_DEFAULT": {
      pattern: "mirror default",
      command: "AMK2_MIRROR_DEFAULT"
    },
    "AMK2_MIRROR_BLANK": {
      pattern: "mirror blank",
      command: "AMK2_MIRROR_BLANK"
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
    "AMK2_MIRROR_BLANK": {
      soundExec: {
        chime: "close",
      },
      shellExec: {
        exec: "/usr/local/bin/mirror blank"
      } 
    },
  }
}

exports.recipe = recipe // Don't remove this line.
