package test;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MysqlDB {
	
    final String DRIVER = "com.mysql.cj.jdbc.Driver";
    final String URL = "jdbc:mysql://127.0.0.1:3306/devfox";
    final String USER = "DEVFOX";
    final String PASSWORD = "1234";
    
	@Test
    public void mysqlTest() throws Exception {
        Class.forName(DRIVER);
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Connection Success: " + conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}