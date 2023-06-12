using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Lab03_Nhom
{
    public partial class Student : Form
    {
        private string MaLop, TenLop, NhanVien;
        public Student()
        {
            InitializeComponent();
        }
        public Student(string Malop, string Tenlop, string Nhanvien)
        {
            InitializeComponent();
            MaLop = Malop;
            TenLop = Tenlop;
            NhanVien = Nhanvien;
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "INSERT INTO SINHVIEN(MASV, HOTEN, NGAYSINH, DIACHI, MALOP, TENDN, MATKHAU) VALUES('" 
                    + txtMaSV.Text + "', N'" + txtHoTen.Text + "', " + dtpkNgaySinh.Value + ", N'" + txtDiaChi.Text + "', '" 
                    + MaLop + "', N'" + txtDangNhap.Text + "', CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', '" + txtMatKhau.Text + "'), 2))";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                LoadDanhSach(); 
            }
            catch (Exception es)
            {
                MessageBox.Show("INSERT INTO SINHVIEN(MASV, HOTEN, NGAYSINH, DIACHI, MALOP, TENDN, MATKHAU) " +
                    "VALUES('" + txtMaSV.Text + "', N'" + txtHoTen.Text + "', " + dtpkNgaySinh.Format + ", N'" 
                    + txtDiaChi.Text + "', '" + MaLop + "', N'" + txtDangNhap.Text + "', CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', '" + txtMatKhau.Text + "'), 2))");
            }
        }

        private void Student_Load(object sender, EventArgs e)
        {
            LoadDanhSach();
        }
        private void LoadDanhSach()
        {
            string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
            SqlConnection con = new SqlConnection(str);
            con.Open();
            string query = "SELECT * FROM SINHVIEN WHERE MALOP = '" + MaLop + "'";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            sda.Fill(ds, "Authors_talbe");
            con.Close();
            dgvSinhVien.DataSource = ds;
            dgvSinhVien.DataMember = "Authors_talbe";
        }
    }
}
