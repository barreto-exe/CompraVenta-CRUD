using CompraVentasCRUD.DataBase;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public class CrudObject
    {
        protected static DataTable DataFromDataBase(string queryString)
        {
            DataSet set = new DataSet();

            PostgreOp op = new PostgreOp(queryString);
            try
            {
                DataAdapter da = op.ObtenerAdapter();
                da.Fill(set);
            }
            catch (Exception ex)
            {

            }

            return set.Tables[0];
        }
    }
}
