package com.amc.service.purchase.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.amc.common.Search;
import com.amc.service.domain.Purchase;
import com.amc.service.purchase.PurchaseDAO;

@Repository("purchaseDAOImpl")
public class PurchaseDAOImpl implements PurchaseDAO{
	
	/*Field*/
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public PurchaseDAOImpl() {
		System.out.println(this.getClass());
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"+purchase);
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		for(int i=1;i<purchase.getOrderStock();i++){
			System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+purchase);
			sqlSession.insert("PurchaseMapper.addPurchaseCount", purchase);
		}
	}
	
	@Override
	public Purchase getPurchase(Purchase purchase) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase",purchase);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search) throws Exception {
		System.out.println("purchaseDAOImpl 의 getPurchaseList 메소드의 search :"+search);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount", search));
		System.out.println("::::: getTotalCount return 값 :"+map);
		map.put("list", sqlSession.selectList("PurchaseMapper.getPurchaseList", search));
		System.out.println("purchaseDAOImpl 의 getPurchaseList 메소드의 map :"+ map);
		return map;
	}

	
	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.delete("PurchaseMapper.deletePurchaseForUpdate", purchase.getImpId());
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
		
		for(int i=1;i<purchase.getOrderStock();i++){
			sqlSession.insert("PurchaseMapper.insertPurchaseForUpdate", purchase);
		}
	}
}
