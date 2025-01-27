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
