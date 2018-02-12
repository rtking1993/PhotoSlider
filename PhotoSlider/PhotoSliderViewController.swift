import UIKit

// MARK: PhotoSliderViewController

class PhotoSliderViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var photoSliderView: PhotoSliderView!
    
    // MARK: View Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let images: [UIImage] = [UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!,
                                 UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!]
        
        photoSliderView.configure(with: images)
    }
}

