using CompraVentasCRUD.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace CompraVentasCRUD.Views
{
    /// <summary>
    /// Lógica de interacción para ArticleWindow.xaml
    /// </summary>
    public partial class ArticleWindow : Window
    {
        private Article article;
        public ArticleWindow()
        {
            InitializeComponent();
        }

        public ArticleWindow(Article article)
        {
            InitializeComponent();

            this.article = article;
            SetDataToFields(article);
        }

        private void SetDataToFields(Article article)
        {
            TxtCode.Text = article.CodeArticle;
            TxtDescription.Text = article.Description;
            TxtLine.Text = article.CodeLine;
            TxtPrice.Text = article.Price.ToString();
            TxtExistence.Text = article.Existence.ToString();
            TxtMaximum.Text = article.Maximum.ToString();
            TxtMinimum.Text = article.Minimun.ToString();
            switch (article.Status)
            {
                case 'A':
                    {
                        CbStatus.SelectedIndex = 0;
                        break;
                    }
                case 'D':
                    {
                        CbStatus.SelectedIndex = 1;
                        break;
                    }
                case 'R':
                    {
                        CbStatus.SelectedIndex = 2;
                        break;
                    }
            }
            DpDateOut.SelectedDate = article.DateOut;
        }
        private void SetDataToObject()
        {
            article.CodeArticle = TxtCode.Text;
            article.Description = TxtDescription.Text;
            article.CodeLine = TxtLine.Text;
            article.Price = Convert.ToDecimal(TxtPrice.Text);
            article.Existence = Convert.ToInt32(TxtExistence.Text);
            article.Maximum = Convert.ToInt32(TxtMaximum.Text);
            article.Minimun = Convert.ToInt32(TxtMinimum.Text);
            switch (CbStatus.SelectedIndex)
            {
                case 0:
                    {
                        article.Status = 'A';
                        break;
                    }
                case 1:
                    {
                        article.Status = 'D';
                        break;
                    }
                case 2:
                    {
                        article.Status = 'R';
                        break;
                    }
            }
            try
            {
                article.DateOut = (DateTime)DpDateOut.SelectedDate;
            }
            catch
            {

            }
        }

        private void BtnCancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        private void BtnAceptar_Click(object sender, RoutedEventArgs e)
        {
            SetDataToObject();
            string message = article.UpdateTupleDataBase();
            if(message == "")
            {
                MessageBox.Show("Actualización exitosa");
                this.Close();
            }
            else
            {
                MessageBox.Show("Actualización fallida: \n" + message);
            }
        }
    }
}
