package com.mes2.production.persistence;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mes2.production.domain.ProductionLineDTO;

@Repository
public class ProductionLineDAOImpl implements ProductionLineDAO {

	private final String NAMESPACE ="com.mes2.mapper.ProductionLine";
	private Logger log = LoggerFactory.getLogger(ProductionLineDTO.class);
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertProductionLine(ProductionLineDTO lineDTO) {
		return sqlSession.insert(NAMESPACE+".insertProductionLine", lineDTO);
		
	}

	@Override
	public List<ProductionLineDTO> selectByDate(Date startDate, Date endDate) {
		
		Map<String, Date> paramMap = new HashMap<String, Date>(); 
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		return sqlSession.selectList(NAMESPACE+".selectByDateForList", paramMap);
	}

	@Override
	public ProductionLineDTO selectByIsCode(String isCode) {
		return sqlSession.selectOne(NAMESPACE+".selectByIsCode",isCode);
	}

	@Override
	public int updateState(ProductionLineDTO productionLineDTO) {
		log.debug(" 생산라인 업데이트");
		return sqlSession.update(NAMESPACE+".updateState", productionLineDTO);
		
	}

	@Override
	public int updateComplete(ProductionLineDTO productionLineDTO) {
		return sqlSession.update(NAMESPACE+".updateComplete", productionLineDTO);
	}

	@Override
	public List<ProductionLineDTO> selectByDateForProduce(Date startDate) {
		return sqlSession.selectList(NAMESPACE+".selectByDateForProduce", startDate);
	}

	
	
	
	
	
	
}
