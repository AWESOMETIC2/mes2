package com.mes2.security;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.mes2.platform.domain.MdbDTO;
import com.mes2.platform.mapper.PlatformMapper;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Autowired
	private PlatformMapper platformMapper;
	
	@Inject
	private CustomNoopPasswordEncoder pwEncoder;
	public void setPlatformMapper(PlatformMapper platformMapper) {
        this.platformMapper = platformMapper;
    }
	
	@Override
	public UserDetails loadUserByUsername(String company_code) throws UsernameNotFoundException {
		logger.debug("UserDetails - loadUserByUsername() 호출");
		
		MdbDTO mdbDTO = platformMapper.read(company_code);
		
		
		UserDetails userDetails = User.builder().username(mdbDTO.getCompany_code())
				.password(mdbDTO.getPw())
				.authorities(mdbDTO.getAuth())
				.build();
		
		logger.debug("암호화: " + pwEncoder.encode(mdbDTO.getPw()));
		
		return userDetails;
	}

}
