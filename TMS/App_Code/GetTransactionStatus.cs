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
