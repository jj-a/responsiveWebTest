package net.utility;
import java.sql.*;

public class DBOpen {
	
	public Connection getConnection() {
		//Orace DB -------------------------------------------
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "java1113";
		String password = "1234";
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		//MySQL DB -------------------------------------------
		/*
		String url="jdbc:mysql://localhost:3306/soldesk?useUnicode=true&characterEncoding=utf8";
		String user="root";
		String password="1234";
		String driver="org.gjt.mm.mysql.Driver";
		*/

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);

			StringBuilder sql = new StringBuilder();

		} catch (Exception e) {
			System.out.println("** DB Connection Failed ** \n"+e);
		} finally {
		} //try end
		
		return con;

		
	}
	

}
