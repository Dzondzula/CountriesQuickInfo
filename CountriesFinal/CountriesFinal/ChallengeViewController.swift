
import UIKit
@IBDesignable
class Challenge: UIViewController {

    var scoreLabel: UILabel!
    var correctLabel : UILabel!
    var questionLabel : UILabel!

    var answer4: UIButton!
    var answer3: UIButton!
     var answer2: UIButton!
    var answer1: UIButton!
    
    var highScore = 0
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var correctAnswer = 0
   var questionsAsked = 0
    var questionCountry = [String]()
    var answerCity = [String]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .center
        scoreLabel.layer.borderWidth = 1
        scoreLabel.layer.borderColor = UIColor.gray.cgColor
        scoreLabel.sizeToFit()
        view.addSubview(scoreLabel)
//
        questionLabel = UILabel()
        questionLabel.numberOfLines = 2
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.font = UIFont.systemFont(ofSize: 24)
        
        questionLabel.textAlignment = .center
        questionLabel.sizeToFit()
        view.addSubview(questionLabel)
        
        answer1 = UIButton(type: .system)
        answer1.translatesAutoresizingMaskIntoConstraints = false
        answer1.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer1.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        view.addSubview(answer1)
        
        answer2 = UIButton(type: .system)
        answer2.translatesAutoresizingMaskIntoConstraints = false
        answer2.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer2.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        view.addSubview(answer2)
      
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: answer2.frame.size.width, height: 2))
        self.answer2.addSubview(topBorder)
        topBorder.backgroundColor = UIColor.blue
        
        
        
        answer3 = UIButton(type: .system)
        answer3.translatesAutoresizingMaskIntoConstraints = false
        answer3.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer3.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        answer3.sizeToFit()
        view.addSubview(answer3)
        
        answer4 = UIButton(type: .system)
        answer4.translatesAutoresizingMaskIntoConstraints = false
        answer4.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer4.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        view.addSubview(answer4)
        
      
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
           
            scoreLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -140),
           
            
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            questionLabel.widthAnchor.constraint(equalToConstant: 300),
            questionLabel.heightAnchor.constraint(equalToConstant: 60),
            
//            answer1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 250),
//            answer1.widthAnchor.constraint(equalToConstant: 300),
//            answer1.heightAnchor.constraint(equalToConstant: 100),
//            answer1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            answer1.bottomAnchor.constraint(equalTo: answer1.topAnchor,constant: 110),
//
//            answer2.topAnchor.constraint(equalTo: answer1.bottomAnchor,constant: 10),
//            answer2.widthAnchor.constraint(equalToConstant: 300),
//            answer2.heightAnchor.constraint(equalToConstant: 100),
//            answer2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            answer2.bottomAnchor.constraint(equalTo: answer2.topAnchor,constant: 110),
//
//            answer3.topAnchor.constraint(equalTo: answer2.bottomAnchor,constant: 10),
//            answer3.widthAnchor.constraint(equalToConstant: 300),
//            answer3.heightAnchor.constraint(equalToConstant: 100),
//            answer3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            answer3.bottomAnchor.constraint(equalTo: answer3.topAnchor,constant: 110),
//
//            answer4.topAnchor.constraint(equalTo: answer3.bottomAnchor,constant: 10),
//            answer4.widthAnchor.constraint(equalToConstant: 300),
//            answer4.heightAnchor.constraint(equalToConstant: 100),
//            answer4.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            answer4.bottomAnchor.constraint(equalTo: answer4.topAnchor,constant: 110)
//
        
        ])
        var previous: UIButton?
        for label in [answer1,answer2,answer3,answer4] {
            label!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            label!.heightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1,constant: 20).isActive = true
            
            if let previous = previous {
                label!.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
                //if we have a previous label, make the top anchor of this label equal to the bottom anchor of the previous label plus 10,(gornja Anchor jednaka je prehodnoj dodnjoj Anchor + 10pt razmak
            }else{
                label!.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true//if we add an else block we can push the first label away from the top of the safe area, so it doesn’t sit under the notch, like this.(ili je TopAnchor = safeArea + 0pt
            }
          previous = label
        }
       
      
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "High Score",style: .plain, target: self, action: #selector(showHighScore))
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "highScore") as? Int{
            self.highScore = savedData
        }
        
        askQuestion()
    }
    func askQuestion(){
    
        DispatchQueue.global().async { [self] in
                    
            if let levelFileURL = Bundle.main.url(forResource: "level11", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileURL){//1.pronasli 2.ucitali
                var lines = levelContents.components(separatedBy: "\n")//split all of our clues into individual lines we can read. Ceo dobijeni sadrzaj kao string text smo podelili u zasebne recenice
                lines.shuffle()// onda smo te zasebne linije pomesali da ne bi svaki put stajale u istom redu. Svaka linija (recenica) sadrzi odgovor i pojam na koji se odnosi
                
                for (_ ,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: " —")
                    let country = parts[0]
                    let city = parts [1]
                // pomocu ovoga indexovali smo svaku zasebnu liniju texta na dva dela rekavsi da delimo liniju pomocu dvotacke ":"(sve pre dvotacke je index[0] dok je sve posle dvotacke index[1])
                    questionCountry.append(country)
                    answerCity.append(city)
                
    }
                DispatchQueue.main.async { [self] in
                    
                    correctAnswer = Int.random(in: 0...3)
                    questionLabel.text = "Capital city of \(questionCountry[correctAnswer]) ?"
                    answer1.setTitle(answerCity[0], for: .normal)
                    answer2.setTitle(answerCity[1], for: .normal)
                    answer3.setTitle(answerCity[2], for: .normal)
                    answer4.setTitle(answerCity[3], for: .normal)
                    
                }
        }
        }
    }
        
        questionsAsked += 1
}
    @objc  func checkAnswer(button :UIButton!){
        if button.tag == correctAnswer{
            score += 1
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                button.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            }, completion: {_ in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
                    button.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            })
        } else {
            score -= 1
           shake(button: button)
        }
        
        if questionsAsked < 5{
            askQuestion()
        } else {
            let ac = UIAlertController(title: "Challenge is over", message: "Come again after 24h", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .default){ [weak self] _ in
                let vc = FirstViewControler()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            })
            present(ac, animated: true)
        }
        if score > highScore{
            highScore = score
            save()
            
        }
    }
   
    func shake(button: UIButton){
        let animate = CAKeyframeAnimation()
        animate.keyPath = "position.x"
        animate.values = [0, 10, -10,10,-5,5,-5,0]
        animate.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animate.duration = 0.4
        animate.isAdditive = true
    
        button.layer.add((animate), forKey: "shake")
}
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
    }
    
    @objc func showHighScore(){
        let ac = UIAlertController(title: " \(highScore)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        save()
        present(ac, animated: true)
    }
}
