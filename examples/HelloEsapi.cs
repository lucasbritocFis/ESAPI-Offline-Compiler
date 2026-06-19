using System;
using System.Windows.Forms;
using System.Linq;
using VMS.TPS.Common.Model.API;
using VMS.TPS.Common.Model.Types;

[assembly: AssemblyVersion("1.0.0.0")]
[assembly: ESAPIScript(IsWriteable = false)]

namespace VMS.TPS
{
    public class Script
    {
        public void Execute(ScriptContext context)
        {
            if (context.Patient == null)
            {
                MessageBox.Show("Nenhum paciente aberto.", "Hello ESAPI");
                return;
            }

            var ss = context.StructureSet;
            if (ss == null)
            {
                MessageBox.Show("Nenhum StructureSet ativo.", "Hello ESAPI");
                return;
            }

            var structures = ss.Structures
                .Where(s => !s.IsEmpty)
                .Select(s => s.Id)
                .OrderBy(id => id)
                .ToList();

            string msg = $"Paciente: {context.Patient.LastName}, {context.Patient.FirstName}\n" +
                         $"Estruturas encontradas ({structures.Count}):\n" +
                         string.Join(", ", structures);

            MessageBox.Show(msg, "Compilação ESAPI bem-sucedida!");
        }
    }
}
