namespace ex1
{
    partial class Form2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.servertextbox = new System.Windows.Forms.TextBox();
            this.usertextbox = new System.Windows.Forms.TextBox();
            this.passwordtextbox = new System.Windows.Forms.TextBox();
            this.testligacaobutton = new System.Windows.Forms.Button();
            this.holdtablebutton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(80, 59);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(50, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Server";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(83, 149);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(38, 17);
            this.label2.TabIndex = 1;
            this.label2.Text = "User";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(80, 228);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(69, 17);
            this.label3.TabIndex = 2;
            this.label3.Text = "Password";
            // 
            // servertextbox
            // 
            this.servertextbox.Location = new System.Drawing.Point(203, 59);
            this.servertextbox.Name = "servertextbox";
            this.servertextbox.Size = new System.Drawing.Size(489, 22);
            this.servertextbox.TabIndex = 3;
            this.servertextbox.TextChanged += new System.EventHandler(this.servertextbox_TextChanged);
            // 
            // usertextbox
            // 
            this.usertextbox.Location = new System.Drawing.Point(203, 144);
            this.usertextbox.Name = "usertextbox";
            this.usertextbox.Size = new System.Drawing.Size(489, 22);
            this.usertextbox.TabIndex = 4;
            this.usertextbox.TextChanged += new System.EventHandler(this.usertextbox_TextChanged);
            // 
            // passwordtextbox
            // 
            this.passwordtextbox.Location = new System.Drawing.Point(203, 223);
            this.passwordtextbox.Name = "passwordtextbox";
            this.passwordtextbox.PasswordChar = '*';
            this.passwordtextbox.Size = new System.Drawing.Size(489, 22);
            this.passwordtextbox.TabIndex = 5;
            this.passwordtextbox.TextChanged += new System.EventHandler(this.passwordtextbox_TextChanged);
            // 
            // testligacaobutton
            // 
            this.testligacaobutton.Location = new System.Drawing.Point(203, 332);
            this.testligacaobutton.Name = "testligacaobutton";
            this.testligacaobutton.Size = new System.Drawing.Size(237, 78);
            this.testligacaobutton.TabIndex = 6;
            this.testligacaobutton.Text = "Test Ligação";
            this.testligacaobutton.UseVisualStyleBackColor = true;
            this.testligacaobutton.Click += new System.EventHandler(this.testligacaobutton_Click);
            // 
            // holdtablebutton
            // 
            this.holdtablebutton.Location = new System.Drawing.Point(455, 332);
            this.holdtablebutton.Name = "holdtablebutton";
            this.holdtablebutton.Size = new System.Drawing.Size(237, 78);
            this.holdtablebutton.TabIndex = 7;
            this.holdtablebutton.Text = "Hold Table";
            this.holdtablebutton.UseVisualStyleBackColor = true;
            this.holdtablebutton.Click += new System.EventHandler(this.holdtablebutton_Click);
            // 
            // Form2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(777, 450);
            this.Controls.Add(this.holdtablebutton);
            this.Controls.Add(this.testligacaobutton);
            this.Controls.Add(this.passwordtextbox);
            this.Controls.Add(this.usertextbox);
            this.Controls.Add(this.servertextbox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "Form2";
            this.Text = "Aula 1 BD";
            this.Load += new System.EventHandler(this.Form2_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox servertextbox;
        private System.Windows.Forms.TextBox usertextbox;
        private System.Windows.Forms.TextBox passwordtextbox;
        private System.Windows.Forms.Button testligacaobutton;
        private System.Windows.Forms.Button holdtablebutton;
    }
}