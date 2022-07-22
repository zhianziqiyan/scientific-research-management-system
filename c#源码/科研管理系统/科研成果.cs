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
    public partial class 科研成果 : UIForm
    {
        public 科研成果()
        {
            InitializeComponent();
        }


        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Clear();
            Dao dao = new Dao();
            string sql = "SELECT research_achievement.id,research_achievement.`name`,research_achievement.contributer,research_achievement.get_date,research_achievement.project_id,achievement_type.`name`,research_achievement.rank FROM research_achievement INNER JOIN achievement_type ON research_achievement.type_id = achievement_type.id";
            MySqlDataReader reader = dao.Read(sql);
            while (reader.Read())
            {
                dataGridView1.Rows.Add(
                    reader.GetString(0),
                    reader.GetString(1),
                    reader.GetString(2),
                    reader.GetString(3),
                    reader.GetString(4),
                    reader.GetString(5),
                    reader.GetString(6)
                    );
            }
            reader.Close();
            dao.DaoClose();
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            添加科研成果 add = new 添加科研成果();
            add.ShowDialog();
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {

            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要删除的科研成果的成果号");
            if (returnValue != "")
            {
                Dao dao = new Dao();
                string sql = $"delete from research_achievement where id ='{returnValue}'";
                int n = dao.Execute(sql);
                if (n > 0)
                {
                    MessageBox.Show("删除成功！");
                }
                else
                {
                    MessageBox.Show("成果号不存在！");
                }
            }

        }

        private void toolStripMenuItem4_Click(object sender, EventArgs e)
        {
            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要查询的科研成果的成果号");
            if (returnValue != "")
            {
                dataGridView1.Rows.Clear();
                Dao dao = new Dao();
                string sql = $"SELECT research_achievement.id,research_achievement.`name`,research_achievement.contributer,research_achievement.get_date,research_achievement.project_id,achievement_type.`name`,research_achievement.rank FROM research_achievement INNER JOIN achievement_type ON research_achievement.type_id = achievement_type.id WHERE research_achievement.id = '{returnValue}'";
                MySqlDataReader reader = dao.Read(sql);
                while (reader.Read())
                {
                    dataGridView1.Rows.Add(
                        reader.GetString(0),
                        reader.GetString(1),
                        reader.GetString(2),
                        reader.GetString(3),
                        reader.GetString(4),
                        reader.GetString(5),
                        reader.GetString(6)
                        );
                }
                reader.Close();
                dao.DaoClose();
            }

        }

        private void toolStripMenuItem5_Click(object sender, EventArgs e)
        {
            string returnValue = Microsoft.VisualBasic.Interaction.InputBox("输入要修改的科研成果的成果号");
            if (returnValue != "")
            {
                try
                {
                    Dao dao = new Dao();
                    string sql = $"select * from research_achievement where id ='{returnValue}'";
                    MySqlDataReader reader = dao.Read(sql);
                    reader.Read();
                    string a1 = reader.GetString(0);
                    string a2 = reader.GetString(1);
                    string a3 = reader.GetString(2);
                    string a4 = reader.GetString(3);
                    string a5 = reader.GetString(4);
                    string a6 = reader.GetString(5);
                    string a7 = reader.GetString(6);
                    修改科研成果 modify = new 修改科研成果(a1, a2, a3, a4, a5, a6, a7);
                    modify.ShowDialog();
                    reader.Close();
                    dao.DaoClose();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("成果号不存在！");
                }
            }

        }
    }
}
