package dbServices;

import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class InsertSetData {

    private DatabaseConnectionService dbService = null;

    public InsertSetData(DatabaseConnectionService dbService) {
        this.dbService = dbService;
    }

    public boolean addBrick(String SetID, String LegoBrick, int Quantity) {
        Connection con = this.dbService.getConnection();
        CallableStatement cs;
        try {
            cs = con.prepareCall("{ ? = call insert_Contains(@SetID = ?, @LegoBrick = ?, @Quantity = ?) }");
            cs.registerOutParameter(1,  Types.INTEGER);
            cs.setString(2, SetID);
            cs.setString(3, LegoBrick);
            cs.setInt(4,  Quantity);

            cs.execute();

            int returnValue = cs.getInt(1);
            if(returnValue != 0) {
                String errorString;
                if(returnValue == 1) {
                    errorString = "The @Set is null. It must not be null.";
                } else if (returnValue == 2) {
                    errorString = "The @LegoBrick is null. It must not be null.";
                } else if (returnValue == 3) {
                    errorString = "The @Quantity is null or less than 0. It must not be null or less than 0.";
                } else if (returnValue == 4) {
                    errorString = "A set with the ID @SetID does not exist in the LegoSet table.";
                } else if (returnValue == 5) {
                    errorString = "A brick with the ID @LegoBrick does not exist in the LegoBrick table.";
                } else if (returnValue == 5) {
                    errorString = "An entry with SetID @SetID and LegoBrick @LegoBrick already exists in the table.";
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
