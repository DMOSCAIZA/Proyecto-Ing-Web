<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="dark">

                <v-toolbar-title>Comprobantes</v-toolbar-title>
                <v-divider
                class="mx-2"
                inset
                vertical
                ></v-divider>

                <v-spacer></v-spacer>
                <v-text-field class="text-xs-center" v-model="search" append-icon="search" label="Búsqueda" single-line hide-details></v-text-field>
                <v-spacer></v-spacer>

                <v-dialog v-model="dialog" max-width="500px">

                    <template v-slot:activator="{ on, attrs }">
              <v-btn class="mx-2" fab dark large color="purple" v-bind="attrs" v-on="on">
                <v-icon dark>
                  mdi-plus
                </v-icon>
              </v-btn>
                    </template>


                    <v-card>
                        <v-card-title>
                        <span class="headline">{{ formTitle }}</span>
                        </v-card-title>

                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                <!-- Campos de la ventana modal-->
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="tipo_comp" label="Tipo Comprobante"></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="numero_comp" label="N° Comprobante"></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="descuento_comp" label="Descuento"></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="total_comp" label="Total"></v-text-field>
                                </v-flex>

                                <v-flex xs12 sm12 md12 v-show="valida">
                                    <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v">
                                    </div>
                                </v-flex>

                                </v-layout>
                            </v-container>
                        </v-card-text>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <!-- Botones de la ventana modal-->
                            <v-btn color="red darken-1" flat @click.native="cerrar">Cancelar</v-btn>
                            <v-btn color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                        </v-card-actions>
                    </v-card>

                </v-dialog>

                <v-dialog v-model="adModal" max-width="500px"></v-dialog>

            </v-toolbar>

            <v-data-table
                :headers="headers"
                :items="comprobantes"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">
                        <td>{{ props.item.idComprobante }}</td>
                        <td>{{ props.item.tipo_comp }}</td>
                        <td>{{ props.item.numero_comp }}</td>
                        <td>{{ props.item.descuento_comp }}</td>
                        <td>{{ props.item.total_comp }}</td>
                    </template>

                    <!--template v-slot:item.opciones="{ item }"-->
                    <template v-slot:[`item.opciones`]="{ item }">
                        <v-btn
                            class="mx-2"
                            fab
                            dark
                            x-small
                            color="secondary"
                            >
                                <v-icon
                                    class="mx-2"
                                    fab
                                    dark
                                    x-small
                                    @click="editItem(item)"
                                >mdi-border-color
                                </v-icon>
                        </v-btn>
                    </template>

        <template slot="no-data" class="mx-5">
          <v-spacer class="ma-5"></v-spacer>
            <span>
              NO SE HAN ENCONTRADO DATOS, INTENTE RECARGAR
            </span>
          <v-spacer class="ma-2"></v-spacer>
            <v-btn
              :loading="loading"
              :disabled="loading"
              color=#000000
              class="ma-2 white--text"
              @click="listar, loader = 'loading'"
              :to="{name:'productos'}"
            >
              <v-icon left>
                  mdi-reload
              </v-icon>
                Recargar
            </v-btn>
          <v-spacer class="ma-5"></v-spacer>
        </template>
            </v-data-table>

        </v-flex>
    </v-layout>
</template>


<script>
    import axios from 'axios'
    export default {
        data: () => ({
            comprobantes:[],
            dialog: false,
            loader: null,
            loading: false,
            headers: [
                { text: 'Id', value: 'idComprobante' },
                { text: 'Tipo Comprobante', value: 'tipo_comp', sortable: false},
                { text: 'N° Comprobante', value: 'numero_comp'},
                { text: 'Descuento', value: 'descuento_comp'},
                { text: 'Total', value: 'total_comp'},
                { text: 'Opciones', value: 'opciones', sortable: false}
            ],

            search: '',
            editedIndex: -1,
            idComprobante: '',
            tipo_comp : '',
            numero_comp : '',
            descuento_comp : '',
            total_comp : '',
            valida: 0,
            validaMensaje:[],
            adModal: 0,
            adAction: 0,

        }),

        computed: {
            formTitle () {
                 return this.editedIndex === -1 ? 'Nuevo Comprobante' : 'Actualizando Comprobante'
            }
        },

        watch: {
          dialog (val) {
            val || this.cerrar()
          },
          loader () {
            const l = this.loader
            this[l] = !this[l]
            setTimeout(() => (this[l] = false), 3000)
            this.loader = null
          },
        },

        created () {
            //this.initialize()
            this.listar()
        },
        methods:{
            listar(){
                let me =this;
                axios.get('api/Comprobantes/Listar').then(function(response){
                  //  console.log(response);
                  me.comprobantes=response.data;
                }).catch(function(error){
                    console.log(error);

                });

            },

            initialize () {
            this.listar();

            },

            editItem (item) {
                this.idComprobante=item.idComprobante ;
                this.tipo_comp=item.tipo_comp;
                this.numero_comp=item.numero_comp;
                this.descuento_comp=item.descuento_comp;
                this.total_comp=item.total_comp;
                this.editedIndex=1;
                this.dialog = true
            },

            cerrar () {
                this.dialog = false;
                this.limpiar();

            },

            limpiar(){
                this.idComprobante="";
                this.tipo_comp="";
                this.numero_comp="";
                this.descuento_comp="";
                this.total_comp="";
                this.editedIndex=-1;
            },

            guardar () {

                if(this.validar()){
                    return;
                }
                if (this.editedIndex > -1) {
                    //código para editar

                    let me=this;
                    axios.put('api/Comprobantes/Actualizar',{
                        'tipo_comp': me.tipo_comp,
                        'numero_comp': me.numero_comp,
                        'descuento_comp': me.descuento_comp,
                        'total_comp': me.total_comp,
                        'idComprobante':me.idComprobante,
                    }).then(function(response){
                        me.cerrar();
                        me.listar();
                        me.limpiar();

                    }).catch(function(error){
                        console.log(error);
                    });
                } else {
                    // código para guardar
                    let me=this;
                    axios.post('api/Comprobantes/Crear',{
                        'idComprobante':me.idComprobante,
                        'tipo_comp': me.tipo_comp,
                        'numero_comp': me.numero_comp,
                        'descuento_comp': me.descuento_comp,
                        'total_comp': me.total_comp,

                    }).then(function(response){
                        me.cerrar();
                        me.listar();
                        me.limpiar();

                    }).catch(function(error){
                        console.log(error);
                    });
                }

            },

           validar(){
               this.valida=0;
               this.validaMensaje=[];
               /*if(this.tipo_comprobante.length < 3 || this.numero_comp .length > 40){
                   this.validaMensaje.push("El nombre debe tener más de 3 caracteres y menos de 50 caracteres");
               }*/
               if(this.validaMensaje.length){
                   this.valida=1;
               }
               return this.valida;
           },
        }
    }
</script>

<style>
  .custom-loader {
    animation: loader 1s infinite;
    display: flex;
  }
  @keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
</style>
