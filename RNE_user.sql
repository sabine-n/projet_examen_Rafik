CREATE USER 'RNE_user'@'localhost' IDENTIFIED BY 'RNE_password';

GRANT ALL PRIVILEGES ON *  TO 'RNE_user'@'localhost';

-- Après une erreur sur la valisité du mot de passe j'ai fait:

-- SHOW VARIABLES LIKE 'validate_password%';
-- SET GLOBAL validate_password_length = 6;
-- SET GLOBAL validate_password_number_count = 0;
-- SET GLOBAL validate_password_policy = 'LOW';