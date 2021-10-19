//import UIKit
//let session = URLSession.shared
//let urlString = "https:gist.githubusercontent.com/keeguon/2310008/raw/bdc2ce1c1e3f28f9cab5b4393c7549f38361be4e/countries.json"
//let url = URL(string:urlString)!
//note that we’re assigning the return value of dataTask(with:completionHandler:) to the task constant
// completion handler is a bit more complicated. It’s a closure that’s executed when the request completes, so when a response has returned from the webserver. This can be any kind of response, including errors, timeouts, 404s, and actual JSON data.
//closure has three parameters: the response Data object, a URLResponse object, and an Error object. All of these closure parameters are optionals, so they can be nil.
//let task = session.dataTask(with: url) {data,response,error in
//   if let data = data  {
//       //data is a Data object, so it has no visual representation yet. We can convert or interpret it as JSON though
//       do {
//let json = try JSONSerialization.jsonObject(with: data, options: [])
//           //We’re using the jsonObject(with:options:) function of the JSONSerialization class to serialize the data to JSON. Essentially, the data is read character by character and turned into a JSON object we can more easily read and manipulate. It’s similar to how you read a book word by word, and then turn that into a story in your head.
//    print(json)
//           //ry? is a trick you can temporarily use to silence any errors from jsonObject(...). In short, errors can occur during serialization, and when they do, the return value of jsonObject(...) is nil, and the conditional doesn’t continue executing.So we are using catch statement as its the proper way to deal with errors so we dont need ? to try
//       } catch {
//           print("JSON error: \(error.localizedDescription)")
//       }
//
//}
//}.resume()
