import Foundation

struct AppSession {
    let formModel: FormModel
    
    init() {
        formModel = FormModel()
    }
    
    func save() {
        formModel.save()
    }
}
