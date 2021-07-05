using CompraVentasCRUD.DataBase;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace CompraVentasCRUD.Models
{
    public class Article : CrudObject
    {
        #region Atributes
        public string CodeArticle { get; set; }
        public string Description { get; set; }
        public string CodeLine { get; set; }
        public decimal Price { get; set; }
        public int Existence { get; set; }
        public int Minimun { get; set; }
        public int Maximum { get; set; }
        public char Status { get; set; }
        public DateTime DateOut { get; set; }
        #endregion

        public static DataTable DataFromDataBase()
        {
            string query = "SELECT * FROM articulos";
            return CrudObject.DataFromDataBase(query);
        }

        public override string UpdateTupleDataBase()
        {
            string error = "";

            string query = 
                "UPDATE articulos " +
                "SET cod_articulo = @cod_articulo, " +
                "descripcion = @descripcion, " +
                "cod_linea = @cod_linea, " +
                "precio = @precio, " +
                "existencia = @existencia, " +
                "maximo = @maximo, " +
                "minimo = @minimo, " +
                "status_a = @status_a, " +
                "fecha_out = @fecha_out " +
                "WHERE cod_articulo = @cod_articulo";
            PostgreOp op = new PostgreOp(query);
            op.PasarParametros("cod_articulo", CodeArticle.Trim());
            op.PasarParametros("descripcion", Description);
            op.PasarParametros("cod_linea", CodeLine);
            op.PasarParametros("precio", Price);
            op.PasarParametros("existencia", Existence);
            op.PasarParametros("maximo", Maximum);
            op.PasarParametros("minimo", Minimun);
            op.PasarParametros("status_a", Status);
            op.PasarParametros("fecha_out", DateOut);

            try
            {
                op.EjecutarComando();
            }
            catch(Exception ex)
            {
                error = ex.Message;
            }

            return error;
        }
    }
}
