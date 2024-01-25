package mes2;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
			locations= {"file:src/main/webapp/WEB-INF/spring/*-context.xml"}
		)
public class test {
	
	private static final Logger logger = LoggerFactory.getLogger(test.class);
	
	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Test
	public void passwordEncode() {
		String pw = "1234";
		String encodedPassword = passwordEncoder.encode(pw);
		
		logger.debug("encodedPassword: " + encodedPassword);

	}
}
