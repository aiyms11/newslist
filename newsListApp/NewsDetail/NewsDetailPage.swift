//
//  NewsDetailPage.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/30/21.
//

import Foundation
import UIKit

final class NewsDetailPage: UIViewController {
    private let news: News
    
    private lazy var contentWidth = self.view.bounds.size.width - 16
    
    private lazy var topicLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 5
        label.text = news.title
        return label
    }()
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .gray
        label.text = news.author
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .gray
        return label
    }()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        label.text = news.description
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
        }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var mainStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [topicLabel, stackView, imageView, textLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .leading
        return verticalStackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor(named: "backGroundColor")
        return scrollView
    }()
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        dateLabel.text = stringToDate(dateString: news.publishedAt)
        guard let url = URL(string: news.urlToImage ?? "") else { return }
        imageView.load(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        layoutUI()
    }
    
    private func layoutUI() {
        view.backgroundColor = UIColor(named: "backGroundColor")
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            scrollView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            mainStackView.widthAnchor.constraint(equalToConstant: contentWidth)
        ])
    }
    
    private func stringToDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd,yyyy"

        guard let date = dateFormatterGet.date(from: dateString) else { return "" }
        return String(dateFormatterPrint.string(from: date))
    }
    
    private func setupNavBar() {
        let share = UIButton(type: .system)
        share.setImage(UIImage(named: "share_icon"), for: .normal)
        share.frame = CGRect(x: 0, y: 0, width: 25, height: 25 )
        share.tintColor = UIColor(named: "reverseColor")
        share.imageView?.clipsToBounds = true
        share.addTarget(self, action: #selector(didTapShareLink), for: .touchUpInside)

        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 35, height: 35)));
        view.addSubview(share)

        let rightButton = UIBarButtonItem(customView: view)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapShareLink() {
        guard let url = URL(string: news.shareLink) else { return }
        let items = [url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
