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
        public MainWindow()
        {
            InitializeComponent();
            HamburguerButton.IsChecked = true;
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
    }
}
