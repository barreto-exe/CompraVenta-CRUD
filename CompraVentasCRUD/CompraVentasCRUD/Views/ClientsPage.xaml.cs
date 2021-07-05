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
    /// Lógica de interacción para ClientsPage.xaml
    /// </summary>
    public partial class ClientsPage : Page
    {
        private DataTable clientsDataTable;

        public ClientsPage()
        {
            InitializeComponent();
            UpdateClientsDataTable();
        }

        private void UpdateClientsDataTable()
        {
            clientsDataTable = Client.DataFromDataBase();
            DgClients.DataContext = clientsDataTable.DefaultView;
        }

        private void DataGridRow_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
