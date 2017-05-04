//
//  ViewController.swift
//  License Plates
//
//  Created by Brandon on 4/24/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var gamenotstarted = true;
    var game = "Standard Game"
    var found = 0
    var Points = 0
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var statesFound: UILabel!
    @IBOutlet weak var GameTable: UITableView!
    @IBOutlet weak var nameentry: UITextField!
    @IBOutlet weak var NameofGame: UILabel!
    @IBOutlet weak var Name: UILabel!
    var foundStates = Array(repeating: 0, count: 50)
   

    var States = ["1. Alabama", "2. Alaska", "3. Arizona", "4. Arkansas", "5. California", "6. Colorado", "7. Connecticut", "8. Delaware", "9. Florida", "10. Georgia", "11. Hawaii", "12. Idaho", "13. Illinois", "14. Indiana", "15. Iowa", "16. Kansas", "17. Kentucky", "18. Louisiana", "19. Maine", "20. Maryland", "21. Massachusetts", "22. Michigan", "23. Minnesota", "24. Mississippi", "25. Missouri", "26. Montana", "27. Nebraska", "28. Nevada", "29. New Hampshire", "30. New Jersey", "31. New Mexico", "32. New York", "33. North Carolina", "34. North Dakota", "35. Ohio", "36. Oklahoma", "37. Oregon", "38. Pennsylvania", "39. Rhode Island", "40. South Carolina", "41. South Dakota", "42. Tennessee", "43. Texas", "44. Utah", "45. Vermont", "46. Virginia", "47. Washington", "48. West Virginia", "49. Wisconsin", "50. Wyoming"]

    @IBAction func startGame(_ sender: Any) {
        
        if (gamenotstarted && nameentry.text != ""){
            game = nameentry.text!
            nameentry.text = ""
            view.endEditing(true)
            GameTable.reloadData()
        }
        gamenotstarted = false

    }
    
    @IBAction func endGame(_ sender: Any) {
        game = "Standard Game"
        gamenotstarted = true
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath)
            cell.textLabel?.text = States[Int(indexPath.row)]
            cell.tag = indexPath.row
            
            return cell
            
            
        }
        Points = 0
        found = 0
        foundStates = Array(repeating: 0, count: 50)
        statesFound.text = "States Found : ".appending(String(found))
        score.text = "Score: ".appending(String(found))
        GameTable.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        
        Name.text = "Name of Game:  "
        statesFound.text = "States Found : ".appending(String(found))
        score.text = "Score: ".appending(String(found))
        
        NameofGame.text = "The License Plate Game"
        NameofGame.textColor = UIColor .green
        NameofGame.textAlignment = .center
        NameofGame.font = UIFont(name: NameofGame.font.fontName, size: 30)
        super.viewDidLoad()

    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if (foundStates[indexPath.row] == 0 ){
            found += 1
            Points += (2*found)-1
        }
        Points += 1
        foundStates[indexPath.row] += 1
        let currentCell = tableView.cellForRow(at: indexPath)!
        currentCell.textLabel?.text = States[Int(indexPath.row)].appending("                        ").appending(String(foundStates[indexPath.row]))

        
            
        currentCell.textLabel?.backgroundColor = UIColor .blue
        statesFound.text = "States Found : ".appending(String(found))
        score.text = "Score: ".appending(String(Points))

    }
    
    
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return States.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of States for ".appending(game)}
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath)
       cell.textLabel?.text = States[Int(indexPath.row)].appending("                        ").appending(String(foundStates[indexPath.row]))
        cell.tag = indexPath.row
        
        return cell

        
    }
    
}

