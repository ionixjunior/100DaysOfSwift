#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif

#if canImport(MobileCoreServices)
import MobileCoreServices
#endif

class Constants {
    static var itemProviderTypeIdentifier: String {
        get {
            if #available(iOS 14.0, *) {
                return UniformTypeIdentifiers.UTType.propertyList.identifier
            } else {
                return kUTTypePropertyList as String
            }
        }
    }
}
