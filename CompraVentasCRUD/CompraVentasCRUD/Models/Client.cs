using CompraVentasCRUD.DataBase;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public class Client : CrudObject
    {
        #region Atributes
        public string Rif { get; set; }
        public string Cedula { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Status { get; set; }
        public DateTime DateIn { get; set; }
        public DateTime DateOut { get; set; }
        public string Email { get; set; }
        #endregion
        
        public static DataTable DataFromDataBase()
        {
            string query = "SELECT * FROM clientes";
            return CrudObject.DataFromDataBase(query);
        }
    }
}
