package com.mes2.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class CustomNoopPasswordEncoder implements PasswordEncoder {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomNoopPasswordEncoder.class);
	
	@Override
	public String encode(CharSequence rawPassword) {
		// 암호화 동작 수행
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder.encode(rawPassword);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		// 암호화 된 비밀번호를 기존 비밀번호와 비교
		return rawPassword.equals(encodedPassword);
	}

}
