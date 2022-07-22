using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Sunny.UI;


namespace 科研管理系统
{
    public partial class 修改项目 : UIForm
    {
       
        public 修改项目()
        {
            InitializeComponent();
        }

        string ID="";
        public 修改项目(string a1, string a2, string a3, string a4, string a5, string a6, string a7)
        {
            InitializeComponent();
            ID = textBox1.Text = a1;
            textBox2.Text = a2;
            textBox3.Text = a3;
            textBox4.Text = a4;
            textBox5.Text = a5;
            textBox6.Text = a6;
            textBox7.Text = a7;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                Dao dao = new Dao();
                string sql = $"UPDATE `science`.`project` SET `id` = '{textBox1.Text}', `name` = '{textBox2.Text}', `principle` = '{textBox3.Text}', `research_contents` = '{textBox4.Text}', `expenditure` = '{textBox5.Text}', `start_date` = '{textBox6.Text}', `end_time` = '{textBox7.Text}' WHERE (`id` = '{ID}');";
                int n = dao.Execute(sql);
                if (n > 0)
                {
                    MessageBox.Show("修改成功");
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        

    }
}
