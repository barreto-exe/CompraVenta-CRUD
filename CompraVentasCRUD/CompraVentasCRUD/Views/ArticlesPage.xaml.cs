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
    /// Lógica de interacción para ArticlesPage.xaml
    /// </summary>
    public partial class ArticlesPage : Page
    {
        private DataTable articlesDataTable;

        public ArticlesPage()
        {
            InitializeComponent();
            UpdateArticlesDataTable();
        }

        private void UpdateArticlesDataTable()
        {
            articlesDataTable = Article.DataFromDataBase();
            DgArticles.DataContext = articlesDataTable.DefaultView;
        }

        private void DataGridRow_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
