//using Org.BouncyCastle.Crypto;
//using Org.BouncyCastle.Crypto.Parameters;
//using Org.BouncyCastle.OpenSsl;
//using Org.BouncyCastle.Security;
//using System;
//using System.IO;
//using System.Security.Cryptography;
//using System.Text;

//public static class EncryptionHelper
//{
//    public static AsymmetricKeyParameter LoadPublicKey(string publicKeyPath)
//    {
//        using (TextReader reader = new StringReader(File.ReadAllText(publicKeyPath)))
//        {
//            PemReader pemReader = new PemReader(reader);
//            return (AsymmetricKeyParameter)pemReader.ReadObject();
//        }
//    }

//    public static AsymmetricCipherKeyPair LoadPrivateKey(string privateKeyPath)
//    {
//        using (TextReader reader = new StringReader(File.ReadAllText(privateKeyPath)))
//        {
//            PemReader pemReader = new PemReader(reader);
//            return (AsymmetricCipherKeyPair)pemReader.ReadObject();
//        }
//    }

//    public static string EncryptPaymentData(string paymentData, byte[] aesKey)
//    {
//        using (var aes = Aes.Create())
//        {
//            aes.Key = aesKey;
//            aes.GenerateIV();

//            using (var encryptor = aes.CreateEncryptor())
//            {
//                byte[] inputBytes = Encoding.UTF8.GetBytes(paymentData);
//                byte[] encryptedBytes = encryptor.TransformFinalBlock(inputBytes, 0, inputBytes.Length);
//                return Convert.ToBase64String(encryptedBytes);
//            }
//        }
//    }

//    public static string EncryptAESKey(byte[] aesKey, AsymmetricKeyParameter rsaPublicKey)
//    {
//        using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
//        {
//            rsa.ImportParameters(DotNetUtilities.ToRSAParameters((RsaKeyParameters)rsaPublicKey));
//            byte[] encryptedKey = rsa.Encrypt(aesKey, true);
//            return Convert.ToBase64String(encryptedKey);
//        }
//    }

//    public static string SignData(string rawJson, AsymmetricCipherKeyPair rsaPrivateKey)
//    {
//        using (var rsa = RSA.Create())
//        {
//            var rsaParams = DotNetUtilities.ToRSAParameters((RsaPrivateCrtKeyParameters)rsaPrivateKey.Private);
//            rsa.ImportParameters(rsaParams);

//            byte[] dataBytes = Encoding.UTF8.GetBytes(rawJson);
//            byte[] signedData = rsa.SignData(dataBytes, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
//            return Convert.ToBase64String(signedData);
//        }
//    }
//}
