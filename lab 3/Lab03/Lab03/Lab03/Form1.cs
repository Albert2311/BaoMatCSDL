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

namespace Lab03
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            try
            {
                String str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "DECLARE @MATKHAUBINARY VARBINARY(MAX)" + "\n" +
                                "SET @MATKHAUBINARY = CONVERT(VARBINARY(MAX), HASHBYTES('MD5', '" + txtMatKhau.Text + "'), 2)" + "\n" +
                                "SELECT COUNT(*) FROM SINHVIEN WHERE N'" + txtDangNhap.Text + "' = TENDN AND MATKHAU = @MATKHAUBINARY";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows[0][0].ToString() == "1")
                {
                    MessageBox.Show("Login success!");
                }
                else
                {
                    query = "DECLARE @MATKHAUBINARY VARBINARY(MAX)" + "\n" +
                                "SET @MATKHAUBINARY = CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', '" + txtMatKhau.Text + "'), 2)" + "\n" +
                                "SELECT COUNT(*) FROM NHANVIEN WHERE N'" + txtDangNhap.Text + "' = TENDN AND MATKHAU = @MATKHAUBINARY";
                    sda = new SqlDataAdapter(query, con);
                    dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows[0][0].ToString() == "1")
                    {
                        MessageBox.Show("Đăng nhập thành công");
                    }
                    else
                    {
                        MessageBox.Show("Tên đăng nhập và mật khẩu không hợp lệ");
                    }
                }
                con.Close();
            }
            catch (Exception es)
            {
                MessageBox.Show(es.Message);
            }
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
