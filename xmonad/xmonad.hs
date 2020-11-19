import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.GridSelect
import XMonad.Prompt.Shell
import qualified XMonad.StackSet as W
import System.IO
import Graphics.X11.ExtraTypes.XF86

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "XCalc"           --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isDialog --> doCenterFloat
    , className =? "skype"    --> doShift "2:im"
    , className =? "audacious"    --> doShift "2:im"
    , isFullscreen --> doFullFloat ]

myKeys = [
       ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((mod4Mask, xK_d), spawn "show_date.sh")
        , ((mod4Mask, xK_c), spawn "show_time.sh")
        , ((mod4Mask, xK_b), spawn "show_battery.sh")
        , ((mod4Mask .|. shiftMask, xK_e), spawn "emacs")
        , ((mod4Mask, xK_f), spawn "firefox")
        , ((mod4Mask, xK_o), spawn "okular")
        , ((mod4Mask, xK_s), spawn "skype")
        , ((0, xF86XK_MonBrightnessUp), spawn "/usr/bin/xbacklight -inc 10 & /usr/bin/notify-send \"Volume $(/usr/bin/xbacklight -get)\" -t 400")
        , ((0, xF86XK_MonBrightnessDown), spawn "/usr/bin/xbacklight -dec 10 & /usr/bin/notify-send \"Volume $(/usr/bin/xbacklight -get)\" -t 400")
        , ((0, xF86XK_AudioRaiseVolume), spawn "/usr/bin/pamixer --sink 0 -i 5 & /usr/bin/notify-send \"Volume $(/usr/bin/pamixer --sink 0 --get-volume-human)\" -t 400")
        , ((0, xF86XK_AudioLowerVolume), spawn "/usr/bin/pamixer --sink 0 -d 5 & /usr/bin/notify-send \"Volume $(/usr/bin/pamixer --sink 0 --get-volume-human)\" -t 400")
        , ((0, xF86XK_AudioMicMute), spawn "/usr/bin/pactl set-source-mute 1 toggle & /usr/bin/notify-send \"Mic Toggle\" -t 400")
        , ((0, xF86XK_AudioMute), spawn "/usr/bin/pamixer --sink 0 -t & /usr/bin/notify-send \"Mute $(/usr/bin/pamixer --sink 0 --get-mute)\" -t 400")
        , ((mod4Mask .|. shiftMask, xK_w), spawn "Telegram")
        , ((mod4Mask, xK_z), spawn "xlock")
        , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
        , ((mod4Mask, xK_t     ), withFocused $ windows . W.sink)
        -- , ((mod4Mask .|. controlMask, xK_x), shellPrompt def)
        , ((mod4Mask, xK_comma ), sendMessage (IncMasterN 1))
        , ((mod4Mask, xK_period), sendMessage (IncMasterN (-1)))
       ]

main = do
    xmproc <- spawnPipe "~/.cabal/bin/xmobar $HOME/.xmobarrc"
    xmonad $ ewmh defaultConfig
        { startupHook = setDefaultCursor xC_left_ptr
        , workspaces = ["1","2","3","4","5","6","7","8","9"]
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "st -e zsh -ls"
        } `additionalKeys`
        myKeys
