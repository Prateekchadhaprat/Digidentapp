using System;
using System.Text.RegularExpressions;
using System.Windows;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Data;

namespace DocREpMan
{
    public partial class MainWindow : Window
    {
        private const string connectionString = "Data Source=DESKTOP-8F7MD3P\\SQLEXPRESS;Initial Catalog=Digidentdb;Integrated Security=True";

        public MainWindow()
        {
            InitializeComponent();
        }
        private void JobComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Console.WriteLine("Selection changed event triggered.");
            if (jobComboBox.SelectedItem != null)
            {
                var selectedRole = ((ComboBoxItem)jobComboBox.SelectedItem).Content.ToString();
                if (selectedRole == "Dentist")
                {
                    LicenseNumberText.Visibility = Visibility.Visible;
                    jobTextBox.Visibility = Visibility.Visible;
                }
                else
                {
                    LicenseNumberText.Visibility = Visibility.Collapsed;
                    jobTextBox.Visibility = Visibility.Collapsed;
                }
            }
        }

        private void SubmitButton_Click(object sender, RoutedEventArgs e)
        {
            ValidateEmail();
            // Call other validation methods...
            ValidateEmail();
            ValidatePassword();
            ValidateConfirmPassword();
            ValidateFirstName();
            ValidateLastName();
            ValidateDateOfBirth();
            ValidateAddress();
            ValidatePhoneNumber();

            if (!string.IsNullOrEmpty(EmailErrorText.Text) ||
                !string.IsNullOrEmpty(PasswordErrorText.Text) ||
                !string.IsNullOrEmpty(ConfirmPasswordErrorText.Text) ||
                !string.IsNullOrEmpty(FirstNameErrorText.Text) ||
                !string.IsNullOrEmpty(LastNameErrorText.Text) ||
                !string.IsNullOrEmpty(DateOfBirthErrorText.Text) ||
                !string.IsNullOrEmpty(AddressErrorText.Text) ||
                !string.IsNullOrEmpty(PhoneNumberErrorText.Text))
            {
                MessageBox.Show("Please check the fields!");
                return;
            }

            string email = EmailTextBox.Text;
            string password = PasswordBox.Password;
            string firstName = FirstNameTextBox.Text;
            string lastName = LastNameTextBox.Text;
            DateTime dateOfBirth = DateOfBirthPicker.SelectedDate ?? DateTime.MinValue;
            string address = AddressTextBox.Text;
            string phoneNumber = PhoneNumberTextBox.Text;
            string role = ((ComboBoxItem)jobComboBox.SelectedItem)?.Content?.ToString() ?? string.Empty;
            string? licenseNumber = role == "Dentist" ? jobTextBox?.Text : null;

            MessageBox.Show($"Email: {email}\nRole: {role}\nLicenseNumber: {licenseNumber}");

            string storedProcedureName = role switch
            {
                "Dentist" => "InsertDentist",
                "Customer representatives" => "InsertCustomerRepresentative",
                "Manager" => "InsertManager",
                _ => throw new InvalidOperationException("Unsupported role")
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(storedProcedureName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@FirstName", firstName);
                        command.Parameters.AddWithValue("@LastName", lastName);
                        command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                        command.Parameters.AddWithValue("@Address", address);
                        command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

                        if (role == "Dentist" && !string.IsNullOrEmpty(licenseNumber))
                        {
                            command.Parameters.AddWithValue("@LicenseNumber", licenseNumber);
                        }

                        int rowsAffected = command.ExecuteNonQuery();

                        // Log or show the number of rows affected
                       // MessageBox.Show($"Rows affected: {rowsAffected}");

                        if (rowsAffected > 0 || rowsAffected == -1) // Handle special case where rowsAffected might be -1
                        {
                            MessageBox.Show("User registered successfully!");
                        }
                        else
                        {
                            MessageBox.Show("User registration failed. No rows were affected.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"An error occurred: {ex.Message}\nStack Trace: {ex.StackTrace}");
                }
            }
        }



        private void EmailTextBox_GotFocus(object sender, RoutedEventArgs e)
        {
            EmailErrorText.Text = "";
        }

        private void ValidateEmail()
        {
            string email = EmailTextBox.Text.Trim();
            if (string.IsNullOrEmpty(email))
            {
                EmailErrorText.Text = "Email is required.";
                return;
            }

            if (!IsValidEmail(email))
            {
                EmailErrorText.Text = "Please enter a valid email address.";
                return;
            }

            EmailErrorText.Text = "";
        }

        private bool IsValidEmail(string email)
        {
            string pattern = @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
            return Regex.IsMatch(email, pattern);
        }

        private void PasswordBox_GotFocus(object sender, RoutedEventArgs e)
        {
            PasswordErrorText.Text = "";
        }

        private void ValidatePassword()
        {
            string password = PasswordBox.Password.Trim();
            if (string.IsNullOrEmpty(password))
            {
                PasswordErrorText.Text = "Password is required.";
                return;
            }

            if (!IsPasswordValid(password))
            {
                PasswordErrorText.Text = "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.";
                return;
            }

            PasswordErrorText.Text = "";
        }

        private bool IsPasswordValid(string password)
        {
            return Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}$");
        }

        private void ConfirmPasswordBox_GotFocus(object sender, RoutedEventArgs e)
        {
            ConfirmPasswordErrorText.Text = "";
        }

        private void ValidateConfirmPassword()
        {
            string password = PasswordBox.Password.Trim();
            string confirmPassword = ConfirmPasswordBox.Password.Trim();

            if (string.IsNullOrEmpty(confirmPassword))
            {
                ConfirmPasswordErrorText.Text = "Confirm password is required.";
                return;
            }

            if (password != confirmPassword)
            {
                ConfirmPasswordErrorText.Text = "Passwords do not match.";
                return;
            }

            ConfirmPasswordErrorText.Text = "";
        }

        private void FirstNameTextBox_LostFocus(object sender, RoutedEventArgs e)
        {
            ValidateFirstName();
        }

        private void ValidateFirstName()
        {
            if (string.IsNullOrWhiteSpace(FirstNameTextBox.Text))
            {
                FirstNameErrorText.Text = "First Name is required.";
            }
            else if (!Regex.IsMatch(FirstNameTextBox.Text, "^[a-zA-Z'-]+$"))
            {
                FirstNameErrorText.Text = "First Name can only contain letters, apostrophes, and hyphens.";
            }
            else
            {
                FirstNameErrorText.Text = string.Empty;
            }
        }

        private void ValidateLastName()
        {
            string lastName = LastNameTextBox.Text.Trim();

            if (string.IsNullOrEmpty(lastName))
            {
                LastNameErrorText.Text = "Last Name is required.";
                return;
            }

            if (!Regex.IsMatch(lastName, "^[a-zA-Z'-]+$"))
            {
                LastNameErrorText.Text = "Last Name can only contain letters, apostrophes, and hyphens.";
                return;
            }

            if (lastName.Length > 50)
            {
                LastNameErrorText.Text = "Last Name cannot exceed 50 characters.";
                return;
            }

            LastNameErrorText.Text = "";
        }

        private void DateOfBirthPicker_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            ValidateDateOfBirth();
        }

