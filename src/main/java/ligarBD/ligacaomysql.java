package ligarBD;
import java.sql.*; // para usar o forName

public class ligacaomysql {
	
	public static String estadoligacao = "Nao ligado";
	
	public static Connection criarligacao() {
		
		Connection cn = null;
		
		try {
			// identificar o nome do driver
			String driver = "com.mysql.cj.jdbc.Driver";
			Class.forName(driver);
			
			// indicar os dados do servidor do mysql
			String url = "jdbc:mysql://127.0.0.1:3308/adoption_agencyDB?useTimezone=true&serverTimezone=UTC"; // ou localhost
			// ? é um separador da base de dados e outros atributos que vêm a seguir
			// & é um concatenador
			String user = "root";
			String password = "Orcinuss2";
			cn = DriverManager.getConnection(url, user, password);
			
			if (cn != null) {
				
				estadoligacao = "Ligação efectuada com sucesso!";
			}
			else {
				estadoligacao = "Não foi possível efectuar a ligação :(";
			}
			return(cn);
		}
		catch(ClassNotFoundException e) {
			
			System.out.println("Driver não encontrado :(");
			return null;
		}
		catch(SQLException e) {
			
			System.out.println("Erro ao ligar à base de dados :(");
			return null;
		}
	} // fim criarligacao()
	
	public static String estado() {
		
		return (estadoligacao);
	}
} // fim da classe
