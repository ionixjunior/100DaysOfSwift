import Foundation

extension URL {
    func appending(path: String) -> URL {
        if #available(iOS 16.0, *) {
            return self.appending(path: path, directoryHint: .inferFromPath)
        }
        
        return self.appendingPathComponent(path)
    }
    
    func getPath() -> String {
        if #available(iOS 16.0, *) {
            return self.path()
        }
        
        return self.path
    }
}
