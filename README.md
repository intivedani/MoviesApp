# Daniela's BrightScript Channel - MoviesApp

Welcome to the repository for Daniela's project in the Roku Channel Development. 

MovieApp is a Roku application developed with BrightScript and SceneGraph. This app allows users to explore movies by genre and view details of each movie using The Movie Database (TMDb) API. 
[TMDb API documentation](https://developers.themoviedb.org/3/getting-started/introduction)
The application is designed for Full HD resolution.

## Features

- Configurable Design: JSON configuration for easy design updates.
- Home Screen: Main screen with a filter to select movie genres.
- RowList: List of movies by genre.
- Detail Screen: Detailed view with information about the selected movie.

## Requirements

1. Clone the repository
2. Sign up on The Movie Database and obtain an API Key  
3. In the config.json set it. apiKey = "YOUR_API_KEY"

## Deploy to your Roku device:

Package and deploy the application to your Roku device using the [Development Application Installer.](https://developer.roku.com/es-co/docs/developer-program/getting-started/developer-setup.md)

## Project Structure

MovieApp/
│
├── images/                 # Directory for app images
├── components/             # Custom SceneGraph components
│   │   ├── config/         # Configuration files in JSON format and config file (for the API Key)
│   │   ├── fonts/          # Fonts used in the application
│   │   ├── navigation/     # Navigation logic
│   │   ├── tasks/          # Tasks for data fetching and other operations
│   │   ├── views/          # Views for different screens
│   │   │   ├── HomeScene.brs   # Logic for the home screen
│   │   │   ├── DetailScene.brs # Logic for the detail screen
│   │   │   ├── HomeScene.xml   # UI for the home screen
│   │   │   └── DetailScene.xml # UI for the detail screen
│   │   ├── widgets/        # Custom components
│   ├── source/                 # Main directory for source code
│   │   ├── Main.brs            # Entry point of the application
│   │   ├── Utils.brs           # File to use utilities for brightscript  methods
│   └── manifest            # Application manifest file

├── README.md               # This file
└── .gitignore              # Files and directories to be ignored by git

## Usage

1. Browse Movies:

- On the main screen, select a genre to view the available movies.
- Navigate through the list of movies using the Roku remote.

2. View Movie Details:

- Select a movie from the list to go to the detail screen.
- You will see detailed information about the selected movie.

## Additional Resources

- [Official BrightScript Documentation](https://developer.roku.com/en-gb/docs/references/brightscript/)

## Contact

For any questions or suggestions, please project author. Daniela Prieto - tkdanip77@gmail.com

