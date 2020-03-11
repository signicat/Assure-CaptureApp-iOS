# Assure-CaptureApp-iOS
Library to help capture photos of documents and Selfies

## Requirements

- iOS 11.0+ 
- Swift 4.2+


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Assure-CaptureApp-iOS into your Xcode project using CocoaPods, specify it in your `Podfile` and also defines our private PodSpecs:

```ruby
source 'https://github.com/signicat/Assure-PodSpecs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Assure-CaptureApp-iOS', '~> 1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```


## Usage

### Quick Start

```swift
import UIKit
import CaptureApp_iOS

class ViewController: UIViewController, CaptureDelegate {
    
    var captureController: CaptureApp?
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func beginCapture(_ sender: Any) {
        
        self.captureController = Capture(delegate: self, documentType: .passport, withSelfie: true)
        let vc = captureController?.run()
        self.present(vc!, animated: true, completion: {})
    }
    
    
    // MARK: CaptureDelegate
    
    
    func photoOut(capturedImage: UIImage?, currentStep: CaptureStepEnum) {
                
        switch currentStep {
        case .front:
            self.documentImageView.image = capturedImage
            self.documentImageView.backgroundColor = UIColor.white
        case .selfie:
            self.selfieImageView.image = capturedImage
            self.selfieImageView.backgroundColor = UIColor.white
        default:
            break
        }
        
        if(self.captureController?.nextStep() == .end) {
            print("Finish")
        }
    }
    
    
    func responseError(error: CaptureErrorEnum) {
     
        print(error)
    }
    
}
```


## Customization

You have the possibility to configure some design aspects of the CaptureApp.

- primaryColor: [UIColor] 
       You can define just one color or define an array to have gradient.
- cancelColor: [UIColor]
       You can define just one color or define an array to have gradient.
- fontName: String
       If you want to replace the default font.

```swift
...

class ViewController: UIViewController, CaptureDelegate {
    
    ...
    
    @IBAction func beginCapture(_ sender: Any) {
        
        ...
        // Customization CaptureApp
        var customization = CaptureCustomization()
        customization.primaryColor = [UIColor(red: 255/255, green: 1/255, blue: 2/255, alpha: 1), UIColor(red: 1, green: 40/255, blue: 201/255, alpha: 1)]
        customization.cancelColor = [UIColor(red: 1/255, green: 66/255, blue: 132/255, alpha: 1), UIColor(red: 1, green: 40/255, blue: 201/255, alpha: 1), UIColor(red: 233, green: 40/255, blue: 77/255, alpha: 1)]
        customization.fontName = "Papyrus"
        self.captureController?.customizations(customization)
        
        let vc = captureController?.run()
        ...
    }
