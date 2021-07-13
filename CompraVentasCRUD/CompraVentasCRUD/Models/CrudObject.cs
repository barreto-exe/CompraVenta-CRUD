using CompraVentasCRUD.DataBase;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public abstract class CrudObject
    {
        /// <summary>
        /// Actualiza el registro en la base de datos (usa el código cómo referencia).
        /// </summary>
        /// <returns>Mensaje de error si la operación falla. Vacío si la operación es exitosa.</returns>
        public abstract string UpdateTupleDataBase();

        /// <summary>
        /// Registra la tupla en la base de datos.
        /// </summary>
        /// <returns>Mensaje de error si la operación falla. Vacío si la operación es exitosa.</returns>
        public abstract string InsertTupleDataBase();

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
