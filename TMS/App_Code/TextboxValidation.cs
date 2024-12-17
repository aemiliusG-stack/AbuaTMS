using System;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for TextboxValidation
/// </summary>
public class TextboxValidation
{
    public static bool isNumeric(string valToCheck)
    {
        string expresion;
        expresion = "^[0-9]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool isDecimal(string valToCheck)
    {
        string expresion;
        expresion = @"^\d*\.?\d*$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }

    public static bool isAlphabet(string valToCheck)
    {
        string expresion;
        expresion = "^[A-Za-z ]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool isAlphaNumeric(string valToCheck)
    {
        string expresion;
        expresion = "^[a-zA-Z0-9\\s]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool isAlphaNumericSpecial(string valToCheck)
    {
        string expresion;
        expresion = "^[a-zA-Z0-9().\\s]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool IsPassword(string input)
    {
        // Regular expression to match alphanumeric and @, #, $, &, *, !
        string pattern = "^[a-zA-Z0-9@#$&*!]+$";

        // Use Regex to check if the input matches the pattern
        return Regex.IsMatch(input, pattern);
    }
    public static bool isLicenceNo(string valToCheck)
    {
        string expresion;
        expresion = "^[A-Za-z0-9_///-]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool isDate(string valToCheck)
    {
        string expresion;
        expresion = "^[0-9-]+$";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static bool isEmailID(string valToCheck)
    {
        string expresion;
        expresion = @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";

        if (Regex.IsMatch(valToCheck, expresion))
        {
            if (Regex.Replace(valToCheck, expresion, string.Empty).Length == 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    public static string filterBadchars(string tstr)
    {
        if (string.IsNullOrEmpty(tstr))
            return "";

        string[] badchars = new[] { "alert", "select", "drop", ";", "--", "insert", "delete", "xp_", "(", ")", "+", "..", ":", @"\", "/.", "%2b", "/?", @"\." };
        string newchars = tstr;

        foreach (string badchar in badchars)
        {
            // Use Regex.Replace for case-insensitive replacement
            newchars = Regex.Replace(newchars, Regex.Escape(badchar), "", RegexOptions.IgnoreCase);
        }

        return newchars;
    }

    public static string StripQuotes(string tstr)
    {
        if (string.IsNullOrEmpty(tstr))
            return "";

        // Replace single quotes with double single quotes for escaping
        string finalString = tstr.Replace("'", "''");
        return finalString;
    }
    public static bool IsValidMobileNumber(string mobileNumber)
    {
        // Regular expression for validating a mobile number
        string pattern = @"^[6-9]\d{9,}$";

        // Check if the input matches the pattern
        return Regex.IsMatch(mobileNumber, pattern);
    }
}