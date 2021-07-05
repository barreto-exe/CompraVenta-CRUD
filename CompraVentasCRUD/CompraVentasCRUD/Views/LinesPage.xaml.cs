using CompraVentasCRUD.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CompraVentasCRUD.Views
{
    /// <summary>
    /// Lógica de interacción para LinesPage.xaml
    /// </summary>
    public partial class LinesPage : Page
    {
        private DataTable linesDataTable;

        public LinesPage()
        {
            InitializeComponent();
            UpdateLinesDataTable();
        }

        private void UpdateLinesDataTable()
        {
            linesDataTable = Models.Line.DataFromDataBase();
            DgLines.DataContext = linesDataTable.DefaultView;
        }
    }
}
