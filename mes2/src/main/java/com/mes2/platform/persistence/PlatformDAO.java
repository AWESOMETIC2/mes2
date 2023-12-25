package com.mes2.platform.persistence;

import java.util.List;

import com.mes2.platform.domain.MdbDTO;
import com.mes2.platform.domain.MdpDTO;
import com.mes2.platform.domain.SoiDTO;
import com.mes2.platform.domain.SopDTO;

public interface PlatformDAO {
	// 로그인
	public MdbDTO customerLogin(MdbDTO mdto) throws Exception;
	
	// 발주 신청 시 품목 목록 조회
	public List<MdpDTO> inqueryProduct(String searchType, String search) throws Exception;
	
	// 품목 하나 등록
	public MdpDTO registProduct(String product_code) throws Exception;
	
	// 발주 신청
	public void insertOrder(SoiDTO soiDTO, List<SopDTO> sopList);
	
	// 금일 주문건 개수
	public int countTodayOrder(String todayDate) throws Exception;
}
