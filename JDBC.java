import java.sql.*;

public class Assignment2 {

   
    // A connection to the database
    Connection connection;

    // Statement to run queries
    Statement sql;
    String sqlText;
    // Prepared Statement
    PreparedStatement ps;

    // Resultset for the query
    ResultSet rs;

    // CONSTRUCTOR
    Assignment2(


) {
    }

    // Using the input parameters, establish a connection to be used for this
    // session. Returns true if connection is sucessful
    public boolean connectDB(String URL, String username, String password) {
        try {
            connection = DriverManager.getConnection(URL, username, password);
            if (connection != null) {
              sql = connection.createStatement();
		sql.executeUpdate("SET search_path TO a2");
                return true;

            } else {
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    // Closes the connection. Returns true if closure was sucessful
    public boolean disconnectDB() {
        try {
            connection.close();
            if (connection.isClosed()) {
                rs.close();
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean insertCountry(int cid, String name, int height, int population) {



  try {
            sqlText = "SELECT *    FROM a2.country  WHERE cid=" + cid;
            rs = sql.executeQuery(sqlText);
            if (rs != null) { return false;}

else{
                sqlText = "INSERT INTO a2.country   VALUES (" + cid + ", " + name + ", " + height + ", " + population
                        + ")";
                int c = sql.executeUpdate(sqlText);
                if (c > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false; 
        
    }
    public int getCountriesNextToOceanCount(int oid) {
        try {
            int count = 0;
            sqlText = "SELECT * FROM oceanAccess  WHERE oid=" + oid;
            rs = sql.executeQuery(sqlText);
            if (rs != null) {
                while (rs.next()) {
                    ++count;
                }
            }
           
                return count;
            
        } catch (SQLException e) {
            return -1;
        }
    }

    public String getOceanInfo(int oid) {
        try {
            sqlText = "SELECT *   FROM ocean  WHERE oid=" + oid;
            rs = sql.executeQuery(sqlText);
            String temp = "";
            if (rs != null) {
                while (rs.next()) {
                    temp = rs.getInt("oid") + ":" + rs.getString("oname") + ":" + rs.getInt("depth") + "\n";
                }
                return temp;
            } else {
                return "";
            }
        } catch (SQLException e) {
            return "";
        }
    }

    public boolean chgHDI(int cid, int year, float newHDI) {
        try {
            sqlText = "UPDATE hdi      SET hdi_score =" + newHDI + " WHERE  cid =" + cid + " AND year="
                    + year;
            int c = sql.executeUpdate(sqlText);
            if (c > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean deleteNeighbour(int c1id, int c2id) {
       try {
            sqlText = "DELETE   FROM neighbour    WHERE (country= " + c1id + " OR country= " + c2id
                    + " ) AND (neighbor= " + c1id + " OR neighbor= " + c2id;
            int c = sql.executeUpdate(sqlText);
            if (c > 0) {
                return true;
            }
        } catch (SQLException e) {
           
            return false;
        }
        return false;
    }

    public String listCountryLanguages(int cid) {

     try {
           sqlText = "SELECT  l.lid AS lid, l.lname AS lname, ((l.lpercentage/100) * c.population) AS population    FROM a2.country AS c, a2.language AS l  WHERE c.cid=" + cid
                    + "  AND c.cid=l.cid   ORDER BY DESC";
            rs = sql.executeQuery(sqlText);
            String temp = "";
            if (rs != null) {
                while (rs.next()) {
                    temp = rs.getInt("lid") + ":" + rs.getString("lname") + ":" + rs.getInt("population")
                            + "\n";
                }
                return temp;
            } else {
                return "";
            }
	} catch (SQLException e) {
            return "";
        }
    }

    public boolean updateHeight(int cid, int decrH) {
        try {
            sqlText = "UPDATE country   SET height = height - " + decrH + " WHERE  cid = " + cid;
            int c = sql.executeUpdate(sqlText);
            if (c > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean updateDB() {
        try {
            sqlText = "CREATE TABLE mostPopulousCountries(        cid   INTEGER           REFERENCES A2.country(cid) ,                         cname  VARCHAR(20)  )";
            sql.executeUpdate(sqlText);
            sqlText = "SELECT cid, cname FROM country WHERE population > 1000000 ORDER BY cid ASC";
            rs = sql.executeQuery(sqlText);
            if (rs != null) {
                while (rs.next()) {
                    sqlText = "INSERT INTO mostPopulousCountries  VALUES (" + rs.getInt("cid") + ", "
                            + rs.getString("lname") + ")";
                    sql.executeUpdate(sqlText);
                }
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            
            return false;
        }
    }
}
