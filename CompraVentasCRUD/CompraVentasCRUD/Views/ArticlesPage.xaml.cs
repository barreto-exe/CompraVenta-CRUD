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
            object[] row = ((DataRowView)((DataGridRow)sender).DataContext).Row.ItemArray;

            Article article = new Article();
            article.CodeArticle = (string)row[0];
            article.Description = (string)row[1];
            article.CodeLine = (string)row[2];
            article.Price = (decimal)row[3];
            article.Existence = (int)row[4];
            article.Maximum = (int)row[5];
            article.Minimun = (int)row[6];
            article.Status = row[7].ToString()[0];
            article.DateOut = (DateTime)row[8];

            ArticleWindow aw = new ArticleWindow(article);
            aw.ShowDialog();
            UpdateArticlesDataTable();
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            ArticleWindow aw = new ArticleWindow();
            aw.ShowDialog();
            UpdateArticlesDataTable();
        }
    }
}
