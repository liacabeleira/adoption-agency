package classes;

public class TestValidator {
	public static void main(String[] args) {
        // Testar validação de senha
        String senha = "12345Abcde%";
        String confirmacao = "12345Abcde%";
        boolean senhaValida = Validator.isValidPassword(senha, confirmacao);
        System.out.println("Senha válida? " + senhaValida);

        // Testar validação de número de telefone
        String telefone = "914522767";
        boolean telefoneValido = Validator.isValidPhoneNumber(telefone);
        System.out.println("Telefone válido? " + telefoneValido);
    }
}
