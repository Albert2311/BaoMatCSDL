using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab04
{
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
        }
        static string key { get; set; } = "A!9HHhi%XjjYY4YP2@Nob009X";

        public static string EncryptMD5(string text)
        {
            using (var md5 = new MD5CryptoServiceProvider())
            {
                using (var tdes = new TripleDESCryptoServiceProvider())
                {
                    tdes.Key = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                    tdes.Mode = CipherMode.ECB;
                    tdes.Padding = PaddingMode.PKCS7;

                    using (var transform = tdes.CreateEncryptor())
                    {
                        byte[] textBytes = UTF8Encoding.UTF8.GetBytes(text);
                        byte[] bytes = transform.TransformFinalBlock(textBytes, 0, textBytes.Length);
                        return Convert.ToBase64String(bytes, 0, bytes.Length);
                    }
                }
            }
        }

        public static string DecryptMD5(string cipher)
        {
            using (var md5 = new MD5CryptoServiceProvider())
            {
                using (var tdes = new TripleDESCryptoServiceProvider())
                {
                    tdes.Key = md5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                    tdes.Mode = CipherMode.ECB;
                    tdes.Padding = PaddingMode.PKCS7;

                    using (var transform = tdes.CreateDecryptor())
                    {
                        byte[] cipherBytes = Convert.FromBase64String(cipher);
                        byte[] bytes = transform.TransformFinalBlock(cipherBytes, 0, cipherBytes.Length);
                        return UTF8Encoding.UTF8.GetString(bytes);
                    }
                }
            }
        }

        public static string EncryptSHA1(string input)
        {
            using (SHA1Managed sha1 = new SHA1Managed())
            {
                var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(input));
                var sb = new StringBuilder(hash.Length * 2);

                foreach (byte b in hash)
                {
                    // can be "x2" if you want lowercase
                    sb.Append(b.ToString("X2"));
                }

                return sb.ToString();
            }
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            //txtDangNhap.Text = EncryptMD5(txtMatKhau.Text);
            try
            {
                string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "SELECT * FROM SINHVIEN WHERE TENDN=N'" + txtDangNhap.Text + "' AND MATKHAU='" + EncryptMD5(txtMatKhau.Text) + "'";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows[0][0].ToString() != "")
                {
                    Employee employee = new Employee();
                    this.Hide();
                    employee.ShowDialog();
                    this.Close();
                }
                con.Close();
            }
            catch (Exception es)
            {
                try
                {
                    String str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                    SqlConnection con = new SqlConnection(str);
                    con.Open();
                    string query = "SELECT * FROM NHANVIEN WHERE TENDN=N'" + txtDangNhap.Text + "' AND MATKHAU='" + EncryptSHA1(txtMatKhau.Text) + "' ";
                    SqlDataAdapter sda = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows[0][0].ToString() != "")
                    {
                        con.Close();
                        Employee employee = new Employee();
                        this.Hide();
                        employee.ShowDialog();
                        this.Close();
                    }
                    con.Close();
                }
                catch (Exception es1)
                {
                    MessageBox.Show("Tên đăng nhập và mật khẩu không hợp lệ");
                }
            }
        }
    }
}
