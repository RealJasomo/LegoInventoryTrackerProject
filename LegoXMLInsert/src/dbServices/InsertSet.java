package dbServices;

import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class InsertSet {

	private DatabaseConnectionService dbService = null;

	public InsertSet(DatabaseConnectionService dbService) {
		this.dbService = dbService;
	}

	public boolean addSet(String id, String imageURL, String name)
	{
		Connection con = this.dbService.getConnection();
		CallableStatement cs;
		try {
			cs = con.prepareCall("{ ? = call insert_LegoSet(@ID = ?, @ImageURL = ?, @Name = ?) }");
			cs.registerOutParameter(1,  Types.INTEGER);
			cs.setString(2, id);
			cs.setString(3, imageURL);
			cs.setString(4,  name);
			
			cs.execute();
			
			int returnValue = cs.getInt(1);
			if(returnValue != 0) {
				String errorString;
				if(returnValue == 1) {
					errorString = "The @ID is null. It must not be null.";
				} else if (returnValue == 2) {
					errorString = "A set with the ID "+id+" already exists in the LegoSet table.";
				} else {
					errorString = "Unknown error.";
				}
				errorString = errorString + " Error: " + returnValue;
				System.out.println(errorString);
				return false;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
}
