
import UIKit
import Charts


class CostsPieChartHeaderView: UITableViewHeaderFooterView, ReusableView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var pieChartView: PieChartView! {
        didSet {
            setupChartSettings()
        }
    }
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
        
    func updateChartData( categories: [CategoryViewModel]) {
        var chartEntries = [ChartDataEntry]()
        var colors = [UIColor]()
        
        categories.forEach({ category in
            let value = category.sum
            chartEntries.append(PieChartDataEntry(value: value))
            let color = category.color
            colors.append(color)
        })
        
        let chartDataSet = PieChartDataSet(entries: chartEntries, label: "Категории")
        chartDataSet.drawValuesEnabled = true
        chartDataSet.sliceSpace = 2
        
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
    
    
    //MARK: - Private metods
    private func setupUI() {
        contentView.backgroundColor = AppColors.backgroundColor
    }
    
    private func setupChartSettings() {
        pieChartView.delegate = self
        
        //pieChartView.chartDescription?.text = "Расходы"
        pieChartView.legend.enabled = false
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeRadiusPercent = 0
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.backgroundColor = AppColors.backgroundColor
    }
}



extension CostsPieChartHeaderView: ChartViewDelegate {
    
    
}
