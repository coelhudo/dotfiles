import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar


import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeys)

import XMonad.Actions.GridSelect
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W

import System.IO
import Graphics.X11.ExtraTypes.XF86

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "firefox"      --> doFloat
    , className =? "XCalc"           --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isDialog --> doCenterFloat
    , isFullscreen --> doFullFloat ]

myKeys = [
       ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; maim -s | xclip -selection clipboard -t image/png")
        , ((mod4Mask, xK_d), spawn "show_date.sh")
        , ((mod4Mask, xK_c), spawn "show_time.sh")
        , ((mod4Mask, xK_p), spawn "rofi -show run")
        , ((mod4Mask, xK_b), spawn "show_battery.sh")
        , ((mod4Mask .|. shiftMask, xK_e), spawn "emacs")
        , ((mod4Mask, xK_f), spawn "firefox")
        , ((mod4Mask, xK_o), spawn "okular")
        , ((mod4Mask, xK_s), spawn "skype")
        , ((mod4Mask .|. shiftMask, xK_b), sendMessage ToggleStruts)
        , ((0, xF86XK_MonBrightnessUp), spawn "/usr/bin/xbacklight -inc 10 & /usr/bin/notify-send \"$(/usr/bin/xbacklight -get)\" -t 400")
        , ((0, xF86XK_MonBrightnessDown), spawn "/usr/bin/xbacklight -dec 10 & /usr/bin/notify-send \"$(/usr/bin/xbacklight -get)\" -t 400")
        , ((0, xF86XK_AudioRaiseVolume), spawn "/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') -i 5 & /usr/bin/notify-send \"Volume $(/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') --get-volume-human)\" -t 400")
        , ((0, xF86XK_AudioLowerVolume), spawn "/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') -d 5 & /usr/bin/notify-send \"Volume $(/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') --get-volume-human)\" -t 400")
        , ((0, xF86XK_AudioMicMute), spawn "/usr/bin/pactl set-source-mute 1 toggle & /usr/bin/notify-send \"Mic Toggle\" -t 400")
        , ((0, xF86XK_AudioMute), spawn "/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') -t & /usr/bin/notify-send \"Mute $(/usr/bin/pamixer --sink $(/usr/bin/pamixer --list-sinks | grep analog | awk '{print $1}') --get-mute)\" -t 400")
        , ((mod4Mask .|. shiftMask, xK_w), spawn "Telegram")
        , ((mod4Mask, xK_z), spawn "xlock")
        , ((mod4Mask, xK_g), goToSelected def)
        , ((mod4Mask, xK_t     ), withFocused $ windows . W.sink)
        -- , ((mod4Mask .|. controlMask, xK_x), shellPrompt def)
        , ((mod4Mask, xK_comma ), sendMessage (IncMasterN 1))
        , ((mod4Mask, xK_period), sendMessage (IncMasterN (-1)))
       ]


main :: IO()
main = do
  xmproc <- spawnPipe "~/.local/bin/xmobar $HOME/.xmobarrc"
  xmonad
    . ewmh
    . docks
    . ewmhFullscreen
    . ewmh
    $ def
        { startupHook = setDefaultCursor xC_left_ptr >> setWMName "LG3D"
        , workspaces = ["1:<fn=3>\xe007</fn>",
                        "2:<fn=3>\xf2c6</fn>",
                        "3:<fn=2>\xf1c9</fn>",
                        "4:<fn=2>\xf120</fn>",
                        "5:<fn=3>\xf1bc</fn>",
                        "6",
                        "7",
                        "8",
                        "9"]
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook def
        , layoutHook = smartBorders . avoidStruts  $  layoutHook def
        , borderWidth = 1
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "urxvt"
        } `additionalKeys`
        myKeys

-- myXmobarPP :: PP
-- myXmobarPP = def
--              { ppSep             = magenta " • "
--              , ppTitleSanitize   = xmobarStrip
--              , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
--              , ppHidden          = white . wrap " " ""
--              , ppHiddenNoWindows = lowWhite . wrap " " ""
--              , ppUrgent          = red . wrap (yellow "!") (yellow "!")
--              , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
--              }
--   where
--     formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
--     formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

--     -- | Windows should have *some* title, which should not not exceed a
--     -- sane length.
--     ppWindow :: String -> String
--     ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

--     blue, lowWhite, magenta, red, white, yellow :: String -> String
--     magenta  = xmobarColor "#ff79c6" ""
--     blue     = xmobarColor "#bd93f9" ""
--     white    = xmobarColor "#f8f8f2" ""
--     yellow   = xmobarColor "#f1fa8c" ""
--     red      = xmobarColor "#ff5555" ""
--     lowWhite = xmobarColor "#bbbbbb" ""
