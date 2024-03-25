import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fetch: UIButton!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchdata: [NSManagedObject] = []
    
    // Get the AppDelegate reference properly
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Set the delegate and data source for the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext)!
        
        let record = NSManagedObject(entity: entity, insertInto: managedContext)
        
        record.setValue(email.text, forKey: "email")
        
        record.setValue(password.text, forKey: "password")
      
        
do {
            try managedContext.save()
            print("Data saved successfully.") // Refresh the data after saving
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchData()
    }
    
    
    
    func fetchData() {
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        do {
            fetchdata = try managedContext.fetch(request) as! [NSManagedObject]
            tableView.reloadData() // Reload the table view with fetched data
            print("Data fetched successfully.")
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protypecell", for: indexPath) as! TableViewCell
        let email = fetchdata[indexPath.row].value(forKey: "email") as? String
        var password = fetchdata[indexPath.row].value(forKey: "password") as? String
        print (password)
        cell.label1?.text = email
        cell.label2?.text = password
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let managedContext = appDelegate.persistentContainer.viewContext
            let userToDelete = fetchdata[indexPath.row]
            managedContext.delete(userToDelete)
            
            do {
                try managedContext.save()
                fetchdata.remove(at: indexPath.row) // Remove from the array as well
                tableView.deleteRows(at: [indexPath], with: .fade) // Update the table view
                print("Data deleted successfully.")
            } catch {
                print("Error deleting data: \(error.localizedDescription)")
            }
        }
    }
}
