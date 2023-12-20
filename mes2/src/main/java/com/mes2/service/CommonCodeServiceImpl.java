package com.mes2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.mes2.persistence.CommonCodeDAO;
import com.mes2.system.domain.CommonCodeDTO;




@Service
public class CommonCodeServiceImpl implements CommonCodeService {

	
	
	private static final Logger logger = LoggerFactory.getLogger(CommonCodeServiceImpl.class);
	
	
	
	@Inject
	private CommonCodeDAO cdao;


	//공통코드리스트
	@Override
	public List<CommonCodeDTO> getCommoncodeList(CommonCodeDTO dto) {
		logger.debug("S : 공통코드 리스트 DAO 메서드 호출!");
		
		List<CommonCodeDTO> resultDTO = cdao.getCommoncodeList(dto);
		
		return resultDTO;
	}

	
	

	// 공통코드 조회
	@Override
	public CommonCodeDTO CommoncodeInfo(int code_index) {
		logger.debug("S : 공통코드 조회 DAO 메서드 호출!");

		return cdao.getCommoncode(code_index);
	}










	// 공통코드 수정
	@Override
	public void commoncodeUpdate(CommonCodeDTO dto) {
		logger.debug("S : 공통코드 수정 DAO 메서드 호출!");

		cdao.updateCommonCode(dto);
			
	}



	// 공통코드 등록
	@Override
	public void insertCommonCode(CommonCodeDTO dto) {
		logger.debug("S : 공통코드 등록 DAO 메서드호출!");

		cdao.insertCommonCode(dto);
	}



	// 공통코드 삭제
	@Override
	public int deleteCommonCode(CommonCodeDTO dto) {
		logger.debug("S : 공통코드 삭제 DAO 메서드호출!");

		return cdao.deleteCommonCode(dto);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
