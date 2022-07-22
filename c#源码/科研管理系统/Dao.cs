using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;


namespace 科研管理系统
{
    class Dao
    {
        MySqlConnection Conn;
        public MySqlConnection Connect()
        {
            Conn = new MySqlConnection("server = localhost; port = 3306; user = root; password = LJPZZQ408; database = science;CharSet=utf8;");
            Conn.Open();
            return Conn;
        }

        public MySqlCommand Command(string sql)
        {
            MySqlCommand cmd = new MySqlCommand(sql,Connect());
            return cmd;
        }

        public int Execute(string sql)
        {
            return Command(sql).ExecuteNonQuery();
        }

        public MySqlDataReader Read(string sql)
        {
            return Command(sql).ExecuteReader();
        }

        public void DaoClose()
        {
            Conn.Close();
        }

    }
}
