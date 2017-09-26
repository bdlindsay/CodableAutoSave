import Foundation

protocol FormModelDelegate: class {
    func storedDataLoaded(firstName: String?, lastName: String?)
    func dataToSave() -> FormModel.SaveableData
}

class FormModel {
    class SaveableData: Codable {
        var firstNameText: String?
        var lastNameText: String?
        
        init(firstNameText: String? = nil, lastNameText: String? = nil) {
            self.firstNameText = firstNameText
            self.lastNameText = lastNameText
        }
    }
    var data: SaveableData?
    private let quickSaveDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("formModelData.json")
    
    weak var delegate: FormModelDelegate? {
        didSet {
            delegate?.storedDataLoaded(firstName: data?.firstNameText, lastName: data?.lastNameText)
        }
    }
    
    init() {
        load()
    }
    
    func save() {
        data = delegate?.dataToSave()
        guard let data = data else { return }
        
        let encoder = JSONEncoder()

        do {
            let encodedData = try encoder.encode(data)
            
            guard let quickSaveDataPath = quickSaveDataPath else {
                print("Failed to find file path")
                return
            }
            
            try encodedData.write(to: quickSaveDataPath)
        } catch {
            print(error)
        }
    }
    
    private func load() {
        do {
            guard let quickSaveDataPath = quickSaveDataPath else {
                print("Could not get read file path")
                return
            }
            
            let encodedData = try Data(contentsOf: quickSaveDataPath)
            
            let decoder = JSONDecoder()
            data = try decoder.decode(SaveableData.self, from: encodedData)
            
            delegate?.storedDataLoaded(firstName: data?.firstNameText, lastName: data?.lastNameText)
        } catch {
            print(error)
            data = SaveableData()
        }
    }
}
