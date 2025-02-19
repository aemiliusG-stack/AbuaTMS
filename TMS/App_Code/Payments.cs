using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Payments
/// </summary>
public class Payments
{
    public Payments()
    {
        //
        // TODO: Add constructor logic here
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

        //

        //using Newtonsoft.Json;
        //using System.Net.Http;
        //using System.Text;
        //using System;

        //public class GenerateToken
        //{
        //    private string baseUrl = "https://test.mypnb.in/cgpsapi/api/PICS/GenerateToken";
        //    private string username = "YOUR_USERNAME";  // Replace with the actual username from PNB
        //    private string password = "SHA256_HASHED_PASSWORD";  // Replace with SHA-256 hashed password

        //    public string GetToken(string clientGuid, string entityCode)
        //    {
        //        using (HttpClient client = new HttpClient())
        //        {
        //            var request = new HttpRequestMessage(HttpMethod.Post, baseUrl);
        //            var authValue = Convert.ToBase64String(Encoding.ASCII.GetBytes($"{username}:{password}"));
        //            request.Headers.Add("Authorization", $"Basic {authValue}");

        //            var content = new StringContent(JsonConvert.SerializeObject(new
        //            {
        //                V1 = clientGuid,
        //                V2 = entityCode,
        //                V3 = username,
        //                V4 = password
        //            }), Encoding.UTF8, "application/json");

        //            request.Content = content;
        //            HttpResponseMessage response = client.SendAsync(request).Result;

        //            if (response.IsSuccessStatusCode)
        //            {
        //                string tokenResponse = response.Content.ReadAsStringAsync().Result;
        //                var tokenObject = JsonConvert.DeserializeObject<TokenResponse>(tokenResponse);
        //                return tokenObject.Token;
        //            }
        //            else
        //            {
        //                throw new Exception("Failed to generate token.");
        //            }
        //        }
        //    }

        //    private class TokenResponse
        //    {
        //        public string Token { get; set; }
        //        public string V2 { get; set; }
        //        public string V3 { get; set; }
        //    }
        //}

        //using Newtonsoft.Json;
        //using System.Net.Http;
        //using System.Text;
        //using System.Threading.Tasks;

        //public class GetTransactionStatus
        //{
        //    private string apiUrlDebit = "https://test.mypnb.in/cgpsapi/api/PICS/Get_Transaction_Status/Debit";
        //    private string apiUrlCredit = "https://test.mypnb.in/cgpsapi/api/PICS/Get_Transaction_Status/Credit";

        //    public async Task<string> GetStatusAsync(string token, string encData, string encKey, string sign, bool isDebit)
        //    {
        //        string url = isDebit ? apiUrlDebit : apiUrlCredit;

        //        using (HttpClient client = new HttpClient())
        //        {
        //            var request = new HttpRequestMessage(HttpMethod.Post, url);
        //            request.Headers.Add("Authorization", $"Bearer {token}");

        //            var content = new StringContent(JsonConvert.SerializeObject(new
        //            {
        //                EncData = encData,
        //                EncKey = encKey,
        //                Sign = sign
        //            }), Encoding.UTF8, "application/json");

        //            request.Content = content;
        //            var response = await client.SendAsync(request);
        //            response.EnsureSuccessStatusCode();

        //            return await response.Content.ReadAsStringAsync();
        //        }
        //    }
        //}
        //using System;
        //using System.Security.Cryptography;

        //public class PICSIntegrationHandler
        //{
        //    private readonly GenerateToken tokenService;
        //    private readonly TransactionRequest transactionService;

        //    public PICSIntegrationHandler()
        //    {
        //        tokenService = new GenerateToken();
        //        transactionService = new TransactionRequest();
        //    }

        //    public void ExecutePaymentFlow(string clientGuid, string entityCode, string paymentData)
        //    {
        //        // Step 1: Generate Token
        //        string token = tokenService.GetToken(clientGuid, entityCode);

        //        // Step 2: Encrypt Payment Data
        //        byte[] aesKey = GenerateAESKey(); // Implement AES key generation
        //        string encData = EncryptionHelper.EncryptPaymentData(paymentData, aesKey);

        //        // Step 3: Encrypt AES Key
        //        string publicKeyPath = "path_to_pnb_rsa_public_key.pem"; // PNB RSA public key
        //        var rsaPublicKey = EncryptionHelper.LoadPublicKey(publicKeyPath);
        //        string encKey = EncryptionHelper.EncryptAESKey(aesKey, rsaPublicKey);

        //        // Step 4: Sign Data
        //        string privateKeyPath = "path_to_client_private_key.pem"; // Client RSA private key
        //        var rsaPrivateKey = EncryptionHelper.LoadPrivateKey(privateKeyPath);
        //        string sign = EncryptionHelper.SignData(paymentData, rsaPrivateKey);

        //        // Step 5: Send Payment Request
        //        string response = transactionService.SendTransactionRequest(token, encData, encKey, sign);
        //        Console.WriteLine("Transaction Response: " + response);
        //    }

        //    private byte[] GenerateAESKey()
        //    {
        //        using (var aes = Aes.Create())
        //        {
        //            aes.KeySize = 256;
        //            aes.GenerateKey();
        //            return aes.Key;
        //        }
        //    }
        //}
        //using Newtonsoft.Json;
        //using System.Net.Http;
        //using System.Text;
        //using System;

        //public class TransactionRequest
        //{
        //    private string apiUrl = "https://test.mypnb.in/cgpsapi/api/PICS/Transaction_Request";

        //    public string SendTransactionRequest(string token, string encData, string encKey, string sign)
        //    {
        //        using (HttpClient client = new HttpClient())
        //        {
        //            var request = new HttpRequestMessage(HttpMethod.Post, apiUrl);
        //            request.Headers.Add("Authorization", $"Bearer {token}");

        //            var content = new StringContent(JsonConvert.SerializeObject(new
        //            {
        //                EncData = encData,
        //                EncKey = encKey,
        //                Sign = sign
        //            }), Encoding.UTF8, "application/json");

        //            request.Content = content;
        //            HttpResponseMessage response = client.SendAsync(request).Result;

        //            if (response.IsSuccessStatusCode)
        //            {
        //                return response.Content.ReadAsStringAsync().Result;
        //            }
        //            else
        //            {
        //                throw new Exception("Failed to send transaction request.");
        //            }
        //        }
        //    }
        //}


    }
}