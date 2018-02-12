import UIKit

// MARK: PhotoSliderView

class PhotoSliderView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!

    // MARK: Configure Methods
    
    func configure(with images: [UIImage]) {
        
        // Get the scrollView width and height
        let scrollViewWidth: CGFloat = scrollView.frame.width
        let scrollViewHeight: CGFloat = scrollView.frame.height
        
        // Loop through all of the images and add them all to the scrollView
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: scrollViewWidth * CGFloat(index),
                                                      y: 0,
                                                      width: scrollViewWidth,
                                                      height: scrollViewHeight))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
        }
        
        // Set the scrollView contentSize
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count),
                                        height: scrollView.frame.height)
        
        // Ensure that the pageControl knows the number of pages
        pageControl.numberOfPages = images.count
    }
    
    // MARK: Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: PhotoSliderView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: Helper Methods
    
    @IBAction func pageControlTap(_ sender: Any?) {
        guard let pageControl: UIPageControl = sender as? UIPageControl else {
            return
        }
        
        scrollToIndex(index: pageControl.currentPage)
    }
    
    private func scrollToIndex(index: Int) {
        let pageWidth: CGFloat = scrollView.frame.width
        let slideToX: CGFloat = CGFloat(index) * pageWidth
        
        scrollView.scrollRectToVisible(CGRect(x: slideToX, y:0, width:pageWidth, height:scrollView.frame.height), animated: true)
    }
}

// MARK: UIScrollViewDelegate

extension PhotoSliderView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        pageControl.currentPage = Int(currentPage)
    }
}
