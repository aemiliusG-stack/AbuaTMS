<%@ WebHandler Language="C#" Class="CaptchaImageHandler" %>
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Web;

public class CaptchaImageHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string captchaCode = context.Session["captcha"] as string;
        if (!string.IsNullOrEmpty(captchaCode))
        {
            using (Bitmap bitmap = new Bitmap(100, 30))
            using (Graphics g = Graphics.FromImage(bitmap))
            {
                RectangleF rectf = new RectangleF(10, 5, 0, 0);
                g.Clear(Color.White);
                g.SmoothingMode = SmoothingMode.AntiAlias;
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.PixelOffsetMode = PixelOffsetMode.HighQuality;

                Font font = new Font("Arial", 18, FontStyle.Bold);

                // Draw the CAPTCHA text
                g.DrawString(captchaCode, new Font("Arial", 16, FontStyle.Italic | FontStyle.Strikeout), Brushes.Black, rectf);
                //g.DrawRectangle(new Pen(ColorTranslator.FromHtml("#008e81")), 1, 1, width - 2, height - 2);
                //g.DrawString(captchaCode, font, Brushes.Black, new PointF(10, 5));

                // Draw a green border around the text
                using (Pen greenPen = new Pen(Color.Green, 2)) // Border color and thickness
                {
                    g.DrawRectangle(greenPen, 0, 0, bitmap.Width - 1, bitmap.Height - 1);
                }

                // Set response properties and save image to output stream
                context.Response.ContentType = "image/jpeg";
                context.Response.Cache.SetNoStore();
                bitmap.Save(context.Response.OutputStream, ImageFormat.Jpeg);
            }
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
