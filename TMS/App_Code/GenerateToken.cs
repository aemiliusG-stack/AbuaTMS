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
