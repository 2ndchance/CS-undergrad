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
    @IBOutlet weak var score: UILabel! //displays Score next to actuall score
    @IBOutlet weak var statesFound: UILabel! // displays states found
    @IBOutlet weak var GameTable: UITableView! // holds cells for states
    @IBOutlet weak var nameentry: UITextField! // take name of person for game
    @IBOutlet weak var NameofGame: UILabel!
    @IBOutlet weak var Name: UILabel! //Displays "name" by text field
    var foundStates = Array(repeating: 0, count: 51) //seperate array to track score of the states. could be unnecessary with custom class
    var statecolor = Array(repeating: UIColor.clear, count: 51)

    var States = ["1. Alabama", "2. Alaska", "3. Arizona", "4. Arkansas", "5. California", "6. Colorado", "7. Connecticut", "8. Delaware", "9. Florida", "10. Georgia", "11. Hawaii", "12. Idaho", "13. Illinois", "14. Indiana", "15. Iowa", "16. Kansas", "17. Kentucky", "18. Louisiana", "19. Maine", "20. Maryland", "21. Massachusetts", "22. Michigan", "23. Minnesota", "24. Mississippi", "25. Missouri", "26. Montana", "27. Nebraska", "28. Nevada", "29. New Hampshire", "30. New Jersey", "31. New Mexico", "32. New York", "33. North Carolina", "34. North Dakota", "35. Ohio", "36. Oklahoma", "37. Oregon", "38. Pennsylvania", "39. Rhode Island", "40. South Carolina", "41. South Dakota", "42. Tennessee", "43. Texas", "44. Utah", "45. Vermont", "46. Virginia", "47. Washington", "48. West Virginia", "49. Wisconsin", "50. Wyoming", "51 District of Columbia"] //array with name of all 50 states

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
        foundStates = Array(repeating: 0, count: 51)
        statecolor = Array(repeating: UIColor.clear, count: 51)
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath) as! StateCell
            cell.resetcell()
            cell.State.text = States[Int(indexPath.row)]
            cell.Score.text = String(foundStates[indexPath.row])
            cell.backgroundColor = statecolor[indexPath.row]
            cell.tag = indexPath.row
            return cell
            
        }
        Points = 0
        found = 0
        statesFound.text = "States Found : ".appending(String(found))
        score.text = "Score: ".appending(String(found))
        self.GameTable.reloadData()
        
    }
    
    
    override func viewDidLoad() {
         GameTable.register(UINib(nibName: "StateCell", bundle: nil), forCellReuseIdentifier: "State")
        
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
        //if allows states to be selected only if game is started.
        if(!gamenotstarted){
        let state = GameTable.cellForRow(at: indexPath)! as! StateCell
        
        if (state.timesfound == 0)
        {
            found += 1
            Points += (2*found)-1

        }
        foundStates[indexPath.row] += 1
        statecolor[indexPath.row] = UIColor.blue
        Points += 1
        state.Score.text = (String(foundStates[indexPath.row]))
        state.backgroundColor = statecolor[indexPath.row]
        statesFound.text = "States Found : ".appending(String(found))
        score.text = "Score: ".appending(String(Points))
        self.GameTable.reloadData()

    }
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath) as! StateCell
        
        cell.State.text = States[Int(indexPath.row)]
        cell.Score.textAlignment = .right
        cell.Score.text = String(foundStates[indexPath.row])
        cell.backgroundColor = statecolor[indexPath.row]
        cell.tag = indexPath.row
        
        return cell

        
    }
    
}

