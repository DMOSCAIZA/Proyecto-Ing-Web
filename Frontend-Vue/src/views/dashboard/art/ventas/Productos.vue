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
            <th>Descripción</th>
            <th>XD</th>
            <th>XD</th>
            <th>XD</th>
            <th>XD</th>
            <th>XD</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="producto in productos" :key="producto.id">

          </tr>
        </tbody>

      </v-simple-table>
    </base-material-card>

  </v-container>
</template>

