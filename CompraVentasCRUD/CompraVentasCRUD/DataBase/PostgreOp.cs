﻿using Npgsql;
using System;
using System.Collections.Generic;

namespace CompraVentasCRUD.DataBase
{
    public class PostgreOp : SqlOp<NpgsqlConnection, NpgsqlCommand, NpgsqlDataReader, NpgsqlDataAdapter>
    {
        static PostgreOp()
        {
            //Credenciales desde archivo de configuración.
            Servidor = Properties.BaseDatos.Default.ServidorPgSql;
            BaseDatos = Properties.BaseDatos.Default.BaseDatosPgSql;
            Usuario = Properties.BaseDatos.Default.UsuarioPgSql;
            Password = Properties.BaseDatos.Default.PassPgSql;
        }
        public PostgreOp() : base() { }
        public PostgreOp(string query) : base(query) { }

        public override NpgsqlCommand ComandoGenerado()
        {
            NpgsqlCommand command = new NpgsqlCommand()
            {
                CommandText = Query,
                Connection = ConexionGlobal
            };

            foreach (KeyValuePair<string, object> parametro in parametros)
            {
                command.Parameters.AddWithValue(parametro.Key, parametro.Value);
            }

            return command;
        }

        public override int EjecutarComando()
        {
            try
            {
                return ComandoGenerado().ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                switch (ex)
                {
                    case InvalidCastException ice:
                        throw ice;
                    case NpgsqlException se:
                        throw se;
                    default:
                        return 0;
                }
            }
        }

        ///<inheritdoc/>
        ///<exception cref="NpgsqlException"></exception>
        ///<exception cref="InvalidCastException"></exception>
        public override NpgsqlDataReader EjecutarReader()
        {
            try
            {
                return ComandoGenerado().ExecuteReader();
            }
            catch (Exception ex)
            {
                switch (ex)
                {
                    case InvalidCastException ice:
                        throw ice;
                    case NpgsqlException se:
                        throw se;
                    default:
                        throw ex;
                }
            }
        }

        public override NpgsqlConnection NuevaConexion()
        {
            RecargarDatosConexion();
            try
            {
                NpgsqlConnection connection = new NpgsqlConnection
                (
                    "Host=" + Servidor + ";" +
                    "Database=" + BaseDatos + ";" +
                    "Username=" + Usuario + ";" +
                    "Password=" + Password + ";"
                );
                connection.Open();
                return connection;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public override NpgsqlDataAdapter ObtenerAdapter()
        {
            return new NpgsqlDataAdapter(ComandoGenerado());
        }

        public override void RecargarDatosConexion()
        {
            //Credenciales desde archivo de configuración.
            Servidor = Properties.BaseDatos.Default.ServidorPgSql;
            BaseDatos = Properties.BaseDatos.Default.BaseDatosPgSql;
            Usuario = Properties.BaseDatos.Default.UsuarioPgSql;
            Password = Properties.BaseDatos.Default.PassPgSql;
        }
    }
}
