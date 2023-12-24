package com.mes2.metadata.persistence;


import java.sql.Date;
import java.util.List;

import com.mes2.metadata.domain.md_productDTO;

public interface MetadataDAO {
	
	public List<md_productDTO> getproductListAll() throws Exception;
	
	public List<md_productDTO> getproductdatefilter(Date start, Date end, String searchName) throws Exception;
	
}