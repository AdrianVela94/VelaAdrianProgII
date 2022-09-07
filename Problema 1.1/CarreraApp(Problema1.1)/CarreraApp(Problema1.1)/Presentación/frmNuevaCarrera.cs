using CarreraApp_Problema1._1_.AccesoDatos;
using CarreraApp_Problema1._1_.Dominio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CarreraApp_Problema1._1_.Presentación
{
    public partial class frmNuevaCarrera : Form
    {

        Carrera carrera = new Carrera();
        DBHelper dbhelper = new DBHelper();
        public frmNuevaCarrera()
        {
            InitializeComponent();
        }

        private void frmNuevaCarrera_Load(object sender, EventArgs e)
        {
            cboMateria.DataSource = dbhelper.Consultar_SP("SP_consultar_asignaturas");
            cboMateria.ValueMember = "id_asignatura";
            cboMateria.DisplayMember = "nombre";
        }

        private void btnAgregarDetalle_Click(object sender, EventArgs e)
        {
            if (txtNombreCarrera.Text == "")
            {
                MessageBox.Show("Ingrese el nombre de la carrera", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (cboMateria.SelectedItem.Equals(String.Empty))
            {
                MessageBox.Show("Seleccione una materia", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (txtAnioCursado.Text == "")
            {
                MessageBox.Show("Debe ingresar un año de cursado", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (!rbnPrimerCuatrimestre.Checked && !rbnSegundoCuatrimestre.Checked)
            {
                MessageBox.Show("Debe seleccionar un cuatrimestre", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            foreach (DetalleCarrera dc in carrera.DetallesCarrera)
            {
                if (dc.Materia.Nombre == cboMateria.Text)
                {
                    MessageBox.Show("Solo puede agregar una vez cada materia", "Atención", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return;
                }
            }
            Asignatura asignatura = new Asignatura();
            asignatura.Codigo = Convert.ToInt32(cboMateria.SelectedValue);
            asignatura.Nombre = cboMateria.Text;
            int anioCursado = int.Parse(txtAnioCursado.Text);
            int cuatrimestre = 0;
            if (rbnPrimerCuatrimestre.Checked) cuatrimestre = 1;
            if (rbnSegundoCuatrimestre.Checked) cuatrimestre = 2;

            DetalleCarrera detCarrera = new DetalleCarrera(anioCursado, cuatrimestre, asignatura);
            carrera.AgregarDetalle(detCarrera);
            dgvDetalles.Rows.Add(new Object[] { asignatura.Codigo, asignatura.Nombre, anioCursado, cuatrimestre });
        }
    }
}
