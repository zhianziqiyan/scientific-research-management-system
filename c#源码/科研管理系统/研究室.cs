using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using Sunny.UI;
using Microsoft.VisualBasic;

namespace 科研管理系统
{
    public partial class 研究室 : UIForm
    {
        public 研究室()
        {
            InitializeComponent();
        }


        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Clear();
            Dao dao = new Dao();
            string sql = "SELECT lab.`name`, lab.direction, lab_location.adddress,lab_location.area,director.`name`,secretary.`name` FROM lab INNER JOIN lab_location ON lab_location.lab_name = lab.`name` INNER JOIN secretary ON lab.sectary_id = secretary.id INNER JOIN researcher ON researcher.direction = lab.direction INNER JOIN director ON director.id = researcher.id AND director.`name` = researcher.`name`";
            MySqlDataReader reader = dao.Read(sql);
            while (reader.Read())
            {
                dataGridView1.Rows.Add(
                    reader.GetString(0),
                    reader.GetString(1),
                    reader.GetString(2),
                    reader.GetString(3),
                    reader.GetString(4),
                    reader.GetString(5)
                    );
            }
            reader.Close();
            dao.DaoClose();
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            添加研究室 add = new 添加研究室();
            add.ShowDialog();
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {
            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要删除的研究室的名称：");
            if (returnValue != "")
            {
                Dao dao = new Dao();
                string sql = $"delete from lab where name ='{returnValue}'";
                int n = dao.Execute(sql);
                if (n > 0)
                {
                    MessageBox.Show("删除成功！");
                }
                else
                {
                    MessageBox.Show("研究室不存在！");
                }
            }

        }

        private void toolStripMenuItem5_Click(object sender, EventArgs e)
        {
            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要修改的项目的项目号");
            try
            {
                Dao dao = new Dao();
                string sql = $"select * from lab where name ='{returnValue}'";
                MySqlDataReader reader = dao.Read(sql);
                reader.Read();
                string a1 = reader.GetString(0);
                string a2 = reader.GetString(1);
                string a3 = reader.GetString(2);
                修改研究室 modify = new 修改研究室(a1, a2, a3);
                modify.ShowDialog();
                reader.Close();
                dao.DaoClose();
            }
            catch (Exception ex)
            {
                MessageBox.Show("研究室不存在！");
            }
        }

        private void toolStripMenuItem4_Click(object sender, EventArgs e)
        {
            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要查询的项目的项目号");
            if (returnValue != "")
            {
                dataGridView1.Rows.Clear();
                Dao dao = new Dao();
                string sql = $"SELECT lab.`name`, lab.direction, lab_location.adddress,lab_location.area,director.`name`,secretary.`name` FROM lab INNER JOIN lab_location ON lab_location.lab_name = lab.`name` INNER JOIN secretary ON lab.sectary_id = secretary.id INNER JOIN researcher ON researcher.direction = lab.direction INNER JOIN director ON director.id = researcher.id AND director.`name` = researcher.`name` WHERE lab.`name` = '{returnValue}'";
                MySqlDataReader reader = dao.Read(sql);
                while (reader.Read())
                {
                    dataGridView1.Rows.Add(
                        reader.GetString(0),
                        reader.GetString(1),
                        reader.GetString(2),
                        reader.GetString(3),
                        reader.GetString(4),
                        reader.GetString(5)
                        );
                }
                reader.Close();
                dao.DaoClose();
            }

        }
    }
}
