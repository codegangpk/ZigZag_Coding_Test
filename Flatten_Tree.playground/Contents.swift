import Foundation

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

func loadJSONDictionary(fileName: String) throws -> [String: [String: [String: Any]]] {
    guard let currentPath = Bundle.main.path(forResource: fileName, ofType: ".json") else {
        throw "Couldn't find path"
    }
    let url = URL(fileURLWithPath: currentPath)
    
    do {
        let jsonData = try Data(contentsOf: url)
        let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed) as! [String: [String: [String: Any]]]
        return jsonResult
    } catch {
        throw "Could not serialize jsonObject from file"
    }
}

func flattenTreeAray(from dictionary: [String: [String: [String: Any]]]) -> [String] {
    var flattenedArray: [String] = []
    
    dictionary.forEach { (depth1Dictionary) in
        guard depth1Dictionary.value.isEmpty == false else {
            flattenedArray.append(depth1Dictionary.key)
            return
        }
        
        depth1Dictionary.value.forEach { (depth2Dictionary) in
            guard depth2Dictionary.value.isEmpty == false else {
                flattenedArray.append([depth1Dictionary.key, depth2Dictionary.key].joined(separator: ">"))
                return
            }
            
            depth2Dictionary.value.forEach { (depth3Dicionary) in
                flattenedArray.append([depth1Dictionary.key, depth2Dictionary.key, depth3Dicionary.key].joined(separator: ">"))
            }
        }
    }
    return flattenedArray
}

func runTest() throws {
    var jsonDictionary: [String: [String: [String: Any]]]
    
    do {
        jsonDictionary = try loadJSONDictionary(fileName: "categories")
        let flattenedTreeArray1 = flattenTreeAray(from: jsonDictionary)
        print(flattenedTreeArray1)
        print("\n\n\n")
        
        jsonDictionary = try loadJSONDictionary(fileName: "emptyKeyCategories")
        let flattenedTreeArray2 = flattenTreeAray(from: jsonDictionary)
        print(flattenedTreeArray2)
        print("\n\n\n")
        
        jsonDictionary = try loadJSONDictionary(fileName: "corruptedJSON")
        let flattenedTreeArray3 = flattenTreeAray(from: jsonDictionary)
        print(flattenedTreeArray3)
        print("\n\n\n")
        } catch {
            throw error.localizedDescription
        }
}

do {
    try runTest()
} catch {
    print(error.localizedDescription)
    let exception = NSException(name: NSExceptionName.fileHandleOperationException, reason: error.localizedDescription, userInfo: nil)
    exception.raise()
}
