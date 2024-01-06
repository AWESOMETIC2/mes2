package com.mes2.materials.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mes2.materials.domain.Criteria;
import com.mes2.materials.domain.InDTO;
import com.mes2.materials.domain.PurchaseDTO;
import com.mes2.materials.domain.SearchDTO;
import com.mes2.materials.domain.productDTO;

@Repository
public class InDAOImpl implements InDAO {

	private static final Logger logger = LoggerFactory.getLogger(InDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE ="com.mes2.mapper.MaterialsMapper";


	@Override
	public List<InDTO> getAllInboundInfo(String searchType, String keyword, Criteria cri, SearchDTO sdto) throws Exception {
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchType", searchType);
		searchMap.put("keyword", keyword);
		searchMap.put("cri", cri);
		searchMap.put("sdto", sdto);
	    
		return sqlSession.selectList(NAMESPACE + ".getInList", searchMap);
	}
	

	@Override
    public void InupdateQuantity(String product_code, int quantity, String category) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("product_code", product_code);
        paramMap.put("quantity", quantity);
        paramMap.put("category", category);

        sqlSession.update(NAMESPACE + ".StockupdateQuantity", paramMap);
    }

	@Override
	public int getInCount(Criteria cri, String searchType, String keyword) throws Exception {
		 Map<String, Object> paramMap = new HashMap<>();
		 paramMap.put("cri", cri); 
		 paramMap.put("searchType", searchType); 
		 paramMap.put("keyword", keyword);
		return sqlSession.selectOne(NAMESPACE + ".InCount", paramMap);
	}
	
	@Override
	public List<InDTO> searchIn(String searchType, String keyword, Criteria cri) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("searchType", searchType);
		paramMap.put("keyword", keyword);
		paramMap.put("startPage", cri.getStartPage());
		paramMap.put("pageSize", cri.getPageSize());
		
		return sqlSession.selectList(NAMESPACE + ".getInList", paramMap);
	}
	
	@Override
	public int updateInStatus(String status, int in_index) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("status", status);
		params.put("in_index", in_index);

		return sqlSession.update(NAMESPACE + ".updateInStatus", params);
	}


	@Override
	public productDTO listIncomingProductCodes(String product_code) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("product_code", product_code);

		return sqlSession.selectOne(NAMESPACE + ".listIncomingProductCodes", paramMap);
	}


	@Override
	public List<productDTO> getIncomingProductCodesByCategory(String category) throws Exception {
		Map<String, Object> parammap = new HashMap<>();
		parammap.put("category", category);
		
		return sqlSession.selectList(NAMESPACE + ".getIncomingProductCodesByCategory", parammap);
	}


	@Override
	public void insertIncomingRequest(InDTO idto) throws Exception {
		System.out.println("발주신청");
		sqlSession.insert(NAMESPACE + ".insertIncomingRequest", idto);
	}
	
	

}
