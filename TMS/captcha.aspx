<%@ Page Language="C#" AutoEventWireup="true" CodeFile="captcha.aspx.cs" Inherits="captcha" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.Drawing" %>
<%
    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
    Response.Cache.SetNoStore();

    int height = 30;
    int width = 100;
    Bitmap bmp = new Bitmap(width, height);
    RectangleF rectf = new RectangleF(10, 5, 0, 0);
    Graphics g = Graphics.FromImage(bmp);
    g.Clear(Color.White);
    g.SmoothingMode = SmoothingMode.AntiAlias;
    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
    g.PixelOffsetMode = PixelOffsetMode.HighQuality;

    try
    {
        if (Session["captcha"] == null)
        {
            // Optional handling if session is null
            Response.Write("Captcha session data is missing.");
            Response.End();
        }

        g.DrawString(Session["captcha"].ToString(), new Font("Arial", 16, FontStyle.Italic | FontStyle.Strikeout), Brushes.Black, rectf);
        g.DrawRectangle(new Pen(ColorTranslator.FromHtml("#008e81")), 1, 1, width - 2, height - 2);
        g.Flush();
        Response.ContentType = "image/jpeg";
        bmp.Save(Response.OutputStream, ImageFormat.Jpeg);
    }
    catch (Exception ex)
    {
        Response.Write("Error generating CAPTCHA: " + ex.Message);
    }
    finally
    {
        g.Dispose();
        bmp.Dispose();
    }
%>