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
    public partial class 主菜单 : UIForm
    {
        public 主菜单()
        {
            InitializeComponent();
            项目 a = new 项目();
            a.TopLevel = false;      //设置为非顶级控件
            a.Dock = DockStyle.Fill;
            tabPage1.Controls.Add(a);
            a.Show();
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(uiTabControlMenu1.SelectedIndex == 0)
            {
                项目 a=new 项目();
                a.TopLevel = false;      //设置为非顶级控件
                a.Dock = DockStyle.Fill;
                tabPage1.Controls.Add(a);
                a.Show();
            }
            if (uiTabControlMenu1.SelectedIndex == 1)
            {
                科研人员 a = new 科研人员();
                a.TopLevel = false;      //设置为非顶级控件
                a.Dock = DockStyle.Fill;
                tabPage2.Controls.Add(a);
                a.Show();
            }
            if (uiTabControlMenu1.SelectedIndex == 2)
            {
                科研成果 a = new 科研成果();
                a.TopLevel = false;      //设置为非顶级控件
                a.Dock = DockStyle.Fill;
                tabPage3.Controls.Add(a);
                a.Show();
            }
            if (uiTabControlMenu1.SelectedIndex == 3)
            {
                研究室 a = new 研究室();
                a.TopLevel = false;      //设置为非顶级控件
                a.Dock = DockStyle.Fill;
                tabPage4.Controls.Add(a);
                a.Show();
            }
        }
    }
}
