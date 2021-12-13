//
//  ViewController.swift
//  TestCoreDataSimple
//
//  Created by active on 2021/10/15.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var PWField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteFetchDataAll(EntityName: "Member")
        // Do any additional setup after loading the view.
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        
        let entity = NSEntityDescription.entity(forEntityName: "Member", in: context)
        
        if let entity = entity {// ! 이런 방법이
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue("maple", forKey: "id")
            person.setValue("KangOne", forKey: "name")
            person.setValue("1", forKey: "pass")
            
            //entity.name = "hello"
            // 값을 저장할때만 이런식? 으로 쓴다고
            
            do {
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
         */
        
//        var test = ["11","22","33","11"]
//        test.removeAll{ value in return value == "1"}
//        print(test)
//        test.removeFirst()
//        print(test[0])
//        var con = DispatchQueue(label: "Hello")
//        let minique = MiniQueue()
//        minique.setMembers(members: test)
//        print(minique.getMembers())
//        print(minique.getMembers())
//        print(minique.getMembers())
//        print(minique.getMembers())
        
        
       // testBasic(a: 10, b: -9)
      
    }
//    func testBasic(a: Int , b:Int = -1){
//        print("Sum = " + String(a+b))
//    }
    func testNotificationCenter(){
        NotificationCenter.default.post(name: NSNotification.Name("Hello"), object: nil)
    }
    
    
    
    func returnFirstIndex( arra : [String]){
        if arra.count > 0 {
            print(arra[0])
//            arra.removeFirst()
        }
    }
    @IBAction func ClickSave(_ sender: Any) {// 저장해
        self.addCoreData(name: NameField.text ?? "", id: IDField.text ?? "", pass: PWField.text ?? "")
        
    }
    @IBAction func ClickDisplay(_ sender: Any) {// 저장된거 다 내놔
        self.fetchData()
    
    }
    
    @IBAction func ClickDelete(_ sender: Any) {//
        
        self.searchData(search: NameField.text ?? "")
    }
    
    @IBAction func ActionClick4(_ sender: Any) {
        // 단일 삭제 하는 법좀 찾자
        if NameField.text != nil && IDField.text != nil {
            OneDelete(userID: NameField.text!, Userfirst: IDField.text!)
            self.fetchData()
        }
        
    }
    
    func OneDelete(userID : String , Userfirst : String)
        {
            print("Fetching Data..")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
            request.returnsObjectsAsFaults = false
            //request.predicate = NSPredicate(format: "name == \(userID) AND id == \(Userfirst)")
            request.predicate = NSPredicate(format: "( name == %@ ) && ( id == %@ )", userID,Userfirst)
            do{
                let arrUser = try context.fetch(request)
                for user in arrUser as! [NSManagedObject]{
                    context.delete(user)
                }
            }catch{
                print("흑흑 이번에도 망했어")
            }
            do{
                try context.save()
            }catch{
                print("이젠 익숙해")
            }
            
        }
    func addCoreData(name : String , id : String , pass : String){
        print("저장 해야 뭘하지 ")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        let entity = NSEntityDescription.entity(forEntityName: "Member", in: context)
        
        if let entity = entity {// ! 이런 방법이
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(id, forKey: "id")
            person.setValue(name, forKey: "name")
            person.setValue(pass, forKey: "pass")
            
            // 값을 저장할때만 이런식? 으로 쓴다고
            
            do {
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            print("저장 총 량 : " + String(getCoreDataCount()))
        }
    }

    func getCoreDataCount() -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
        do{
            let count = try context.count(for: fetchRequest)
            return count
        }catch{
            print(error)
            return -1
        }
        
    }
    func fetchData()
        {
            print("Fetching Data..")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                   // print(data)//-> 이게 문제가 지금 타입이 다르다
                    
                    let userName = data.value(forKey: "name") as! String
                    let id = data.value(forKey: "id") as! String
                    let pass = data.value(forKey: "pass") as! String
                    print("User Name is : "+userName+" and id is : "+id  + " and pass is "+pass)
                }
            } catch {
                print("Fetching data Failed")
            }
            print("저장 총 량 : " + String(getCoreDataCount()))
        }
    func searchData(search : String)
        {
            print("Fetching Data..")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    let userName = data.value(forKey: "name") as! String
                    if(userName == search){
                        let id = data.value(forKey: "id") as! String
                        let pass = data.value(forKey: "pass") as! String
                        print("User Name is : "+userName+" and id is : "+id  + " and pass is "+pass)
                        return
                    }
                    
                }
                print("not Save Data")
            } catch {
                print("Fetching data Failed")
            }
        }
    func deleteFetchData(){
        print("삭제 하시게")
        
    }
    func deleteFetchDataAll(EntityName : String){
        print("다 삭제 하시게")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in error : \(error) \(error.userInfo)")
        }
        
    }
    
    @IBAction func ActionChange(_ sender: Any) {
        // 근데 저거 안통할것같은데?
      //  ChangeLocalData(EntityName: "Member", id: "id", newData: "Shoot")
        changeCoreLocalData(EntityName: "Member", type: "id", typeValue: "a", newValue: "abc")
        
    }
    func ChangeLocalData( EntityName : String , id: String , newData : String){
        print("데이터 바꿔 주세요")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do{
            let test = try context.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject // 이부분이 마음에 걸린다.
            //찾은 애들중에서 첫번째 애만 바꿈
            objectUpdate.setValue(newData, forKey: "pass")
            do{
                try context.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    
    func changeCoreLocalData(EntityName : String , type : String , typeValue: String , newValue : String){
        print("DBDase - changeLocalData")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        
        fetchRequest.predicate = NSPredicate(format: type + " = %@", typeValue)
        do{
            let changeResult = try context.fetch(fetchRequest)
            for searchOne in changeResult {
                let searchData = searchOne as! NSManagedObject
                searchData.setValue(newValue, forKey: type)
                do{
                    try context.save()
                }catch{
                    print("Failed Change Core Data " + error.localizedDescription)
                }
            }
            
        }catch{
            print("Failed Change Basic Core Data " + error.localizedDescription)
        }
        
        
    }
    
    /*실패한 코드 모음1
     
     
     var container : NSPersistentContainer!
     //
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     self.container = appDelegate.persistentContainer
     let entity = NSEntityDescription.entity(forEntityName: "Member", in: self.container.viewContext)
     
     let person = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
     person.setValue("angel", forKey: "id")
     person.setValue("천뭐", forKey: "name")
     person.setValue("123", forKey: "pass")
     
     do{
         try self.container.viewContext.save()// 이게 맞아?
        
     }catch{
         print(error.localizedDescription)
     }
     */
    
    /*실패한 코드 모음2
     //    func fetchContact(){// 이거 안됨
     //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     //        let context = appDelegate.persistentContainer.viewContext//보통 이렇게 쓴다고
     //        do{
     //            let contact = try context.fetch(Member.fetchRequest()) as! [Member]// 이름 조심
     //            contact.forEach{
     //                $0.name
     //            }
     //        }catch{
     //            print(error.localizedDescription)
     //        }
     //    }
     */
    
    
    
}