        private void ValidateDateOfBirth()
        {
            if (DateOfBirthPicker.SelectedDate == null || DateOfBirthPicker.SelectedDate > DateTime.Now)
            {
                DateOfBirthErrorText.Text = "Please enter a valid date of birth.";
            }
            else
            {
                DateOfBirthErrorText.Text = string.Empty;
            }
        }

        private void ValidateAddress()
        {
            string address = AddressTextBox.Text.Trim();

            if (string.IsNullOrEmpty(address))
            {
                AddressErrorText.Text = "Address is required.";
                return;
            }

            if (address.Length > 100)
            {
                AddressErrorText.Text = "Address cannot exceed 100 characters.";
                return;
            }

            AddressErrorText.Text = "";
        }

        private void ValidatePhoneNumber()
        {
            string phoneNumber = PhoneNumberTextBox.Text.Trim();

            if (string.IsNullOrEmpty(phoneNumber))
            {
                PhoneNumberErrorText.Text = "Phone Number is required.";
                return;
            }

            if (!Regex.IsMatch(phoneNumber, @"^[0-9]+$"))
            {
                PhoneNumberErrorText.Text = "Phone Number can only contain numbers.";
                return;
            }

            if (phoneNumber.Length != 10)
            {
                PhoneNumberErrorText.Text = "Phone Number must be 10 digits long.";
                return;
            }

            PhoneNumberErrorText.Text = "";
        }
    }
}
