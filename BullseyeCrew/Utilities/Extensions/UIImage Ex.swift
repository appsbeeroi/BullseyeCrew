import UIKit

extension UIImage {
    func redrawImage(scale: CGFloat = 0.5, quality: CGFloat = 0.7) -> UIImage {
        let newSize = CGSize(
            width: self.size.width * scale,
            height: self.size.height * scale
        )
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let data = resizedImage?.jpegData(compressionQuality: quality) ?? Data()
        
        return UIImage(data: data) ?? UIImage()
    }
}
