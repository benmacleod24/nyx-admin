using System.Security.Cryptography;

namespace api.Services.PasswordHasher
{
    public class PasswordHasher : IPasswordHasher
    {
        private const int SaltSize = 128 / 8; // 16 bytes
        private const int KeySize = 256 / 8;  // 32 bytes
        private const int Iterations = 350000;
        private static readonly HashAlgorithmName _hashAlgorithmName = HashAlgorithmName.SHA256;
        private const char Delimiter = ';';

        public string HashPassword(string password)
        {
            byte[] salt = RandomNumberGenerator.GetBytes(SaltSize);
            byte[] hash = Rfc2898DeriveBytes.Pbkdf2(
                password,
                salt,
                Iterations,
                _hashAlgorithmName,
                KeySize
            );

            return string.Join(
                Delimiter,
                Convert.ToBase64String(hash),
                Convert.ToBase64String(salt),
                Iterations,
                _hashAlgorithmName
            );
        }

        public bool VerifyPassword(string password, string hashedPassword)
        {
            try
            {
                // Extract values from the hash
                var elements = hashedPassword.Split(Delimiter);
                var hash = Convert.FromBase64String(elements[0]);
                var salt = Convert.FromBase64String(elements[1]);
                var iterations = int.Parse(elements[2]);
                var algorithm = new HashAlgorithmName(elements[3]);

                var verificationHash = Rfc2898DeriveBytes.Pbkdf2(
                    password,
                    salt,
                    iterations,
                    algorithm,
                    hash.Length
                );

                return CryptographicOperations.FixedTimeEquals(hash, verificationHash);
            }
            catch (Exception)
            {
                // If anything fails (corrupt hash string, invalid base64, etc), return false
                return false;
            }
        }
    }
}
