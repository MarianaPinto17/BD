using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.Common;

namespace ex1
{
    public partial class Form2 : Form
    {

        SqlConnection DataSet1;

        private void TestDBConnection(SqlConnection DataSet1)
        {
            try
            {
                //opens a database connection
                DataSet1.Open();
                //if ti's connected
                if (DataSet1.State == ConnectionState.Open)
                {
                    MessageBox.Show("Successful connection to database " + DataSet1.Database + " on the " 
                        + DataSet1.DataSource + " server", "Connection Test", MessageBoxButtons.OK);
                }
            }
            //if isn't connected
            catch (Exception ex)
            {
                MessageBox.Show("FAILED TO OPEN CONNECTION TO DATABASE DUE TO THE FOLLOWING ERROR \r\n" 
                    + ex.Message, "Connection Test", MessageBoxButtons.OK);
            }
            //closes the database conection
            if (DataSet1.State == ConnectionState.Open)
                DataSet1.Close();
        }


        private string getTableContent(SqlConnection DataSet1)
        {
            string str = "";
            try
            {
                DataSet1.Open();
                if (DataSet1.State == ConnectionState.Open)
                {
        
                    int cnt = 1;
                    //Transact-SQL statement or stored procedure to execute against a SQL Server database
                    SqlCommand sqlcmd = new SqlCommand("SELECT * FROM Hello", DataSet1);
                    //way to read a stream of rows from a SQL database
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();
                    //advances sqlDataReader to the next record
                    while (reader.Read())
                    {
                        str += cnt.ToString() + " - " + reader.GetString(reader.GetOrdinal("MsgID")) + ", ";
                        str += reader.GetString(reader.GetOrdinal("MsgSubject"));
                        str += "\n";
                        cnt += 1;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("FAILED TO OPEN CONNECTION TO DATABASE DUE TO THE FOLLOWING ERROR \r\n" + ex.Message, "Connection Error", MessageBoxButtons.OK);
            }

            if (DataSet1.State == ConnectionState.Open)
                DataSet1.Close();

            return str;
        }

        public Form2()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        //all form
        private void Form2_Load(object sender, EventArgs e)
        {
            
        }
        
        private void testligacaobutton_Click(object sender, EventArgs e)
        {
            //new sql connection when clicked
            DataSet1 = new SqlConnection("Data Source = " + servertextbox.Text + ";"
                + "Initial Catalog = " + servertextbox.Text + "; uid = "
                + usertextbox.Text + ";" + "password = " + passwordtextbox.Text);

            TestDBConnection(DataSet1);
        }
        
        private void servertextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void usertextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void passwordtextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void holdtablebutton_Click(object sender, EventArgs e)
        {
            MessageBox.Show(getTableContent(DataSet1));
        }
    }
}
