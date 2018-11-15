//
//  ChartViewController.swift
//  Charts
//
//  Created by AVROMIC on 12/20/17.
//  Copyright © 2017 AVROMIC. All rights reserved.
//

import UIKit
import Localize_Swift
//import Charts


class ChartViewController: UIViewController {
    
    @IBOutlet weak var badView: UIView!
    @IBOutlet weak var avaregeView: UIView!
    @IBOutlet weak var alowedView: UIView!
    @IBOutlet weak var noDataview: UIView!
    
    @IBOutlet weak var clickedSubjectName: UILabel!
    @IBOutlet weak var alowedLabel: UILabel!
    @IBOutlet weak var avaregeLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var lineChart: PNLineChart?
    var subjectNameLong = [String]()
    var subjectName = [String]()
    var absenceCountByMonth = [CGFloat] ()
    var months = [String] ()
    var absenceByMonths = [[CGFloat]] ()
    var index = UserDefaults.standard.integer(forKey: "index")
    var chartsData = DatabaseManager.sharedInstance.currentInfo?.absenceModel
    
    let whitespace = NSCharacterSet.whitespaces
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if chartsData?.absenceBySemesters != nil {
            subjectNameCreator()
        }
        
        print(subjectName)
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.setLineChartWithClick), name: NSNotification.Name("click on Bar"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        badView.backgroundColor = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 1)
        badLabel.text = "Bad".localized()
        avaregeView.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 1)
        avaregeLabel.text = "Average".localized()
        alowedView.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        alowedLabel.text = "Allowable".localized()
        
       
        if chartsData?.absenceBySemesters != nil {
            noDataview.isHidden = true
            noDataLabel.isHidden = true
             clickedSubjectName.text = subjectNameLong[index]
            let barChart = self.setBarChart()
            lineChart = self.setLineChart(index: 0)
            self.view.addSubview(barChart)
            self.view.addSubview(lineChart!)
        }else {
            noDataview.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = "No information.".localized()
        }
       
    }
 
    @objc func setLineChartWithClick(){
        let index = UserDefaults.standard.integer(forKey: "index")
        lineChart?.removeFromSuperview()
        lineChart = setLineChart(index: index)
        print(index)
        clickedSubjectName.text = subjectNameLong[index]
        self.view.addSubview(lineChart!)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func subjectNameCreator(){
        let subject = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.absenceBySemesters.last
        let curentLang = Localize.currentLanguage()
        var semIdentifier = true
        for itme in (subject?.absenceOfSemester)! {
            if curentLang == "ru" {
                
                self.subjectNameLong.append(itme.subjectName_ru)
                let TmpsubjectName = itme.subjectName_ru
                let range = TmpsubjectName.rangeOfCharacter(from: whitespace)
                
                if range != nil {
                    print("whitespace found")
                    var tmpStrSeparaed = TmpsubjectName.split(separator: " ")
                    let tmpStrShort = tmpStrSeparaed[0].prefix(2) + "." + tmpStrSeparaed[1].prefix(2)
                    self.subjectName.append(String(tmpStrShort))
                    print (tmpStrShort)
                }
                else {
                    print("whitespace not found")
                    let splited = TmpsubjectName.prefix(3)
                    self.subjectName.append(String(splited))
                    print(splited)
                }
                
            } else if curentLang == "hy" {
                self.subjectNameLong.append(itme.subjectName_hy)
                let TmpsubjectName = itme.subjectName_hy
                let range = TmpsubjectName.rangeOfCharacter(from: whitespace)
                
                if range != nil {
                    print("whitespace found")
                    var tmpStrSeparaed = TmpsubjectName.split(separator: " ")
                    let tmpStrShort = tmpStrSeparaed[0].prefix(2) + "." + tmpStrSeparaed[1].prefix(2)
                    self.subjectName.append(String(tmpStrShort))
                    print (tmpStrShort)
                }
                else {
                    print("whitespace not found")
                    let splited = TmpsubjectName.prefix(3)
                    self.subjectName.append(String(splited))
                    print(splited)
                }
            } else {
                self.subjectNameLong.append(itme.subjectName_en)
                let TmpsubjectName = itme.subjectName_en
                let range = TmpsubjectName.rangeOfCharacter(from: whitespace)
                
                if range != nil {
                    print("whitespace found")
                    var tmpStrSeparaed = TmpsubjectName.split(separator: " ")
                    let tmpStrShort = tmpStrSeparaed[0].prefix(2) + "." + tmpStrSeparaed[1].prefix(2)
                    self.subjectName.append(String(tmpStrShort))
                    print (tmpStrShort)
                }
                else {
                    print("whitespace not found")
                    let splited = TmpsubjectName.prefix(3)
                    self.subjectName.append(String(splited))
                    print(splited)
                }
            }
            
            var absenceCount = 0
            var index = 0
            var countAbsence = [Int]()
            var item = [CGFloat] ()
            for count in itme.absenceByMonths {
                if semIdentifier {
                    if curentLang == "ru" {
                        self.months.append(count.month_ru)
                    } else if curentLang == "hy" {
                        self.months.append(count.month_hy)
                    } else {
                        self.months.append(count.month_en)
                    }
                }
                
                countAbsence.append(count.absenceCount)
                absenceCount = absenceCount + count.absenceCount
                // print(absenceCount)
                item.append(CGFloat(count.absenceCount))
            }
            
            absenceByMonths.append(item)
            semIdentifier = false
            absenceCountByMonth.append(CGFloat( absenceCount))
            absenceCount = 0
            index = index + 1
        }
        
    }
    
    func setBarChart() -> PNBarChart {
        let barChart = PNBarChart(frame: CGRect(x: 0, y: self.view.frame.maxY / 2, width: self.view.frame.width, height: self.view.frame.height / 2.5))
        barChart.backgroundColor = UIColor.clear
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = subjectName
        barChart.yValues = absenceCountByMonth
        barChart.strokeChart()            
        return barChart
    }

    public  func setLineChart(index : Int) -> PNLineChart {
        lineChart = PNLineChart(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height / 2.5))
        lineChart?.yLabelFormat = "%1.1f"
        lineChart?.showLabel = true
        lineChart?.backgroundColor = UIColor.clear
        lineChart?.xLabels = months as NSArray
        lineChart?.showCoordinateAxis = true
        // lineChart.center = self.view.center
        
        let dataArr = absenceByMonths[index]
        let data = PNLineChartData()
        data.color = PNGreen
        data.itemCount = dataArr.count
        data.inflexPointStyle = .Square
        data.getData = ({
            (index: Int) -> PNLineChartDataItem in
            let yValue = CGFloat(dataArr[index])
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart?.chartData = [data]
        lineChart?.strokeChart()
        return lineChart!
    }
}



