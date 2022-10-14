import UIKit

class ViewController: UIViewController {
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    private let label4 = UILabel()
    private let label5 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "AR"
        label2.sizeToFit()
        
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        prepareLayoutUsingMetricsAndPriorities()
        prepareLayoutUsingAnchors()
    }
    
    private func prepareLayoutUsingMetricsAndPriorities() {
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", metrics: nil, views: viewsDictionary))
        }

        let metrics = ["labelHeight": 88]

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", metrics: metrics, views: viewsDictionary))
    }
    
    private func prepareLayoutUsingAnchors() {
        var previous: UILabel?
        let labels = [label1, label2, label3, label4, label5]
        
        for label in labels {
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true // the same of leading and trailing anchors
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }

            if label == labels.last {
                label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
    
    private var labelsHeightConstraints = [NSLayoutConstraint]()
    
    override func viewDidLayoutSubviews() {
        for constraint in labelsHeightConstraints {
            constraint.isActive = false
        }
        labelsHeightConstraints.removeAll(keepingCapacity: true)
        
        let availableHeight = view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 40
        let labelHeight = availableHeight / 5
        
        for label in [label1, label2, label3, label4, label5] {
            let constraint = label.heightAnchor.constraint(equalToConstant: labelHeight)
            constraint.isActive = true
            labelsHeightConstraints.append(constraint)
        }
    }
}

