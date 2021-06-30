using CompraVentasCRUD.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CompraVentasCRUD
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private ClientsPage clients;
        private InvoicesPage invoices;
        private ArticlesPage articles;
        private LinesPage lines;

        public MainWindow()
        {
            InitializeComponent();
            HamburguerButton.IsChecked = true;
            
            clients = new ClientsPage();
            invoices = new InvoicesPage();
            articles = new ArticlesPage();
            lines = new LinesPage();
            DrawerList.SelectedIndex = 0;
        }

        private void HamburguerButton_Click(object sender, RoutedEventArgs e)
        {
            Visibility textOnItems;
            if((bool)HamburguerButton.IsChecked)
            {
                DrawerCol.Width = 200;
                textOnItems = Visibility.Visible;
            }
            else
            {
                DrawerCol.Width = 70;
                textOnItems = Visibility.Hidden;
            }

            //Setting visibility just for icons (collapsed drawer)
            foreach (StackPanel item in DrawerList.Items)
            {
                item.Children[1].Visibility = textOnItems;
            }
        }

        private void DrawerList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch(DrawerList.SelectedIndex)
            {
                case 0:
                    {
                        MainFrame.Content = clients;
                        break;
                    }
                case 1:
                    {
                        MainFrame.Content = invoices;
                        break;
                    }
                case 2:
                    {
                        MainFrame.Content = articles;
                        break;
                    }
                case 3:
                    {
                        MainFrame.Content = lines;
                        break;
                    }
            }

        }
    }
}
