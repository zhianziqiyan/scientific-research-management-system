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
    public partial class 修改研究室 : UIForm
    {
        public 修改研究室()
        {
            InitializeComponent();
        }

        string ID = "";
        public 修改研究室(string a1, string a2, string a3)
        {
            InitializeComponent();
            ID = textBox1.Text = a1;
            textBox2.Text = a2;
            textBox3.Text = a3;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                Dao dao = new Dao();
                string sql = $"UPDATE `science`.`lab` SET `name` = '{textBox1.Text}', `direction` = '{textBox2.Text}', `sectary_id` = '{textBox3.Text}' WHERE (`name` = '{ID}');";
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
