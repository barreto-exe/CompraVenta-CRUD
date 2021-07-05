using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public class Article : CrudObject
    {
        public static DataTable DataFromDataBase()
        {
            string query = "SELECT * FROM articulos";
            return CrudObject.DataFromDataBase(query);
        }
    }
}
