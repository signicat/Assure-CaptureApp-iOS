import XCTest
import CaptureApp_iOS


class Tests: XCTestCase {
    
    var viewController: ViewControllerMock!
    
    override func setUp() {
        
        self.viewController = ViewControllerMock()
        _ = viewController.view
        super.setUp()
    }
    
    override func tearDown() {
        
        viewController.tearDown()
        super.tearDown()
    }
    
    
    func testCaptureInitAndRun() {
        
        let capture = CaptureApp(delegate: viewController, documentType: .drivingLicence, withSelfie: true)
        let vc = capture.run()
        
        XCTAssertNotNil(vc)
        XCTAssertTrue(type(of: vc) == UINavigationController.self)
    }
    
    
    func testCaptureInitWithCustomSteps() {
        
        let listSteps: [CaptureStepEnum] = [.selfie, .back, .front]
        let capture = CaptureApp(delegate: viewController, documentType: .drivingLicence, stepsEnum: listSteps)
        let step1 = capture.nextStep()
        let step2 = capture.nextStep()
        
        XCTAssertEqual(step1, listSteps[1])
        XCTAssertEqual(step2, listSteps[2])
        XCTAssertTrue(capture.isLastStep())
    }
    
    
    func testCaptureLastStepPassportNoSelfie() {
     
        let capture = CaptureApp(delegate: viewController, documentType: .passport, withSelfie: false)
        
        let step = capture.nextStep()
        let valueIsLastStep =  capture.isLastStep()
        
        XCTAssertEqual(step, CaptureStepEnum.end)
        XCTAssertEqual(valueIsLastStep, true)
    }
    
    
    func testCaptureResidencePermitNextStep() {
        
        let capture = CaptureApp(delegate: viewController, documentType: .residencePermit, withSelfie: false)
        let step = capture.nextStep()
        
        XCTAssertEqual(step, CaptureStepEnum.back)
    }
    
    
    func testCaptureIdentityCardWithSelfie() {
        
        let capture = CaptureApp(delegate: viewController, documentType: .identityCard, withSelfie: true)
        let step1 = capture.nextStep()
        let step2 = capture.nextStep()
        let step3 = capture.nextStep()
        
        XCTAssertEqual(step1, CaptureStepEnum.back)
        XCTAssertEqual(step2, CaptureStepEnum.selfie)
        XCTAssertEqual(step3, CaptureStepEnum.end)
    }
    
    
    func testError() {
        
        viewController.responseError(error: .cancelByUser)
        
        XCTAssertEqual(viewController.lastError, CaptureErrorEnum.cancelByUser)
        XCTAssertNotEqual(viewController.lastError, CaptureErrorEnum.network)
    }
    
    func testErrorException() {
        
        let error = NSError(domain: "randomErro", code: 1, userInfo: nil)
        viewController.responseError(error: .exception(withError: error))
        
        XCTAssertNotEqual(viewController.lastError, CaptureErrorEnum.network)
        XCTAssertNotEqual(viewController.lastError, CaptureErrorEnum.exception(withError: nil))
        XCTAssertEqual(viewController.lastError, CaptureErrorEnum.exception(withError: error))
    }
    
    
    func testPhotoOut() {
        
        let size = CGSize(width: 128, height: 128)
        let imageForTesting = UIGraphicsImageRenderer(size: size).image { rendererContext in
            UIColor.red.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
        let step = CaptureStepEnum.front
        viewController.photoOut(capturedImage: imageForTesting, currentStep: step)
        
        XCTAssertEqual(imageForTesting, viewController.lastImage)
        XCTAssertEqual(step, viewController.lastImageStep)
    }
    
}

