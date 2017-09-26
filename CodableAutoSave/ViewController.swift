import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    let formModel = AppDelegate.appSession.formModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formModel.delegate = self
    }
}

extension ViewController: FormModelDelegate {
    func storedDataLoaded(firstName: String?, lastName: String?) {
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
    }
    
    func dataToSave() -> FormModel.SaveableData {
        return FormModel.SaveableData(firstNameText: firstNameTextField.text, lastNameText: lastNameTextField.text)
    }
}

