# Berlin Skylarks
iOS/macOS/watchOS App for the Berlin Skylarks Baseball &amp; Softball Club, built in Swift.

Intended Features:

* Display team scores via BSM API
* Display news from https://www.tib-baseball.de
* Display player profiles from https://www.tib-baseball.de
* Display standings via BSM API
* Home dashboard to display all information on your favorite team at a glance

Play Ball! ⚾️🥎

Note: The app requires a BSM API key to function which is not shipped in the public code (documentation: https://bsm.baseball-softball.de/api_docs). Please get in touch for information on how to acquire one (although I would assume that if you are interested in German baseball/softball, you would know where to get one).

Contact info: app@tib-baseball.de

---

## API Integration

- **BSM API**: Used for live scores and standings.
- **TIB Website**: Used for news and player profiles.
- All network requests are handled asynchronously using Swift's `URLSession`.

## Development History

- Started as a learning project into Programming in general as a complete beginner - therefore very different standards of code quality present.

## Roadmap

- Mostly feature complete and not under active development at the moment, maintenance releases for new iOS versions.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## Usage with IDEs other than Xcode

- Install [Xcode Build Server](https://github.com/SolaWing/xcode-build-server)
- Run the following command in project root:

    ```shell
    xcode-build-server config -project *.xcodeproj
    ```

---

## License

This project is licensed under the GPL License. See [LICENSE](LICENSE) for details.
