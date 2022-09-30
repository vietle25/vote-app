# slife app


## Getting started

This is a file introducing this source code, environment, and how to install this source.

## Environment

This project is a flutter app
- [See how to install flutter, introducing flutter](https://flutter.dev/)

Version:
- Flutter 2.10.5 • channel stable • https://github.com/flutter/flutter.git
- Dart 2.16.2  null-safety

## Source structure

This source code use MVC architecture with model, controller, view. Structure and folder will devide follow:

📦lib                                    # Root folder of project code
┣ 📂assets                              # Contain  asset of project like images, font...
┃ ┣ 📂fonts
┃ ┃ ┣ 📜Roboto-Italic.ttf
┃ ┣ 📂images
┃ ┃ ┣ 📂2.0x
┃ ┃ ┃ ┣ 📜ic_ad_avatar.png
┃ ┃ ┣ 📂3.0x
┃ ┃ ┃ ┣ 📜ic_ad_avatar.png
┃ ┃ ┗ 📜splash_two.png
┣ 📂configs                             # Contain config file such as apiUrl, define error code
┃ ┗ 📜server.dart
┣ 📂controllers                         # Controllers of screen, each screen will be have each controller
┃ ┣ 📜base_controller.dart              # Base controller for project, include general function, variable
┃ ┣ 📜home_controller.dart              # Home controller for home view, home controller must be extended from base controller
┣ 📂enums                               # Contain enumerations such as language type, login type...
┃ ┣ 📜language.dart
┣ 📂locales                             # Define languge string used in app
┃ ┣ 📜i18n_vi.dart
┣ 📂models                              # Contain models, object in app,  divide subdirectories by objects
┃ ┣ 📂country
┃ ┃ ┣ 📜country_model.dart              # Model of object country
┃ ┃ ┗ 📜country_model.g.dart            # Auto generate, include fromJson, toJson function for country models
┣ 📂repositories                        # define all API call
┃ ┗ 📜user_repository.dart
┣ 📂router                              # Include all screen of app
┃ ┗ 📜router_config.dart
┣ 📂services                            # Include services, be run independently such as location, connectivity...
┃ ┗ 📜location_service.dart
┣ 📂styles                              # General style use in project, can use any view
┃ ┗ 📜common_style.dart
┣ 📂utils                               # Define utils function
┃ ┣ 📜string_util.dart
┣ 📂values                              # Include contain value use in app such as color, margin, padding...
┃ ┣ 📜colors.dart
┣ 📂views                               # Include view, will display on app,  divide subdirectories by function
┃ ┣ 📂base
┃ ┃ ┗ 📜base_view.dart
┃ ┣ 📂note
┃ ┃ ┣ 📂detail
┃ ┃ ┃ ┣ 📜note_detail_view.dart
┃ ┃ ┗ 📂list
┃ ┃ ┃ ┣ 📜item_note.dart
┃ ┃ ┃ ┗ 📜note_list_view.dart
┣ 📂widgets                             # General widget  
┃ ┣ 📜button_widget.dart
┗ 📜main.dart                           # main file start of app
## Dependencies
All dependencies will define on file pubspec.yaml. Some important dependencies are frameworks for source code such as:
- get: we use getX for project by easy to use, clean architecture, more utils.
- chopper: use do RestAPI call.
- json_serializable: auto generate toJson, fromJson

## Run

```
flutter pub get
flutter packages pub run build_runner watch
flutter run
```
To update or create splash
```
flutter pub run flutter_native_splash:create
```

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!).  Thank you to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
