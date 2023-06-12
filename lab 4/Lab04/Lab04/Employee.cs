using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Forms;

namespace Lab04
{
    public partial class Employee : Form
    {
        public Employee()
        {
            InitializeComponent();
            LoadDanhSach();
        }

        private void LoadDanhSach()
        {
            string str = "server=HOOEI;database=QLSV;UID=sa;password=123456";
            SqlConnection con = new SqlConnection(str);
            con.Open();
            string query = "SELECT MANV, HOTEN, EMAIL, LUONG FROM NHANVIEN";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            sda.Fill(ds, "authors_table");
            con.Close();

            dtgvNhanVien.DataSource = ds;
            dtgvNhanVien.DataMember = "authors_table";

           
            //try
            //{
            //    // Create Aes that generates a new key and initialization vector (IV).
            //    // Same key must be used in encryption and decryption
            //    using (AesManaged aes = new AesManaged())
            //    {
            //        // Encrypt string
            //        foreach (DataGridViewRow row in dtgvNhanVien.Rows)
            //        { 
            //                txtHoTen.Text =  Decryptaes256(Encoding.ASCII.GetBytes(row.Cells[3].Value.ToString()), aes.Key, aes.IV);
            //        }
            //        dtgvNhanVien.DataSource = dtgvNhanVien;

            //    }
            //}
            //catch (Exception exp)
            //{
            //    MessageBox.Show(exp.Message);
            //}

            txtMaNV.Enabled = false;
            txtEmail.Enabled = false;
            txtDangNhap.Enabled = false;
            txtHoTen.Enabled = false;
            txtLuong.Enabled = false;
            txtMatKhau.Enabled = false;
        }

        private object Decryptaes256(string v, byte[] key, byte[] iV)
        {
            throw new NotImplementedException();
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

        private void btnThem_Click(object sender, EventArgs e)
        {
            txtMaNV.Enabled = true;
            txtEmail.Enabled = true;
            txtDangNhap.Enabled = true;
            txtHoTen.Enabled = true;
            txtLuong.Enabled = true;
            txtMatKhau.Enabled = true; 
        }
         
        static byte[] EncryptAES256(string plainText, byte[] Key, byte[] IV)
        {

            byte[] encrypted;
            // Create a new AesManaged.
            using (AesManaged aes = new AesManaged())
            {
                // Create encryptor
                ICryptoTransform encryptor = aes.CreateEncryptor(Key, IV);
                // Create MemoryStream
                using (MemoryStream ms = new MemoryStream())
                {
                    // Create crypto stream using the CryptoStream class. This class is the key to encryption
                    // and encrypts and decrypts data from any given stream. In this case, we will pass a memory stream
                    // to encrypt
                    using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                    {
                        // Create StreamWriter and write data to a stream
                        using (StreamWriter sw = new StreamWriter(cs))
                            sw.Write(plainText);
                        encrypted = ms.ToArray();
                    }
                }
            }
            // Return encrypted data
            return encrypted;
        }

        static string Decryptaes256(byte[] cipherText, byte[] Key, byte[] IV)
        {
            string plaintext = null;
            // Create AesManaged
            using (AesManaged aes = new AesManaged())
            {
                // Create a decryptor
                ICryptoTransform decryptor = aes.CreateDecryptor(Key, IV);
                // Create the streams used for decryption.
                using (MemoryStream ms = new MemoryStream(cipherText))
                {
                    // Create crypto stream
                    using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                    {
                        // Read crypto stream
                        using (StreamReader reader = new StreamReader(cs))
                            plaintext = reader.ReadToEnd();
                    }
                }
            }
            return plaintext;
        }

        private void btnGhi_Click(object sender, EventArgs e)
        {  
            try
            {
                String str = "server=HOOEI;database=QLSV;UID=sa;password=123456";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "EXEC SP_INS_ENCRYPT_NHANVIEN '" + txtMaNV.Text + "', '" + txtHoTen.Text + "', '" + txtEmail.Text + "', '" + txtLuong.Text + "', '" + txtDangNhap.Text +  "', '" + EncryptSHA1(txtMatKhau.Text) + "'";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception es1)
            {
                MessageBox.Show(es1.Message);
            }
           
            LoadDanhSach(); 
        }
    }
}
