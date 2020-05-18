
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
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerCells()
            //TODO: ------------------------------- Подумать где должна быть реализация
            tableView.delegate = tableViewProvider
            tableView.dataSource = tableViewProvider
        }
    }
    
    
    //MARK: - Private properties
    private var provider: CostsViewActions?
    //TODO: ------------------------------- Подумать где должна быть реализация
    private let tableViewProvider = CostsTableViewProvider()
    
    
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
    
    private func updateChartData( categories: [CategoryViewModel]) {
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
    
    private func registerCells() {
        tableView.register(UINib(nibName: "CategoryCostTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryCostsTableViewCell.reuseIdD)
    }
}



extension CostsView: CostsViewImplementation {
    func setProvider(provider: CostsViewActions) {
        self.provider = provider
    }
    
    func setData(_ categories: [CategoryViewModel]) {
        updateChartData(categories: categories)
        tableViewProvider.categories = categories
        tableView.reloadData()
    }
}



extension CostsView: ChartViewDelegate {
    
    
}



extension CostsView: UITableViewDelegate {
    
}
