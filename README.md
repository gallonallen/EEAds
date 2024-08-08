Here is a README for the EEAds repository based on the available information:

---

# EEAds

EEAds allows you to display your own ads in your iOS app. This repository includes the necessary files and instructions to integrate custom ads seamlessly into your app.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gallonallen/EEAds.git
   ```
2. **Add the files to your Xcode project:**
   - Include `EEAdBannerView.h` and `EEAdBannerView.m` in your project.
   - Add the `ad_images` folder to your project resources.

## Usage

1. **Import the header file:**
   ```objective-c
   #import "EEAdBannerView.h"
   ```
2. **Initialize and configure the ad banner:**
   ```objective-c
   EEAdBannerView *adBanner = [[EEAdBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
   adBanner.adImageNames = @[@"ad1.png", @"ad2.png"];
   [self.view addSubview:adBanner];
   [adBanner startDisplayingAds];
   ```

## Configuration

- **`EEAdBanners.plist`:** Configure your ad images and settings.
- **Ad images:** Place your ad images in the `ad_images` folder and update the `adImageNames` array in your code.

## Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Open a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Additional Information

For detailed class reference, see `EEAdBannerView Class Reference.pdf`.

---

Feel free to customize the README further based on specific details or preferences.
