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
    
    var captureController: Capture?
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func beginCapture(_ sender: Any) {
        
        self.captureController = Capture(delegate: self, documentType: .passport, withSelfie: true)
        let vc = captureController?.run()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.present(vc!, animated: true, completion: {})
        }
    }
    
    
    // MARK: CaptureDelegate
    
    
    func photoOut(capturedImage: UIImage?, currentStep: StepEnum) {
                
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
