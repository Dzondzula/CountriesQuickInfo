
import UIKit
class Challenge: UIViewController {

    var countriess = [CountriesFinal]()
    
    var scoreLabel: UILabel!
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
    var Cindex = 1
    var correct  : Int!
   var questionsAsked = 0

    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .center
        scoreLabel.layer.borderWidth = 1
        scoreLabel.layer.borderColor = UIColor.gray.cgColor
        scoreLabel.sizeToFit()
        scoreLabel.text = "Score:"
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
        answer1.tag = 0
        answer1.tintColor = .red
        view.addSubview(answer1)
        
        answer2 = UIButton(type: .system)
        answer2.translatesAutoresizingMaskIntoConstraints = false
        answer2.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer2.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        answer2.tag = 1
        answer2.tintColor = .brown
        view.addSubview(answer2)
      
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: answer2.frame.size.width, height: 120))
        self.answer2.addSubview(topBorder)
        topBorder.backgroundColor = UIColor.blue
        
        
        
        answer3 = UIButton(type: .system)
        answer3.translatesAutoresizingMaskIntoConstraints = false
        answer3.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer3.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        answer3.sizeToFit()
        answer3.tag = 2
        answer3.tintColor = .cyan
        view.addSubview(answer3)
        
        answer4 = UIButton(type: .system)
        answer4.translatesAutoresizingMaskIntoConstraints = false
        answer4.titleLabel?.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        answer4.addTarget(self, action: #selector(checkAnswer(button:)), for: .touchUpInside)
        answer4.tag = 3
        view.addSubview(answer4)
        
      
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
           
            scoreLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -140),
           
            
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 25),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 25),
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
        for label in [answer1,answer2,answer3,answer4].shuffled() {
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
        fetch { [weak self]result in
              switch result{
              case . failure(let error):
                  print(error)
              case .success(let holidays):
                  self?.countriess = holidays
                 
              }
            self?.askQuestion()
        }
       
        //performSelector(inBackground: #selector(fetch), with: nil)
        
        
        
    }
    func fetch(completion: @escaping (Result<[CountriesFinal], CountryError>)-> Void){
    let urlString = "https://raw.githubusercontent.com/Dzondzula/Dzondzula.github.io/main/Globus.json"
    //"ttp://api.countrylayer.com/v2/all?access_key=88e5f402e6864cc63ff8378ee100f32b"
    let url = URL(string:urlString)!
    
    
       let _ = URLSession.shared.dataTask(with: url){ data, _, _ in
           guard let jsonData = data else {
               completion(.failure(.noDataAvailable))
               return
           }
           do {
               let decoder = JSONDecoder()
               let countriesResponse = try decoder.decode(Country.self, from: jsonData)
               let countryDetails = countriesResponse.countries
               completion(.success(countryDetails))

           } catch {
               completion(.failure(.canNotProcessData))
           }
       }.resume()
        
    
    }
    enum CountryError: Error{
       case noDataAvailable
       case canNotProcessData
    }
 func askQuestion(){
        DispatchQueue.global().async { [ self] in
        
         Cindex = Int.random(in: 0..<countriess.count)
            
              print("What is the capital of \(countriess[Cindex].name)?")
              var choices = [Cindex]

              print(choices)
              while choices.count < 4 {
                  let newIndex = Int.random(in: 0..<countriess.count)
                 if !choices.contains(newIndex)  {
                     choices.append(newIndex)
                     
                 }
                  choices.shuffle()
              }
            print("All choices \(choices)")
            for (index,value) in choices.enumerated(){
          if value == Cindex{
             correct = index
              print("Corret index:\(correct!)")
             }
          }

        DispatchQueue.main.async{
            
            questionLabel.text = "What is the capital of \(countriess[Cindex].name)?"
              choices.forEach { _ in
                  answer1.setTitle(countriess[choices[0]].capital, for: .normal)
                  answer2.setTitle(countriess[choices[1]].capital, for: .normal)
                  answer3.setTitle(countriess[choices[2]].capital, for: .normal)
                  answer4.setTitle(countriess[choices[3]].capital, for: .normal)
                  
              }
            choices.removeAll()//we need to have empty array of choices at the beggining of every new question so we can again populate it with answers
        }
        }
 
        questionsAsked += 1
        
            }
    @objc  func checkAnswer(button :UIButton!){
        print("Cindex value you should clicked: \(Cindex)")
        if button.tag == correct {//ne moze Cindex mora 0 jer smo taj broj zadali da bude kao tacan s obzirom da je u choice Cindex uvek na prvom mestu tj index 0
            score += 1
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                button.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            }, completion: {_ in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
                    button.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            })
            
                for buttonk in [answer1,answer2,answer3,answer4]{
                    buttonk?.isUserInteractionEnabled = false
           
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
                    for buttonk in [self.answer1,self.answer2,self.answer3,self.answer4]{
                        buttonk?.isUserInteractionEnabled = true
                    }
                    self.askQuestion()
                    
                }
                
            
            
        } else {
            print("Value you clicked\(button.tag)")
            score -= 1
           shake(button: button)
            
                for buttonk in [answer1,answer2,answer3,answer4]{
                    buttonk?.isUserInteractionEnabled = false
           
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [ self] in
                    for buttonk in [answer1,answer2,answer3,answer4]{
                        buttonk?.isUserInteractionEnabled = true
                    }
                    askQuestion()
                    
                }
                
            
        }
        
        if questionsAsked == 10{
            for buttonk in [answer1,answer2,answer3,answer4]{
                buttonk?.isEnabled = false
                Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(enableButton), userInfo: nil, repeats: false)
            }
            let ac = UIAlertController(title: "Challenge is over", message: "Come again after 10 minutes", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .default){ [weak self] _ in
                
                self?.navigationController?.popToRootViewController(animated: true)
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
        let ac = UIAlertController(title: "High score is: \(highScore)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        save()
        present(ac, animated: true)
    }
    
    @objc func enableButton(){
        for buttonk in [answer1,answer2,answer3,answer4]{
            buttonk?.isEnabled = true
        }
    }
}



//DispatchQueue.global().async { [self] in
//
//    if let levelFileURL = Bundle.main.url(forResource: "level11", withExtension: "txt"){
//    if let levelContents = try? String(contentsOf: levelFileURL){
//        var lines = levelContents.components(separatedBy: "\n")//split all of our clues into individual lines we can read. Ceo dobijeni sadrzaj kao string text smo podelili u zasebne recenice
//        lines.shuffle()// onda smo te zasebne linije pomesali da ne bi svaki put stajale u istom redu. Svaka linija (recenica) sadrzi odgovor i pojam na koji se odnosi
//
//        for (_ ,line) in lines.enumerated(){
//            let parts = line.components(separatedBy: " —")
//            let country = parts[0]
//            let city = parts [1]
//
//            questionCountry.append(country)
//            answerCity.append(city)
//
//}
//        DispatchQueue.main.async { [self] in
//
//            correctAnswer = Int.random(in: 0...3)
//            questionLabel.text = "Capital city of \(questionCountry[correctAnswer]) ?"
//            answer1.setTitle(answerCity[0], for: .normal)
//            answer2.setTitle(answerCity[1], for: .normal)
//            answer3.setTitle(answerCity[2], for: .normal)
//            answer4.setTitle(answerCity[3], for: .normal)
//
//        }
//}
//}
//}
//
//questionsAsked += 1
//}


