//
//  ChartViewController.swift
//  Chart Implementation
//
//  Created by Eduardo Oliveros Acosta on 23/07/16.
//  Copyright © 2016 Eduardo Oliveros. All rights reserved.
//  if you want this code write to me! Thanks!!!!
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var lineChartView: LineChartView!
    var days: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        days = ["Mo","Tu","We","Th","Fr","Sa","Su"]
        // Do any additional setup after loading the view.
        let values = [110.0,90.0,128.0,130.0,105.0,120.0, 110.0, 90.0, 128.0, 130.0, 105.0, 80.0, 110.0, 90.0, 128.0, 130.0, 105.0, 130.0, 110.0]
        setChart(days!,Values:values)
        setChartDesign()
        setXAxisDesign()
        setYAxisDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setYAxisDesign(){
        let leftYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Left)
        leftYAxis.drawLabelsEnabled = false
        leftYAxis.enabled = false
        
        // add reference line
        
        let line = ChartLimitLine(limit:100)
        line.lineColor = UIColor.greenColor()
        line.lineWidth = 2.0
        leftYAxis.addLimitLine(line)
        //dash line :
        line.lineDashPhase = 3.0
        line.lineDashLengths = [4,4]
        
        leftYAxis.drawAxisLineEnabled = true
        
        
        let rightYAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Right)
        rightYAxis.drawGridLinesEnabled = false
        leftYAxis.enabled = false
    }
    func setXAxisDesign(){
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
    
    }
    func setChartDesign(){
    
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .EaseInOutCubic)
        lineChartView.descriptionText = ""
        lineChartView.noDataText = "no data information, add data points!"
    }
    func setChart(dataPoints: [String], Values values: [Double]){

        lineChartView.delegate = self
        var dataEntries: [ChartDataEntry] = []
        var dataDays: [String] = []
        var count = 0
        for i in 0..<values.count{
            let DataEntry = ChartDataEntry(value: values[i],xIndex:i)
            dataEntries.append(DataEntry)
            dataDays.append(dataPoints[count])
            if (count == dataPoints.count - 1){
                count = 0
            }else{
                count = count + 1
            }
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label:nil)
        //set Line Desing
        
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.lineWidth = 3.0
        lineChartDataSet.mode = .CubicBezier
        lineChartDataSet.colors = [UIColor.whiteColor()]
        
        // Points Color
        lineChartDataSet.circleColors = [NSUIColor.redColor()]
        lineChartDataSet.
        
        let lineChartData = LineChartData(xVals: dataDays, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        //hide Legend
        
        let legend = lineChartView.legend
        
        legend.enabled = false
        
        
        //zoom in value
        
        lineChartView.zoom(3.0, scaleY: 1,xIndex: CGFloat(values.count), yValue: 100.0, axis: .Right)
    }
    
    
    ///ChartView delegate
    
    func chartScaled(chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat){
        print(scaleX)
        print(scaleY)
    }
    
    func chartTranslated(chartView: ChartViewBase, dX: CGFloat, dY: CGFloat){
        print(dX)
        print(dY)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
