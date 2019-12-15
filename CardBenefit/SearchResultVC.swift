//
//  SearchResultVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 2019/12/07.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class SearchResultVC: UITableViewController{

    //검색옵션에서 선택한 값들을 넘겨받을 변수를 정의한다
    var cardName: Bool!
    var nickName: Bool!
    var memo: Bool!
    var condition: Bool!
    var shop: Bool!
    var restriction: Bool!
    var benefit: Bool!
    //검색창에 입력한 검색어
    var keyWord: String!
    
    
    //갹 섹션의 갯수가 몇개인지 저장해놀 변수들을 정의하자
    var cardNameCount: Int = 0
    var nickNameCount: Int = 0
    var memoCount: Int = 0
    var conditionCount: Int = 0
    var shopCount: Int = 0
    var restrictionCount: Int = 0
    var benefitCount: Int = 0
    
    //각 섹션에 들어갈 카드정보를 저장해놀 변수들을 정의하자.
    var cardNameResults: [CardRecord]!
    var nickNameResults: [CardRecord]!
    var memoResults: [CardRecord]!
        //튜플은 순서대로 카드명, 별칭, 카드사용조건, 카드id, 카드사진임
    var conditionResults: [(String, String, String, Int, String)]!
        //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
    var shopResults: [(String, String, String, String, String, Int, String)]!
        //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
    var restrictionResults: [(String, String, String, String, String, Int, String)]!
        //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
    var benefitResults: [(String, String, String, String, String, Int, String)]!
    
    
    
    
    //디비사용하기 위한 객체 선언
    let cardDAO = CardDAO()
    
    //디비입력을 받으려고 정의한 객체들
    typealias CardRecord = (Int, String, String?, String?, Int, Int, String?, Int)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //DAO사용해서 데이터를 읽어온다. 읽어온녀석은 위의 변수들에 저장한다.
        if self.cardName == true {
            //DAO에서 검색한 값 읽어오기
            self.cardNameResults = self.cardDAO.searchCardName(keyWord: self.keyWord)
            //검색결과 개수를 저장한다.
            self.cardNameCount = self.cardNameResults.count
            //잘 되고 있는가 체크하기 위해서 적어놈
            print("cardNameCount = \(self.cardNameCount)")
        }
        if self.nickName == true {
            self.nickNameResults = self.cardDAO.searchNickName(keyWord: self.keyWord)
            self.nickNameCount = self.nickNameResults.count
            
            print("nickNameCount = \(self.nickNameCount)")
            
        }
        if self.memo == true {
            self.memoResults = self.cardDAO.searchMemo(keyWord: self.keyWord)
            self.memoCount = self.memoResults.count
            
            print("memoCount = \(self.memoCount)")
        }
        if self.condition == true {
            self.conditionResults = self.cardDAO.searchCondition(keyWord: self.keyWord)
            self.conditionCount = self.conditionResults.count
            
            print("conditionCount = \(self.conditionCount)")
        }
        if self.shop == true {
            self.shopResults = self.cardDAO.searchShop(keyWord: self.keyWord)
            self.shopCount = self.shopResults.count
            
            print("shopCount = \(self.shopCount)")
        }
        if self.restriction == true {
            self.restrictionResults = self.cardDAO.searchRestrict(keyWord: self.keyWord)
            self.restrictionCount = self.restrictionResults.count
            
            print("restrictionCount = \(self.restrictionCount)")
        }
        if self.benefit == true {
            self.benefitResults = self.cardDAO.searchBenefit(keyWord: self.keyWord)
            self.benefitCount = self.benefitResults.count
            
            print("benefitCount = \(self.benefitCount)")
        }
        
    }
    
    //테이블 섹션의 개수를 결정하는 메소드...
    //맨 첨에는 검색설정에 따라 반환값바뀌게 하였으나 에러나서 고정값으로 설정함
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
    
    }
    
    //테이블 행의 개수를 결정하는 메소드
    //각각의 섹션에 해당하는 검색결과의 갯수만큼을 return 해야 한다.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if self.cardName == true {
                
                return self.cardNameCount
            }else{
                print("cardName : return 0")
                return 0
            }
        case 1:
            if self.nickName == true {
                
                return self.nickNameCount
            }else{
                print("nickName : return 0")
                return 0
            }
        case 2:
            if self.memo == true {
                
                return self.memoCount
            }else{
                print("memo : return 0")
                return 0
            }
        case 3:
            if self.condition == true {
                
                return self.conditionCount
            }else{
                print("condition : return 0")
                return 0
            }
        case 4:
            if self.shop == true {
                
                return self.shopCount
            }else{
                print("shop : return 0")
                return 0
            }
        case 5:
            if self.restriction == true {
                
                return self.restrictionCount
            }else{
                print("restriction : return 0")
                return 0
            }
        case 6:
            if self.benefit == true {
                
                return self.benefitCount
            }else{
                print("benefit : return 0")
                return 0
            }
        default:
            print("go default")
            return 1
        }
    }
    
    //각행에 어떤녀석들이 들어갈것인지!!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNameCell") as! ResultNameCell
            
            //여기안에 디비에서 받아온 정보를 가지고 각 셀 안의 데이터를 입력해준다.
            
            //db에서 읽어온 데이터중 행에 맞는녀석을 뽑아온다
            //들어있는순서대로 cardId, cardName, image, nickName, traffic, oversea, memo, orders
            let rowData = self.cardNameResults[indexPath.row]
            //cell안에 데이터를 집어넣는다.
                //cardImage는 구현후 집어넣는걸로 하자 ㅜㅜ
            
            //cardName의 tag속성에 cardId값을 집어넣는다.
            cell.cardName.tag = rowData.0
            cell.cardName.text = rowData.1
            cell.nickName.text = rowData.3
            cell.traffic.text = "\(rowData.4)"
            cell.oversea.text = "\(rowData.5)"
 
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNickNameCell") as! ResultNickNameCell
            
            let rowData = self.nickNameResults[indexPath.row]
            
            
            cell.cardName.tag = rowData.0
            cell.nickName.text = rowData.3
            cell.cardName.text = rowData.1
            cell.traffic.text = "\(rowData.4)"
            cell.oversea.text = "\(rowData.5)"
 
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultMemoCell") as! ResultMemoCell
            
            let rowData = self.nickNameResults[indexPath.row]
            
            
            cell.cardName.tag = rowData.0
            cell.nickName.text = rowData.3
            cell.cardName.text = rowData.1
            cell.memo.text = rowData.6
 
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultConditionCell") as! ResultConditionCell
            
            //튜플은 순서대로 카드명, 별칭, 카드사용조건, 카드id, 카드사진임
            let rowData = self.conditionResults[indexPath.row]
            
            
            let nameWithNickName = "\(rowData.0), \(rowData.1)"
            //여기에는 cardName 대신 cardNameWithNickName에 태그속성에 cardId를 넣는다
            cell.cardNameWithNickName.tag = rowData.3
            cell.cardNameWithNickName.text = nameWithNickName
            cell.condition.text = rowData.2
 
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultShopCell") as! ResultShopCell
            
            //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
            let rowData = self.shopResults[indexPath.row]
            
            
            let nameWithNickName = "\(rowData.0), \(rowData.1)"
            cell.cardNameWithNickName.tag = rowData.5
            cell.cardNameWithNickName.text = nameWithNickName
            let sar = "\(rowData.2), \(rowData.3), \(rowData.4)"
            cell.SAR.text = sar
 
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultBenefitCell") as! ResultBenefitCell
            
            //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
            let rowData = self.benefitResults[indexPath.row]
            
            
            let nameWithNickName = "\(rowData.0), \(rowData.1)"
            cell.cardNameWithNickName.tag = rowData.5
            cell.cardNameWithNickName.text = nameWithNickName
            let asr = "\(rowData.3), \(rowData.2), \(rowData.4)"
            cell.ASR.text = asr
 
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultRestrictionCell") as! ResultRestrictionCell
            
            //튜플 순서대로 카드명, 별칭, 상점명, 혜택, 제약, 카드id, 카드사진
            let rowData = self.restrictionResults[indexPath.row]
            
            let nameWithNickName = "\(rowData.0), \(rowData.1)"
            cell.cardNameWithNickName.tag = rowData.5
            cell.cardNameWithNickName.text = nameWithNickName
            let rsa = "\(rowData.4), \(rowData.2), \(rowData.3)"
            cell.RSA.text = rsa
 
            return cell
        default:
            //그냥 쓸거없어서 카드이름으로 찾는녀석으로해놈
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNickNameCell") as! ResultNickNameCell
            return cell
        }
    }
    
    
    //섹션에 타이틀만 넣을것이므로 다음의 메소드 사용한다
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "카드이름"
        case 1:
            return "별칭"
        case 2:
            return "메모"
        case 3:
            return "카드사용조건"
        case 4:
            return "상점명"
        case 5:
            return "혜택"
        case 6:
            return "제약"
        default:
            return "eat my shorts"
        }
    }
    
    //각행의 높이를 설정한다....셀안잘리게 해야됨
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           print("\(indexPath)행높이값 : \(UITableView.automaticDimension)")
           //시스템이 알이서 정하게 두는 방법
        return 90.0
           //각 섹션별로 다르게 주고싶은경우 알아서 숫자 입력
           /*
           switch indexPath.section {
           case 0 :
               return UITableView.automaticDimension
           case 1 :
               return UITableView.automaticDimension
           case 2 :
               return UITableView.automaticDimension
           case 3 :
               return UITableView.automaticDimension
           case 4 :
               return UITableView.automaticDimension
           case 5 :
               return UITableView.automaticDimension
           default :
               return UITableView.automaticDimension
           }
    */
       }
}
