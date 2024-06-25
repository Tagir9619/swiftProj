import UIKit
import CoreData

protocol ArticleView: AnyObject {
    var article: News? { get set }
    func set(article: News)
}


class ArticleViewController: UIViewController, ArticleView {
    
    var article: News?
    
    // MARK: - Views
    private let exampleURL = UIImageView()
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let descriptionLabel = UILabel()
    private let contentLabel = UILabel()
    private let authorLabel = UILabel()
    
    var presenter: ArticlePresenter?
    
    // MARK: - Lifecircle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        presenter?.didWiewLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateFavoriteButtonState()
    }
}


    // MARK: - Extention
private extension ArticleViewController {
    
    func setupLayout() {
        configureScrollView()
        configureContentView()
        layoutScrollView()
        configureImageView()
        configureLabel()
        configureDescriptionLabel()
        configureAuthorLabel()
        configureContentLabel()
        
        addContentToScrollView()
    }
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    func configureImageView () {
        exampleURL.translatesAutoresizingMaskIntoConstraints = false
        
        exampleURL.kf.setImage(with: URL(string: (article?.urlToImage) ?? ""), placeholder: nil)
    }
    
    func configureLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.sizeToFit()
        titleLabel.font = .merriweatherFont(size: 29, style: .bolditalic)
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .merriweatherFont(size: 14, style: .regular)
    }
    
    func configureAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = .merriweatherFont(size: 18, style: .regular)
    }
    
    func configureContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()
        contentLabel.font = .merriweatherFont(size: 16, style: .regular)
    }
    
    func updateFavoriteButtonState() {
        var buttonImage: UIImage
        if let isSaved = presenter?.isArticleSaved(article: article!) {
            if isSaved {
                buttonImage = UIImage(systemName: "star.fill")!
            } else {
                buttonImage = UIImage(systemName: "star")!
            }
        } else {
            buttonImage = UIImage(systemName: "star")!
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(didTapButton))
    }
    
    @objc func didTapButton() {
        if let isSaved = presenter?.isArticleSaved(article: article!) {
            if isSaved {
                presenter?.deleteData(article: article!)
            } else {
                presenter?.saveData(article: article!)
            }
            updateFavoriteButtonState()
        }
    }
    

    
    func addContentToScrollView() {
        contentView.addSubview(exampleURL)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            exampleURL.topAnchor.constraint(equalTo: contentView.topAnchor),
            exampleURL.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            exampleURL.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            exampleURL.widthAnchor.constraint(equalTo: exampleURL.widthAnchor),
            exampleURL.heightAnchor.constraint(equalTo: exampleURL.widthAnchor, multiplier: 0.7),
            
            titleLabel.topAnchor.constraint(equalTo: exampleURL.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 23),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 48),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}


extension ArticleViewController {
    func set(article: News) {
        self.article = article
        setupData()
    }
}


extension ArticleViewController {
    func setupData() {
        setupLabel()
        setupDescriptionLabel()
        setupAuthorLabel()
        setupContentLabel()
        setupImageView()
    }
    
    func setupImageView () {
        exampleURL.kf.setImage(with: URL(string: (article?.urlToImage) ?? ""), placeholder: nil)
    }
    
    func setupLabel() {
        titleLabel.text = article?.title
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.text = article?.description
    }
    func setupAuthorLabel() {
        if article?.author != nil {
            authorLabel.text = article?.author
        } else {
            authorLabel.text = "Unknown author"
        }
    }
    
    func setupContentLabel() {
        contentLabel.text = article?.content
    }
}
