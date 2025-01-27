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
