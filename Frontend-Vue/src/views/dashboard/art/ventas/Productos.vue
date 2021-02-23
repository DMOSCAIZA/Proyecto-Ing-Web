<template>
  <v-container
    id="regular-tables"
    fluid
    tag="section"
  >
    <base-v-component
      heading="Simple Tables"
      link="components/simple-tables"
    />

    <base-material-card
      icon="mdi-clipboard-text"
      title="Simple Table"
      class="px-5 py-3"
    >
      <v-simple-table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Condición</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="categoria in categorias" :key="categoria.idcategoria">
            <td>{{ categoria.idcategoria }}</td>
            <td>{{ categoria.nombre }}</td>
            <td>{{ categoria.descripcion }}</td>
            <td>{{ categoria.condicion }}</td>
          </tr>
        </tbody>
      </v-simple-table>
    </base-material-card>

  </v-container>
</template>


<script>
  import axios from 'axios'
  export default {
    data () {
      return {
        categorias: [],
        dialog: false,
        operacion: '',

        categoria:{
          idcategoria: null,
          nombre:'',
          descripcion:'',
          condicion:''
        }
      }
    },
    created(){
         this.mostrar()
    },
    methods: {
      //MÉTODOS PARA EL CRUD
      mostrar:function(){
        axios.post('api/crud.php',{opcion:1})
        .then(response =>{
          this.categoria = response.data;
        })
      },




    },

  }
</script>


