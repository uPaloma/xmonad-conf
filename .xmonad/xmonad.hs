import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- NOTES: 0.10 works much better than 0.9, unfortunately distros mostly package 0.9 atm
-- xmobar and fullscreen flash vids (youtube): http://code.google.com/p/xmobar/issues/detail?id=41

-- TODO: would still like fullscreen flash vids to not crop and leave xmobar drawn
-- TODO: remove the red border when doing fullscreen? tried adding 'smartBorders' to the layoutHook but that didn't work
-- TODO: hook in TopicSpaces, start specific apps on specific workspaces


  
main :: IO ()
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/paloma/.xmobarrc"
  xmonad $ defaultConfig {
    modMask = mod4Mask, 
    terminal = "alacritty",
-- if you are using xmonad 0.9, you can avoid web flash videos getting cropped in fullscreen like so:
-- manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> manageHook defaultConfig,
-- (no longer needed in 0.10)
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc,
                          ppTitle = xmobarColor "green" "" . shorten 50
                        }
  } `additionalKeys`
   [((mod4Mask, xK_q), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
   ,((mod4Mask, xK_e), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
   ,((mod4Mask, xK_m), spawn "xrandr --output eDP1 --brightness 1.0")
   ,((mod4Mask, xK_n), spawn "xrandr --output eDP1 --brightness 0.3")
   ]

   --Custom Keybindings for Volume
   --Custom Keybinginds for Brightness

 
