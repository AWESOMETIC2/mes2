package com.mes2.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.mes2.security.CustomLoginSuccessHandler;
import com.mes2.security.CustomUserDetailsService;
import com.mes2.security.CustomNoopPasswordEncoder;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);
	
	@Override
	public void configure(HttpSecurity http) throws Exception {
		logger.debug("시큐리티 실행");
		
		http
			.authorizeRequests()
				.antMatchers("/platform/login").permitAll()
				.anyRequest().authenticated()
				.and()
			.formLogin()
				.loginPage("/platform/login")
				.loginProcessingUrl("/platform/login")
				.usernameParameter("company_code")
				.passwordParameter("pw")
				.successHandler(loginSuccessHandler())
				.permitAll()
				.and()
			.logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/platform/logout"))
				.logoutSuccessUrl("/platform/login")
				.invalidateHttpSession(true)
				.permitAll();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**", "/css/**", "/js/**", "/images/**");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		logger.debug("권한 확인");
		
		auth.userDetailsService(customUserService())
		.passwordEncoder(passwordEncoder());
	}

	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new CustomLoginSuccessHandler();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
//		return new CustomNoopPasswordEncoder();
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public UserDetailsService customUserService() {
		return new CustomUserDetailsService();
	}
}