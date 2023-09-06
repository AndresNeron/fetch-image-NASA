# NASA Astronomy Picture of the Day Fetcher

NASA APOD

This script is designed to fetch the Astronomy Picture of the Day (APOD) from NASA's official website. 
It provides various functionalities for displaying and managing these captivating images for Linux systems, making it 
an excellent tool for space enthusiasts and wallpaper enthusiasts alike.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Usage](#usage)
- [Examples](#examples)
- [Installation](#installation)
- [License](#license)

## <a name="introduction"></a>Introduction
The NASA Astronomy Picture of the Day is a delightful source of astronomical images, 
videos, and descriptions, showcasing the beauty of the cosmos. This script allows 
you to interact with these images in various ways, from downloading and viewing them 
as a gallery to setting them as your desktop wallpaper.

## <a name="introduction"></a>Features
- Gallery Display: View NASA's APOD images as a gallery, either for a specific date or from a random selection of images.

- Download Images: Download APOD images in bulk for a specific year, providing a vast collection of captivating space visuals.

- Customize Path: Change the default path where downloaded images are stored.

- Desktop Wallpaper: Set your desktop wallpaper to the APOD image for a specific date or a randomized selection (tested on GNOME environment).

- Slideshow: Create a mesmerizing slideshow of APOD images, allowing you to set the duration for each image display.

- Firefox Integration: Quickly view the APOD image description in your default web browser using a simple switch.

## <a name="introduction"></a>Usage

To utilize this script, execute it in your terminal with various options to explore NASA's APOD collection and customize your experience:
```bash
./fetch-images-NASA.sh [options]
```

## <a name="introduction"></a>Options
Here are the available options for the script:
- -g: Get APOD dates in the format %y%m%d from a specific year.
- -d: Download APOD images from a specific year in bulk.
- -p: Change the default path where downloaded images are stored.
- -i: Open a specific APOD image.
- -b: Set your desktop background based on a specific date's APOD image.
- -y: Open a gallery of APOD images from a specific year in randomized mode.
- -w: Open a gallery of wallpaper candidates from all downloaded years in randomized mode.
- -a: Set all wallpaper candidates as your desktop background.
- -u: Set a randomized APOD image from a specific year as your desktop background.
- -s: Change the number of seconds for each image in the slideshow (default: 10 seconds).
- -f: Use Firefox to view the generated .html file.
- -h: Display the help message to understand the available options.


## <a name="introduction"></a>Examples
Here are some examples of how you can use the script:

- Get APOD dates for a specific year:

```bash
./fetch-images-NASA.sh -g 23
```

- Download APOD images for a specific year:

```bash
./fetch-images-NASA.sh -d 23
```

- Customize the download path and get APOD dates:

```bash
./fetch-images-NASA.sh -p ./new_path -g 22
```

- View APOD images from a specific year in a randomized gallery with a longer display time:

```bash
./fetch-images-NASA.sh -s 60 -y 23
```

- View the generated HTML file in Firefox with a longer display time for wallpaper candidates:

```bash
./fetch-images-NASA.sh -f -s 300 -w 23
```

## <a name="introduction"></a>Installation
To use this script, you need to clone the GitHub repository and execute the script from your terminal. No additional installation is required.

```bash
git clone https://github.com/AndresNeron/fetch-images-NASA.git
cd fetch-images-NASA
./fetch-images-NASA.sh [options]
```

## <a name="introduction"></a>License
This project is licensed under the MIT License, which means you are free to use, modify, 
and distribute the code according to the terms of the license. Enjoy exploring the cosmos through NASA's APOD! 🚀🌌📸
