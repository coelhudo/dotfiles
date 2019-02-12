import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.GridSelect
import qualified XMonad.StackSet as W
import System.IO

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
        , ((mod4Mask, xK_a), spawn "showdate.sh")
        , ((mod4Mask, xK_b), spawn "showtime.sh")
        , ((mod4Mask, xK_e), spawn "emacs")
        , ((mod4Mask, xK_f), spawn "firefox")
        , ((mod4Mask, xK_o), spawn "okular")
        , ((mod4Mask, xK_s), spawn "skype")
        , ((mod4Mask, xK_t), spawn "Telegram")
        , ((mod4Mask, xK_z), spawn "xlock")
        , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
        , ((mod4Mask, xK_h), sendMessage Shrink)
        , ((mod4Mask, xK_l), sendMessage Expand)
        , ((mod4Mask, xK_t     ), withFocused $ windows . W.sink)
        , ((mod4Mask, xK_comma ), sendMessage (IncMasterN 1))
        , ((mod4Mask, xK_period), sendMessage (IncMasterN (-1)))
       ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.xmobarrc"
    xmonad $ ewmh defaultConfig
        { startupHook = setDefaultCursor xC_left_ptr
        , workspaces = ["1","2","3","4","5","6","7","8","9","0","-","="]
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "st"
        } `additionalKeys`
        myKeys
