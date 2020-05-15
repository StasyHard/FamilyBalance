
import UIKit
import Charts


protocol CostsViewImplementation: class {
    func setProvider(provider: CostsViewActions)
}

protocol CostsViewActions: class {
    
}


class CostsView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView! {
        didSet {
            setupChartSettings()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    private var provider: CostsViewActions?
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup()
    }
    
    //MARK: - Private metods
    private func setup() {
    }
    
    private func setupChartSettings() {
        pieChartView.delegate = self
        
        //pieChartView.chartDescription?.text = "Расходы"
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.usePercentValuesEnabled = true
        
        pieChartView.holeRadiusPercent = 0
        pieChartView.transparentCircleRadiusPercent = 0
        
        updateChartData()
    }
    
    func updateChartData() {
        var chartEntries = [ChartDataEntry]()
        
        chartEntries.append(PieChartDataEntry(value: 60))
        chartEntries.append(PieChartDataEntry(value: 30))
        chartEntries.append(PieChartDataEntry(value: 10))
        
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
        pFormatter.percentSymbol = "%"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
    
}



extension CostsView: CostsViewImplementation {
    func setProvider(provider: CostsViewActions) {
        self.provider = provider
    }
    
    
    
}



extension CostsView: ChartViewDelegate {
    
    
}
