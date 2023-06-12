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
    public partial class Class : Form
    { 
        public Class()
        {
            InitializeComponent();
        }

        private void Class_Load(object sender, EventArgs e)
        {
            LoadDanhSach();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            { 
                string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "INSERT INTO LOP(MALOP, TENLOP, MANV) VALUES('" + txtMaLop.Text + "',N'" + txtTenLop.Text + "','" + txtNhanVien.Text + "')";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                LoadDanhSach();
            }
            catch (Exception es)
            {
                MessageBox.Show(es.Message);
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "UPDATE LOP SET TENLOP = N'" + txtTenLop.Text + "', MANV = '" + txtNhanVien.Text + "' WHERE MALOP = '" + txtMaLop.Text + "'";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                LoadDanhSach();
            }
            catch (Exception es)
            {
                MessageBox.Show(es.Message);
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
                SqlConnection con = new SqlConnection(str);
                con.Open();
                string query = "DELETE FROM LOP WHERE MALOP = '" + txtMaLop.Text + "'";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                LoadDanhSach();
            }
            catch (Exception es)
            {
                MessageBox.Show(es.Message);
            }
        }

        private void LoadDanhSach()
        {
            string str = "server=LAPTOP-O3QFFQPL;database=QLSV;UID=sa;password=12345";
            SqlConnection con = new SqlConnection(str);
            con.Open();
            string query = "SELECT * FROM LOP";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            sda.Fill(ds, "Authors_talbe");
            con.Close();
            dgvClass.DataSource = ds;
            dgvClass.DataMember = "Authors_talbe";
            txtMaLop.Enabled = true;
            btnThem.Enabled = true;
            txtMaLop.Text = "";
            txtTenLop.Text = "";
            txtNhanVien.Text = "";
            linkLabel1.Text = "";
            linkLabel1.Enabled = false;
        }

        private void dgvClass_CellMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                txtMaLop.Enabled = false;
                btnThem.Enabled = false; 
                DataGridViewRow row = dgvClass.Rows[e.RowIndex];
                txtMaLop.Text = row.Cells[0].Value.ToString();
                txtTenLop.Text = row.Cells[1].Value.ToString();
                txtNhanVien.Text = row.Cells[2].Value.ToString();
                linkLabel1.Text = "Danh sách sinh viên lớp " + txtMaLop.Text + "-" + txtTenLop.Text;
                linkLabel1.Enabled = true;
            }
        }

        private void btnTaiLai_Click(object sender, EventArgs e)
        {
            txtMaLop.Enabled = true;
            btnThem.Enabled = true;
            txtMaLop.Text = "";
            txtTenLop.Text = "";
            txtNhanVien.Text = "";
            linkLabel1.Text = "";
            linkLabel1.Enabled = false;
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Student student = new Student(txtMaLop.Text, txtTenLop.Text, txtNhanVien.Text);
            student.ShowDialog();

        }
    }
}
