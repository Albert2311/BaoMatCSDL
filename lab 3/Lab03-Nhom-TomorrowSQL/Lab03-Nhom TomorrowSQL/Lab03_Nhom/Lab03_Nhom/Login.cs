using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab03_Nhom
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    String str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
            //    SqlConnection con = new SqlConnection(str);
            //    con.Open();
            //    string query = "SELECT MANV, HOTEN, EMAIL, CONVERT(varchar(max), DECRYPTBYASYMKEY(ASYMKEY_ID('AK01'), LUONG, N'46.01.104.065')) AS LUONGCB FROM NHANVIEN WHERE N'" + txtDangNhap.Text + "' = TENDN AND CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', '" + txtMatKhau.Text + "'), 2) = MATKHAU";
            //    SqlDataAdapter sda = new SqlDataAdapter(query, con);
            //    DataTable dt = new DataTable();
            //    sda.Fill(dt);
            //    if (dt.Rows[0][0].ToString() != "")
            //    {
            Class @class = new Class();
                    this.Hide();
                    @class.ShowDialog();
                    this.Close();
            //    }
            //    else
            //    {
            //        MessageBox.Show("Tên đăng nhập và mật khẩu không hợp lệ");
            //    }
            //    con.Close();
            //}
            //catch (Exception es)
            //{
            //    MessageBox.Show("Tên đăng nhập và mật khẩu không hợp lệ");
            //}
        }
    }
}
