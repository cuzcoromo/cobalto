const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.syncDeudaOnCobroChange = functions.firestore
    .document("cobro_realizado_medidor/{docId}")
    .onWrite(async (change, context) => {
      const newData = change.after.exists ? change.after.data() : null;
      const oldData = change.before.exists ? change.before.data() : null;

      if (!newData) {
        // Se borró un cobro → eliminar deuda
        const usuarioRef = oldData.usuario_id;
        const anio = oldData.anio;
        const mes = oldData.mes;
        const deudaDocId = `${usuarioRef.id}-${anio}-${mes}`;

        await db.collection("deuda_medidor").doc(deudaDocId).delete();
        return null;
      }

      const usuarioRef = newData.usuario_id;
      const anio = newData.anio;
      const mes = newData.mes;
      const deudaDocId = `${usuarioRef.id}-${anio}-${mes}`;

      if (newData.completedAt == null) {
        // No ha pagado → crear/actualizar deuda
        await db.collection("deuda_medidor").doc(deudaDocId).set({
          usuario_id: usuarioRef,
          anio: anio,
          mes: mes,
          // Puedes hacer que lo calcule desde precio_id si lo deseas
          monto_deuda: 100,
          estado: "pendiente",
          fecha_vencimiento: admin.firestore.Timestamp.now(),
        }, {merge: true});
      } else {
        // Ya pagó → eliminar deuda
        await db.collection("deuda_medidor").doc(deudaDocId).delete();
      }

      return null;
    });
