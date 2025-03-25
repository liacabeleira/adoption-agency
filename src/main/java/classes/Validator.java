package classes;
import java.util.regex.Pattern;
import org.apache.commons.text.StringEscapeUtils;

public class Validator {
	// Verifica se o nome ou sobrenome são válidos (apenas letras, mínimo 2 caracteres)
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[A-Za-zÀ-ÿ\\s]{2,}$");
    }

    // Verifica se o email é válido
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-.]+@[\\w-]+\\.[a-zA-Z]{2,}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // Verifica se a senha é forte e combina com a confirmação
    public static boolean isValidPassword(String password, String confirmPassword) {
        if (password == null || confirmPassword == null) return false;

        // Regex para validar: mínimo de 8 caracteres, pelo menos 1 letra maiúscula,
        // 1 letra minúscula, 1 número e 1 caractere especial (!, $, #, ?, %).
        String passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!$#?%])[A-Za-z\\d!$#?%]{8,}$";

        // Valida se a senha corresponde ao padrão e se ambas são iguais
        return password.matches(passwordRegex) && password.equals(confirmPassword);
    }

    // Verifica se o endereço é válido (não vazio, caracteres alfanuméricos e espaços)
    public static boolean isValidAddress(String address) {
        return address != null && address.matches("^[A-Za-z0-9À-ÿ,\\s]{5,}$");
    }

    // Verifica se o código postal é válido (formato geral)
    public static boolean isValidZipCode(String zipCode) {
        return zipCode != null && zipCode.matches("^\\d{4,5}(-\\d{3})?$");
    }

    // Verifica se a cidade é válida (apenas letras, mínimo 2 caracteres)
    public static boolean isValidCity(String city) {
        return city != null && city.matches("^[A-Za-zÀ-ÿ\\s]{2,}$");
    }

    // Verifica se o país é válido (apenas letras, mínimo 2 caracteres)
    public static boolean isValidCountry(String country) {
        return country != null && country.matches("^[A-Za-zÀ-ÿ\\s]{2,}$");
    }

 // Verifica se o número de telefone é válido (números, 9-15 dígitos)
    public static boolean isValidPhoneNumber(String phoneNumber) {
        phoneNumber = phoneNumber.trim(); // Remove espaços em branco
        boolean isValid = phoneNumber.matches("^\\d{9,15}$");
        return isValid;
    }

    // Sanitiza strings para evitar XSS (removendo/escapando caracteres especiais)
    public static String sanitizeInput(String input) {
        return input != null ? StringEscapeUtils.escapeHtml4(input.trim()) : "";
    }
}
