
import UIKit
import Charts


protocol CostsViewImplementation: class {
    func setProvider(provider: CostsViewActions)
    func setData(_ categories: [CategoryViewModel])
}


class CostsView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView! {
        didSet {
            setupChartSettings()
            updateChartData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Private properties
    private var provider: CostsViewActions?
    
    private var categories: [CategoryViewModel]? {
        didSet {
            updateChartData()
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    }
    
    private func updateChartData() {
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
    
    func setData(_ categories: [CategoryViewModel]) {
        self.categories = categories
    }
}



extension CostsView: ChartViewDelegate {
    
    
}
