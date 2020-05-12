
import Charts
import UIKit

class CostsViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Расходы"
        
        pieChartView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //pieChartView.chartDescription?.text = "Расходы"
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.usePercentValuesEnabled = true
        
        pieChartView.holeRadiusPercent = 0
        pieChartView.transparentCircleRadiusPercent = 0
        
        updateChartData()
    }
    
    func updateChartData() {
        var chartEntries = [ChartDataEntry]()
        
        chartEntries.append(PieChartDataEntry(value: 18))
        chartEntries.append(PieChartDataEntry(value: 10))
        chartEntries.append(PieChartDataEntry(value: 24))
        
        let chartDataSet = PieChartDataSet(entries: chartEntries, label: "Категории")
        chartDataSet.drawValuesEnabled = true
        chartDataSet.sliceSpace = 2
        
        let colors = [UIColor.red, .blue, .brown]
        chartDataSet.colors = colors

        let data = PieChartData(dataSet: chartDataSet)
        pieChartView.data = data
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
}

extension CostsViewController: ChartViewDelegate {
    
    
}
