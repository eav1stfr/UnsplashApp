import UIKit

protocol ImageManagerDelegate: AnyObject {
    func updateImage(urlString: String)
    func didFailWithError(error: Error)
}

struct ImageManager {
    let accessKey: String = "ZSCIOCqhBIECWtoOPZKyKNVB_Kz33BRM1dmdzsN87Xc"
    let urlString: String = "https://api.unsplash.com/photos/random"
    
    weak var delegate: ImageManagerDelegate?
    
    func fetchImage() {
        
    }
    
    func performRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let img = self.parseJSON(data: safeData) {
                        delegate?.updateImage(urlString: img)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> String? {
        let decoder = JSONDecoder()
        
        do {
            let photo = try decoder.decode(RandImage.self, from: data)
            return photo.urls.regularImage
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
