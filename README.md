# [Local Windows Spotlight Grabber](https://github.com/zmweske/Local-Windows-Spotlight-Grabber)
This script copies the locally cached Windows 11 spotlight and lock screen images to a location where you can sort out and keep your favorites


## How to use
1. Download `pull.bat` or clone repository. Main script will now download `imgInfo.bat` if it is not found. 
2. Optional: Change setup location inside of `pull.bat` by editing line 8. Default is your `User\Pictures\` directory, and it should work even if you use OneDrive. Additionally, change the `LOCATION` variable which is by default set to `"Lock Screens\"`. This will set up everything in a "Lock Screens" folder in your user's Pictures directory. 
3. Run `pull.bat` from anywhere. ~~It will use the configured setup location. `imgInfo.bat` should be inside the setup `LOCATION` if you downloaded it manually. The script will try to move it into the `LOCATION` directory automatically.~~
4. Open the `dump\` folder and delete any advertisement/spam images that Windows downloaded and sort out favorite images. 
5. Remaining images inside `dump\`, `horizontal\`, `vertical\`, and `large\` can be deleted or moved. 
- It is recommended to `SHIFT + DELETE` unwanted images. It deletes them permanently and will reduce disk usage. 

## Recommended tips
- You can set your desktop background to shuffle through the `horizontal\` or `large\` folders, or move your favorites out and set the background to cycle through those instead. 
- Use the Windows run box (`Win+R`) to run the script (`"%USERPROFILE%\Pictures\Lock Screens\pull.bat"`) should work if you didn't change the default location.
- `large\` should be used if you have high resolution and/or vertical monitors for a better experience (instead of `horizontal\`

## Generated Files/Folders:
- `lock screens\` (or changed by updating the `LOCATION` variable)
the main program folder containing all processed images, files, and folders  

- `horizontal\` & `vertical\`
empty folders used to separate the 1920x1080 and 1080x1920 images  

- `large\`
empty folders use to store 4k (3840x2160) images

- `dump\`
where all of the processed images are placed, ready for manual sorting  

- `trash.txt`
a list of already processed images to reduce the likelihood of getting duplicates (still not impossible, check by sorting image directories by size)

- `temp\`
to be removed after operations, a temp to convert image files  


## Features/TODO
- [x] Automatically set up directory
- [x] Remove images that have been seen previously
- [x] Create custom setup location variable
- [x] Automatically remake and remove `temp\` before and after operations
- [x] Sort images by vertical vs horizontal
- [x] added Windows Desktop Spotlight copying functionality
- [x] support for sorting 4k images
- [x] automatically download imgInfo.bat if unable to find
- [x] works with OneDrive user directory structure
