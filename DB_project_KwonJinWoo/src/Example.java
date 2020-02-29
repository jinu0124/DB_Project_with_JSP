import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;
//package NewFile;//상위 폴더에 package가 없는경우 안써도 됨

public class Example {
	public static void main(String[] args)
	{
		int a = 1001;//ID 시작을 1001부터 하기 위함(update로 바꿔줬음)
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String create_table_statement =//material
				"CREATE TABLE IF NOT EXISTS material"
					+"(material_ID int NOT NULL primary key AUTO_INCREMENT,"
					+"material_name varchar(80) NOT NULL,"
					+"origin varchar(20) NOT NULL,"//원산지
					+"kind varchar(20) NOT NULL,"//종류 : 식물성, 동물성, 광물성 등
					+"price int NOT NULL check(price>=0));";
		String create_table_statement1 = //store
				"CREATE TABLE IF NOT EXISTS store"
						+"(store_ID int NOT NULL primary key AUTO_INCREMENT,"
						+"store_name varchar(80) NOT NULL,"
						+"address varchar(80) NOT NULL,"
						+"boss varchar(20) NOT NULL,"
						+"tribe varchar(20),"
						+"user_ST_ID varchar(100) unique,"
						+"user_pw varchar(60),"
						+"class_permit int NOT NULL check(0<class_permit<=10),"
						+"money int NOT NULL check(money>=0));";
		String create_table_statement2 = //consumer
				"CREATE TABLE IF NOT EXISTS consumer"
						+"(consumer_ID int NOT NULL primary key AUTO_INCREMENT,"
						+"Fname varchar(80) NOT NULL,"
						+"Lname varchar(80) NOT NULL,"
						+"age int NOT NULL check(age>=0),"
						+"address varchar(80) NOT NULL,"//references store on delete cascade on update cascade
						+"property varchar(20),"
						+"money int NOT NULL check(money>=0),"
						+"user_CS_ID varchar(100) unique,"
						+"user_pw varchar(60),"
						+ "Foreign key (property) references property(property) on delete cascade on update cascade);";
						//+ "foreign key address references store(address));";
		String create_table_statement3 = //magician
				"CREATE TABLE IF NOT EXISTS magician"
						+"(magician_ID int NOT NULL primary key AUTO_INCREMENT,"
						+"Fname varchar(80) NOT NULL,"
						+"Lname varchar(80) NOT NULL,"
						+"age int NOT NULL check(age>=0),"
						+"tribe varchar(20),"
						+"native varchar(80) NOT NULL,"//출신지
						+"job varchar(20),"
						+"class int NOT NULL check(10>=class>0),"
						+"property varchar(20) NOT NULL,"
						+"MP int NOT NULL check(MP>=0),"
						+"money int NOT NULL check(money>=0),"
						+"store_ID int,"
						+"user_MA_ID varchar(100) unique,"
						+"user_pw varchar(60),"
						+"Foreign key (property) references property(property) on delete cascade on update cascade,"
						+"Foreign key (store_ID) references store(store_ID) on delete cascade on update cascade);";
		String create_table_statement4 = //property
				"CREATE TABLE IF NOT EXISTS property"
				+"(property varchar(20) NOT NULL primary key,"
				+"check (property in('elder', 'water', 'fire', 'sun', 'wind', 'electron', 'sand', 'nightmare')));";
				/*+ "check(property='water'),"
				+ "check(property='fire'),"
				+ "check(property='sun'),"
				+ "check(property='wind'),"
				+ "check(property='electron'),"
				+ "check(property='nightmare'));";*/
				//check(char_length(property>2));
				//+ ");";//'water', 'fire', 'sun', 'wind', 'electron', 'sand', 'nightmare'));";
		String create_table_statement5 = //material have
				"CREATE TABLE IF NOT EXISTS material_have"
						+"(store_ID int NOT NULL,"
						+"material_ID int NOT NULL,"
						//+"material_name varchar(80) NOT NULL,"
						+"material_cnt int NOT NULL check(material_cnt>=0),"
						+"Foreign key (material_ID) references material(material_ID) on delete cascade on update cascade,"
						+"Foreign key (store_ID) references store(store_ID) on delete cascade on update cascade,"
						//+"Foreign key (material_name) references material(material_name) on delete cascade on update cascade,"
						+"Primary key (store_ID, material_ID));";
		String create_table_statement6 = //sale
				"CREATE TABLE IF NOT EXISTS sale_purchase"
						+"(trade_ID int NOT NULL primary key AUTO_INCREMENT,"
						+"store_ID int NOT NULL,"
						+"consumer_ID int NOT NULL,"//references store(store_ID) on delete cascade on update cascade,
						+"material_ID int,"
						+"magic_ID int,"
						+"count int check(count>0),"
						+"foreign key (magic_ID) references magic(magic_ID) on delete cascade on update cascade,"
						+"foreign key (material_ID) references material(material_ID) on delete cascade on update cascade,"
						+"foreign key (store_ID) references store(store_ID) on delete cascade on update cascade,"
						+"foreign key (consumer_ID) references consumer(consumer_ID) on delete cascade on update cascade);";
		String create_table_statement7 = //use_use
				"CREATE TABLE IF NOT EXISTS use_use"
						+"(magic_ID int NOT NULL,"
						+"material_ID int NOT NULL,"
						+"material_cnt int NOT NULL check(material_cnt>0),"
						+"foreign key (magic_ID) references magic(magic_ID),"
						+"foreign key (material_ID) references material(material_ID),"
						+"primary key (magic_ID, material_ID));";
		String create_table_statement8 = //magic_detail
				"CREATE TABLE IF NOT EXISTS magic_detail"
						+"(magic_name varchar(20) NOT NULL primary key,"
						+"magic_exp varchar(120),"
						+"kind varchar(20),"//종류 : 공격 , 방어, 치유, 도움 등등
						+"effect int,"//효과량
						+"MP_consume int NOT NULL check(MP_consume>=0));";
		String create_table_statement9 = //magic
				"CREATE TABLE IF NOT EXISTS magic"
						+"(magic_ID int NOT NULL primary key AUTO_INCREMENT,"
						+"class int NOT NULL check(10>=class>0),"
						+"property varchar(20) NOT NULL,"
						+"sale_price int NOT NULL check(sale_price>=0),"//효과량
						+"magician_ID int NOT NULL,"
						+"store_ID int NOT NULL,"
						+"magic_name varchar(20) NOT NULL,"
						+"foreign key (property) references property(property) on delete cascade on update cascade,"
						+"foreign key (magician_ID) references magician(magician_ID) on delete cascade on update cascade,"
						+"foreign key (store_ID) references store(store_ID) on delete cascade on update cascade,"
						+"foreign key (magic_name) references magic_detail(magic_name) on delete cascade on update cascade);";
						
		String create_table_statement10 = //persons(임시 테스트)
				"CREATE TABLE IF NOT EXISTS persons"
						+"(name varchar(20) NOT NULL primary key,"
						+"age int," 
						+"gender varchar(20) NOT NULL,"//
						+"check(gender in('Male', 'Female', 'Other')));";
		
		String create_table_statement11 = 
				"CREATE TABLE IF NOT EXISTS account"
				+"(consumer_ID int,"
				+"store_ID int,"
				+"primary key (consumer_ID, store_ID),"
				+"foreign key (store_ID) references store(store_ID) on delete cascade on update cascade,"
				+"foreign key (consumer_ID) references consumer(consumer_ID) on delete cascade on update cascade);";
		
		//+ "Age int," + "Name varchar(255));";//table 만들기 // AUTO_INCREMENT -> 해당 column을 1씩 증가시키면서 추가됨 Insert 시
		//AUTO_INCREMENT없이 table 생성했다가 이후 AUTO_INCREMENT를 써서 수행하면 됨, table 삭제 -> drop table
		//AUTO_INCREMENT
		//String insert_value_single = "Insert into Person(Age, Name) values(34, 'sam')";
		//PersonID는 primary key로 지정 했음 // -> 반복 수행하면 에러가 남 Primary key는 한개씩만 사용 가능
		String insert_single_value = "Insert into property(property) values(?)";
		String insert_value_statement = "Insert into material(material_name, origin, kind, price) values(?, ?, ?, ?)";
		String insert_value_statement1 = "Insert into store(store_name, address, boss, tribe, class_permit, money) values(?, ?, ?, ?, ?, ?)";
		String insert_value_statement2 = "Insert into consumer(Fname, Lname, age, address , property, money) values(?, ?, ?, ?, ?, ?)";
		String insert_value_statement3 = "Insert into material_have(store_ID, material_ID, material_cnt) values(?, ?, ?)";
		String insert_value_statement4 = "Insert into sale_purchase(store_ID, consumer_ID, material_ID, count) values(?, ?, ?, ?)";
		String insert_value_statement5 = "Insert into magician(Fname, Lname, age, tribe, native, job, class, property, MP, money, store_ID) values(?, ?, ?, ?, ?, ?, ?, ? ,? ,?, ?)";
		String insert_value_statement6 = "Insert into magic_detail(magic_name, magic_exp, kind, effect, MP_consume) values(?, ?, ?, ?, ?)";
		String insert_value_statement7 = "Insert into magic(class, property, sale_price, magician_ID, store_ID, magic_name) values(?, ?, ?, ?, ?, ?)";
		String insert_value_statement8 = "Insert into use_use(magic_ID, material_ID, material_cnt) values(?, ?, ?)";
		String insert_value_statement9 = "insert into sale_purchase(trade_ID, store_ID, consumer_ID, material_ID, count) values(1000, 1001, 1001, 1001, 1);";
		
		
		
		String update_material_1000 = "update material set material_ID = material_ID + 1000;";
		String update_store_1000 = "update store set store_ID = store_ID + 1000;";
		String update_consumer_1000 = "update consumer set consumer_ID = consumer_ID + 1000;";
		String update_trade_1000 = "update sale_purchase set trade_ID = trade_ID + 1000;";
		String update_magician_1000 = "update magician set magician_ID = magician_ID + 1000;";
		String update_magic_1000 = "update magic set magic_ID = magic_ID + 1000;";

		//Select * from instructor
		Statement stmt = null;
		PreparedStatement preStmt = null;//data 삽입을 용이하게 해줌
		Connection conn = null;
		
		try {
			String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
			try {
				Class.forName(driver);//등록
			}
			catch(ClassNotFoundException e)
			{
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			stmt = conn.createStatement();//statement에 넣기, 만들기
			//stmt.executeQuery(insert_single_value);
			stmt.executeQuery(create_table_statement4);//table create 만들기
			stmt.executeQuery(create_table_statement);//table create 만들기
			stmt.executeQuery(create_table_statement1);//table create 만들기
			stmt.executeQuery(create_table_statement2);//table create 만들기
			stmt.executeQuery(create_table_statement5);//table create 만들기
			stmt.executeQuery(create_table_statement8);//table create 만들기
			stmt.executeQuery(create_table_statement3);//table create 만들기
			stmt.executeQuery(create_table_statement9);//table create 만들기
			stmt.executeQuery(create_table_statement6);//table create 만들기
			stmt.executeQuery(create_table_statement7);//table create 만들기
			stmt.executeQuery(create_table_statement10);//table create 만들기
			stmt.executeQuery(create_table_statement11);//table create 만들기
			
			stmt.executeQuery(insert_value_statement9);
			//stmt.execute(insert_value_single);//insert 만들기
			
			preStmt = conn.prepareStatement(insert_single_value);//property
			String[] property = {"ELDER", "WATER", "FIRE", "SUN", "WIND", "ELECTRON", "SAND", "NIGHTMARE"};
			
			for(int i=0; i<property.length; i++)
			{
				preStmt.setString(1, property[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();
			}
			
			preStmt = conn.prepareStatement(insert_value_statement);//material

			//file을 읽어와서 배열화 하여 넣기도 삽가능
			//int [] material_ID = {1000, 1001, 1002, 1003, 1004};
			String [] material_name_MA = {"IRON", "ICE", "DBbook", "COTTON", "INFRARED"};
			String [] originMA = {"MINE", "ISLAND", "468", "KOREA", "SUN"};
			String [] kindMA = {"EARTH","EARTH","PLANT","PLANT", "LIGHT"};
			int [] price = {150, 120, 55, 30, 210};
			for( int i = 0; i< material_name_MA.length; i++)
			{
				//preStmt.setInt(1, material_ID[i]);
				preStmt.setString(1, material_name_MA[i]);
				preStmt.setString(2, originMA[i]);
				preStmt.setString(3, kindMA[i]);
				preStmt.setInt(4, price[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();//파라미터 초기화 필요 -> update후 넣은 상태가 남아있음, 따라서 param 초기화
			}
			
			preStmt = conn.prepareStatement(insert_value_statement1);//store
			//int [] store_ID = {1000, 1001, 1002, 1003, 1004};
			String [] store_name_ST = {"CHANEL", "GUCCI", "COUCH", "TORRI", "BURBERRY"};
			String [] addressST = {"SHADOW", "PILTOVER", "BOOMHILL", "CRAZYPARK", "NORTHEU"};
			String [] bossST = {"THRESH","CAMILLE","BAZZI", "MARID", "TAKKI"};
			String [] tribeST = {"MONSTER", "KNIGHT", "IDIOT", "ROYALTY", "ALIEN"};
			int [] class_permit_ST = {10, 8, 10, 6, 7};
			int [] moneyST = {4600, 2500, 1840, 3000, 2850};
			for( int i = 0; i< store_name_ST.length; i++)
			{
				//preStmt.setInt(1, store_ID[i]);
				preStmt.setString(1, store_name_ST[i]);
				preStmt.setString(2, addressST[i]);
				preStmt.setString(3, bossST[i]);
				preStmt.setString(4, tribeST[i]);
				preStmt.setInt(5, class_permit_ST[i]);
				preStmt.setInt(6, moneyST[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();//파라미터 초기화 필요 -> update후 넣은 상태가 남아있음, 따라서 param 초기화
			}

			preStmt = conn.prepareStatement(insert_value_statement2);//consumer
			//int [] consumer_ID = {1000, 1001, 1002, 1003, 1004};
			String [] FnameCS = {"KWON", "LEE", "JEON", "YANG", "KIM"};
			String [] LnameCS = {"JINWOO", "JIHOON", "JUNHYUNG", "JEHA", "KYUNGHOON"};
			int [] ageCS = {24, 25, 27, 20, 17};
			String [] addressCS = {"BOOMHILL","CRAZYPARK","NORTHEU","SHADOW", "PILTOVER"};
			String [] propertyCS = {"WATER", "WIND", "SUN", "FIRE", "ELECTRON"};
			int [] moneyCS = {8400, 500, 270, 13000, 5850};
			for( int i = 0; i< FnameCS.length; i++)
			{
				//preStmt.setInt(1, consumer_ID[i]);
				preStmt.setString(1, FnameCS[i]);
				preStmt.setString(2, LnameCS[i]);
				preStmt.setInt(3, ageCS[i]);
				preStmt.setString(4, addressCS[i]);
				preStmt.setString(5, propertyCS[i]);
				preStmt.setInt(6, moneyCS[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();//파라미터 초기화 필요 -> update후 넣은 상태가 남아있음, 따라서 param 초기화
			}
			
			stmt.executeQuery(update_material_1000);
			stmt.executeQuery(update_store_1000);
			stmt.executeQuery(update_consumer_1000);
			
			preStmt = conn.prepareStatement(insert_value_statement3);//material_have
			int [] store_ID_MH = {1001, 1001, 1001, 1001, 1001, 1002, 1002, 1002, 1002, 1003,1003,1003,1003,1003,1004,1004,1004,1004,1004, 1005,1005};
			int [] material_ID_MH = {1001, 1002, 1003, 1004, 1005, 1001, 1002, 1003, 1005, 1001,1002,1003,1004,1005,1001,1002,1003,1004,1005, 1002,1005};
			int [] material_cnt_MH = {3,4,5,4,10,7,6,4,7,7,5,4,6,8,9,1,2,4,5,4,8};
			
			for(int i=0; i<material_cnt_MH.length; i++)
			{
				preStmt.setInt(1, store_ID_MH[i]);
				preStmt.setInt(2, material_ID_MH[i]);
				preStmt.setInt(3, material_cnt_MH[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();
			}
			stmt.executeQuery(update_trade_1000);
			
			/*preStmt = conn.prepareStatement(insert_value_statement4);//sale purchase
			int [] store_ID_SP = {1001,1001,1001,1001,1001, 1002,1002,1002,1002,1002, 1003,1003,1003,1003,1003, 1004,1004,1004,1004,1004, 1005,1005,1005,1005,1005};
			int [] consumer_ID_SP = {1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005};
			int [] material_ID_SP = {1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005};
			int [] count_SP = {1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005, 1001,1002,1003,1004,1005};

			for(int i=0; i<store_ID_SP.length; i++)
			{
				preStmt.setInt(1, store_ID_SP[i]);
				preStmt.setInt(2, consumer_ID_SP[i]);
				preStmt.setInt(3, material_ID_SP[i]);
				preStmt.setInt(4, count_SP[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();
			}*/
			
			preStmt = conn.prepareStatement(insert_value_statement5);//magician
			String [] FnameMA = {"JANG", "NAM", "KIM", "HAN", "LEE"};
			String [] LnameMA = {"GIHONG", "HYUNZI", "YONGWOO", "JIHEE", "DONGEUN"};
			int [] ageMA = {24,23,22,14,30};
			String [] tribeMA = {"MONSTER", "KNIGHT", "IDIOT", "ROYALTY", "ALIEN"};
			String [] nativeMA = {"BOOMHILL", "CRAZYPARK", "CRAZYPARK", "NORTHEU", "VILLAGE"};
			String [] jobMA = {"LANDLORD", "EMPLOYER", "CLOWN", "EMPLOYEE", "POET"};
			int [] classMA = {8,7,9,5,6};
			String [] propertyMA = {"WATER", "NIGHTMARE", "FIRE", "WIND", "FIRE"};
			int [] MPMA = {1000, 800, 700, 600, 1200};
			int [] moneyMA = {2500, 3300, 1850, 7000, 950};
			int [] store_ID_MA = {1001, 1002, 1002, 1002, 1004};
			for(int i=0; i<classMA.length; i++)
			{
				if(class_permit_ST[i] < classMA[i])
				{
					System.out.println(FnameMA[i]);
					System.out.println(LnameMA[i]);
					System.out.println("법사 class가 상점 class보다 높습니다.\n");
				}
				else
				{	//preStmt.setInt(1, store_ID[i]);
						preStmt.setString(1, FnameMA[i]);
						preStmt.setString(2, LnameMA[i]);
						preStmt.setInt(3, ageMA[i]);
						preStmt.setString(4, tribeMA[i]);
						preStmt.setString(5, nativeMA[i]);
						preStmt.setString(6, jobMA[i]);
						preStmt.setInt(7, classMA[i]);
						preStmt.setString(8, propertyMA[i]);
						preStmt.setInt(9, MPMA[i]);
						preStmt.setInt(10, moneyMA[i]);
						preStmt.setInt(11, store_ID_MA[i]);
						preStmt.executeUpdate();
						preStmt.clearParameters();//파라미터 초기화 필요 -> update후 넣은 상태가 남아있음, 따라서 param 초기화
				}
			}
			stmt.executeQuery(update_magician_1000);
			
			preStmt = conn.prepareStatement(insert_value_statement6);//magic_detail
			String [] magic_name = {"KILL", "HIDE", "HEAL", "TINY", "GROW"};
			String [] magic_exp = {"kill one person", "make it transparency(10sec)", "healing one person", "make it tiny(1/10)size", "bigger than now"};
			String [] kind = {"ATTACK", "UTIL", "DEFENCE", "UTIL", "UTIL"};
			int [] effect = {20, 0, 15, 0, 0};
			int [] MP_consume = {30, 25, 10, 35, 25};

			for(int i=0; i<magic_name.length; i++)
			{
				preStmt.setString(1, magic_name[i]);
				preStmt.setString(2, magic_exp[i]);
				preStmt.setString(3, kind[i]);
				preStmt.setInt(4, effect[i]);
				preStmt.setInt(5, MP_consume[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();
			}
			
			preStmt = conn.prepareStatement(insert_value_statement7);//magic
			int [] class_MAGIC = {5,4,3,2,1};
			String [] property_MAGIC = {propertyMA[0], propertyMA[1], propertyMA[2], propertyMA[3], propertyMA[4]};
			int [] sale_price_MAGIC = {600, 750, 900, 500, 1500};
			int [] magician_ID_MAGIC = {a, a+1, a+2, a+3, a+4};
			int [] store_ID_MAGIC = {store_ID_MA[0], store_ID_MA[1], store_ID_MA[2], store_ID_MA[3], store_ID_MA[4]};
			String [] magic_name_MAGIC = {magic_name[0], magic_name[1], magic_name[2], magic_name[3], magic_name[4]};

			for(int i=0; i<class_MAGIC.length; i++)
			{
				if(class_MAGIC[i] <= classMA[i])
				{
					preStmt.setInt(1, class_MAGIC[i]);
					preStmt.setString(2, property_MAGIC[i]);
					preStmt.setInt(3, sale_price_MAGIC[i]);
					preStmt.setInt(4, magician_ID_MAGIC[i]);
					preStmt.setInt(5, store_ID_MAGIC[i]);
					preStmt.setString(6, magic_name_MAGIC[i]);
					preStmt.executeUpdate();
					preStmt.clearParameters();
				}
				else {
					System.out.printf("%d번째 법사의 class는 %dclass이상의 마법을 만들지 못합니다.", i, classMA[i]);
				}
			}
			
			stmt.executeQuery(update_magic_1000);
			
			preStmt = conn.prepareStatement(insert_value_statement8);//use_use
			int [] magic_ID_USE = {1001,1001, 1002,1002,1002, 1003,1003, 1004,1004,1004, 1005};
			int [] material_ID_USE = {1001,1004, 1001,1002,1003, 1004,1005, 1003,1004,1005, 1002};
			int [] material_cnt_USE = {2,1, 3,2,3, 2,4, 1,1,2, 2};
			
			for(int i=0; i<magic_ID_USE.length; i++)
			{
				preStmt.setInt(1, magic_ID_USE[i]);
				preStmt.setInt(2, material_ID_USE[i]);
				preStmt.setInt(3, material_cnt_USE[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();
			}
			
			/*preStmt = conn.prepareStatement(insert_value_statement3);// data를 넣기위한 틀 준비단계

			int [] classMG = {6, 5, 2, 1, 2};
			String [] propertyMG = {"WIND", "SUN", "ELECTRON", "FIRE", "ELECTRON"};
			int [] sale_price_MG = {300,280,650,50,60};
			int [] magician_ID_MG = {0002, 0001, 0004, 0003, 0004};
			int [] store_ID_MG = {0001, 0002, 0005, 0004, 0005};
			String [] magic_name_MG = {"A", "B", "C", "D", "E"};
			for( int i = 0; i< classMG.length; i++)
			{
				//preStmt.setInt(1, consumer_ID[i]);
				preStmt.setInt(1, classMG[i]);
				preStmt.setString(2, propertyMG[i]);
				preStmt.setInt(3, sale_price_MG[i]);
				preStmt.setInt(4, magician_ID_MG[i]);
				preStmt.setInt(5, store_ID_MG[i]);
				preStmt.setString(6, magic_name_MG[i]);
				preStmt.executeUpdate();
				preStmt.clearParameters();//파라미터 초기화 필요 -> update후 넣은 상태가 남아있음, 따라서 param 초기화
			}
			*/
			//preStmt.setInt(1, 20);//index 1(Age)
			//preStmt.setString(2, "Kwon");//index 2(Name)
			//preStmt.executeUpdate();//update시키기
			
			System.out.println("성공");
			//stmt.executeQuery(sql);//sql형식으로 썼을때
		}catch(SQLException e)//SQLexeption e
		{
			e.printStackTrace();
		}
		finally {//만든 순서대로 거꾸로 닫아주기
			try {
				stmt.close();//닫기(연 순서와 반대로)
				conn.close();//닫기
			}
			catch(Exception e)
			{
				e.printStackTrace();//에러처리
			}
		}
	}
}


/*	SET @tables = NULL;
SELECT GROUP_CONCAT(table_schema, '.', table_name) INTO @tables
  FROM information_schema.tables
  WHERE table_schema = 'rodus'; -- specify DB name here.

SET @tables = CONCAT('DROP TABLE ', @tables);
PREPARE stmt FROM @tables;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;*///모든 table 삭제


/* select * from information_schema.table_constraints;
[출처] MySQL : 내가 생성한 제약조건 확인*/
