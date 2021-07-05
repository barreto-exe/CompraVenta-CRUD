using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public class Invoice : CrudObject
    {
        public static DataTable DataFromDataBase()
        {
            string query = "SELECT * FROM facturas";
            return CrudObject.DataFromDataBase(query);
        }

        public override string UpdateTupleDataBase()
        {
            throw new NotImplementedException();
        }
    }
}
