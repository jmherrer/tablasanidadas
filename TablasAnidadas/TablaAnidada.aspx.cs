using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

namespace TablasAnidadas
{
    public partial class TablaAnidada : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                grvModelos.DataSource = CargarDatos("select pm.ProductModelID, pm.Name from Production.ProductModel as pm order by pm.Name");
                grvModelos.DataBind();
            }
        }

        /// <summary>
        /// Obtener datos de MS SQL server a partir de una query.
        /// </summary>
        /// <param name="query">Query a ejecutar en la base Adventure Works.</param>
        /// <returns>Devuelve un DataTable</returns>
        public static DataTable CargarDatos(string query)
        {
            string strinConn = "Data Source=.\\sqlexpress;Initial Catalog=AdventureWorks2012;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection (strinConn)) {
                using (SqlCommand cmd = new SqlCommand()){
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter()){
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet()){
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Cargamos la tabla hijo de productos según el ID de ProductoModelID
        /// </summary>
        protected void grvModelos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string ProductModelID = grvModelos.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView grvProductos = e.Row.FindControl("grvProductos") as GridView;
                grvProductos.DataSource = CargarDatos(string.Format("select p.ProductID, p.ProductNumber, p.Name, p.StandardCost, p.ListPrice from Production.Product as p where p.ProductModelID = {0}", ProductModelID));
                grvProductos.DataBind();
            }
        }
    }
}