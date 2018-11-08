import XCTest

extension XCTestCase {
	func data(forResource resource: String, withExtension fileExtension: String) -> Data? {
		let bundle = Bundle(for: type(of: self))
		guard let url = bundle.url(forResource: resource, withExtension: fileExtension) else {
			return nil
		}
		return try? Data(contentsOf: url)
	}
}
