package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
	private static DB instance = new DB();
	
	public static DB getInstance() {
		return instance;
	}
	
	private DB() {}
	
	//데이터베이스 처리
	private final String HOST = "jdbc:mysql://127.0.0.1:3306/java1_college";
	private final String USER = "root";
	private final String PASS = "1234";
		
	public Connection getConnection() throws SQLException{
		// 1단계
		// 2단계
		return DriverManager.getConnection(HOST, USER, PASS);
	}
	
}
