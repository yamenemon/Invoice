//
//  IVHomeViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import CSPieChart

class IVHomeViewController: UIViewController {
    
    @IBOutlet weak var pieChart: CSPieChart!
    @IBOutlet weak var durationControl: UISegmentedControl!
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var lblTotalExpenses: UILabel!
    
    var items = [CSPieChartData]()
    
    
    var colorList: [UIColor] = [
        .green,
        .blue,
        .orange,
        .red,
        .yellow,
        .magenta
    ]
    
    class func initWithStoryboard() -> IVHomeViewController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "IVHomeViewController") as! IVHomeViewController
        return controller ;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeContainer()
       
        
        pieChart?.dataSource = self
        pieChart?.delegate = self
        pieChart?.pieChartRadiusRate = 0.95
        pieChart?.pieChartLineLength = 12
        pieChart?.seletingAnimationType = .piece
        pieChart?.show(animated: false)
        
       
       
    }
 
    func initializeServerCall() {
        self.durationControl.selectedSegmentIndex = 0
        self.getExpencesStatisticsByCategory(withType: "yearly")
    }
    
    func initializeContainer() {
        
        self.tableView1.tag = 1
        self.tableView1.register(UINib(nibName: "IVExpencesCell1", bundle:nil), forCellReuseIdentifier: "IVExpencesCell1")
        self.tableView1.separatorStyle = .none
        self.tableView1.estimatedRowHeight = 44
        self.tableView1.rowHeight = UITableView.automaticDimension
        self.tableView1.reloadData()
        
        self.tableView2.tag = 2
        self.tableView2.register(UINib(nibName: "IVExpencesCell2", bundle:nil), forCellReuseIdentifier: "IVExpencesCell2")
        self.tableView2.separatorStyle = .none
        self.tableView2.estimatedRowHeight = 44
        self.tableView2.rowHeight = UITableView.automaticDimension
        self.tableView2.reloadData()
        
    }
    
    @IBAction func durationIndexChanged(_ sender: Any) {
        switch durationControl.selectedSegmentIndex
        {
        case 0:
           self.getExpencesStatisticsByCategory(withType: "yearly")
        case 1:
           self.getExpencesStatisticsByCategory(withType: "monthly")
        case 2:
            self.getExpencesStatisticsByCategory(withType: "weekly")
        case 3:
            self.getExpencesStatisticsByCategory(withType: "daily")
        default:
            break
        }
    }
    
    
    func getExpencesStatistics() {
        
        let vendorBuilder = IVInvoiceClient.getRequestBuilderForExpensesStats(withType: "monthly")
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let expensesItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                   
                    
                }
                
            }
            
        }
    }
    
    func getExpencesStatisticsByCategory(withType type:String) {
        
        self.lblTotalExpenses.text = ""
        self.items.removeAll()
        self.pieChart.reloadPieChart()
        self.tableView1.reloadData()
        self.tableView2.reloadData()
        
        let vendorBuilder = IVInvoiceClient.getRequestBuilderForExpensesStatsByCategory(withType: type)
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let expensesItems = information["results"] as? Array<Dictionary<String, Any>> {
                  
                    var totalExpenses : Double = 0
                    for expenseItem in expensesItems {
                        self.items.append(CSPieChartData(key: expenseItem["name"] as! String, value: expenseItem["value"] as! Double))
                        
                        totalExpenses = totalExpenses + Double(expenseItem["value"] as! Double)
                    }
                    self.lblTotalExpenses.text = "\(Int(totalExpenses))"
                    self.pieChart.reloadPieChart()
                    self.tableView1.reloadData()
                    self.tableView2.reloadData()

                }
                
            }
            
        }
    }
    
    fileprivate var touchDistance: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance = location.x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance -= location.x
        
        if touchDistance > 100 {
            print("Right")
        } else if touchDistance < -100 {
            print("Left")
        }
        
        touchDistance = 0
    }
    

}

extension IVHomeViewController: CSPieChartDataSource {
    
    func numberOfComponentData() -> Int {
        return items.count
    }
    
    func pieChart(_ pieChart: CSPieChart, dataForComponentAt index: Int) -> CSPieChartData {
        return items[index]
    }
    
    func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, colorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, lineColorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    //    func numberOfComponentSubViews() -> Int {
    //        return  dataList.count
    //    }
    //
    //    func pieChart(_ pieChart: CSPieChart, viewForComponentAt index: Int) -> UIView {
    //        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    //        view.image = UIImage(named: "test.png")
    //        view.layer.cornerRadius = 15
    //        view.clipsToBounds = true
    //        return view
    //    }
}

extension IVHomeViewController: CSPieChartDelegate {
    
    func pieChart(_ pieChart: CSPieChart, didSelectComponentAt index: Int) {
        let data = items[index]
        print(data.key)
    }
}

extension IVHomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.items.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IVExpencesCell2", for: indexPath) as! IVExpencesCell2
            cell.setInformation(information: items[indexPath.row], color: colorList[indexPath.row])
             return cell
        } else {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "IVExpencesCell1", for: indexPath) as! IVExpencesCell1
            cell.setInformation(information: items[indexPath.row], color: colorList[indexPath.row])
            return cell
        }
        
        
       
    }
    
}

extension IVHomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableView.automaticDimension
        
    }
    
}

