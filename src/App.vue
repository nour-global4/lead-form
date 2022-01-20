<template>
  <v-app>
    <v-flex class="lead-form">
      <v-row class="lead-form__header">
        <v-col>
        <div class="lead-form__header_logo">
            <div class="logo_wrapper">
              <img alt="home_telecom_logo" src="@/assets/logo.png" width="200"/>
            </div>
          </div>
          <v-container>
            <div class="lead-form__header_title">
              <h1>The easiest way to <br/> pass a lead</h1>
            </div>
          </v-container>
        </v-col>
      </v-row>
      <div class="lead-form__form">
        <v-container>
          <div class="lead-form__form_top">
            <h2>Lead pass form</h2>
            <p>Please ensure that all information provided is entered correctly.</p>
          </div>
          <div>
            <v-form
                ref="form"
                v-model="valid"
                lazy-validation
            >
              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-select
                      v-model="payload.group"
                      :items="groups"
                      :rules="[v => !!v || 'Group is required']"
                      label="Group"
                      required
                  ></v-select>

                  <v-text-field
                      v-model="payload.property_ref"
                      :rules="nameRules"
                      label="Agent Code"
                      required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.advisor_name"
                      :rules="nameRules"
                      label="Advisor Name"
                      required
                      transition="none"
                  ></v-text-field>

                  <v-text-field
                      v-model="payload.agent_name"
                      :rules="nameRules"
                      label="Agent Name"
                      required
                  ></v-text-field>
                </v-col>
              </v-row>

              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-checkbox
                      v-model="payload.dont_contact_again"
                      label="Do not contact again"
                  ></v-checkbox>
                </v-col>
              </v-row>
              <h3>Personal Information</h3>
              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-select
                      v-model="payload.title"
                      :items="titles"
                      :rules="[v => !!v || 'Title is required']"
                      label="Title"
                      required
                  ></v-select>

                  <v-text-field
                      v-model="payload.first_name"
                      :rules="nameRules"
                      label="First Name"
                      required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.last_name"
                      :rules="nameRules"
                      label="Last Name"
                      required
                  ></v-text-field>
                  <v-text-field
                      v-model="payload.email"
                      :rules="emailRules"
                      label="E-mail"
                      required
                  ></v-text-field>
                </v-col>
              </v-row>

              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.contact_n"
                      label="Contact No"
                      required
                      type="number"
                  ></v-text-field>
                  <v-text-field
                      v-model="payload.mobile"
                      label="Mobile"
                      required
                      type="number"
                  ></v-text-field>
                </v-col>
              </v-row>


              <h3>Address Information</h3>
              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.address_1"
                      label="Address 1"
                      required
                  ></v-text-field>

                  <v-text-field
                      v-model="payload.address_2"
                      label="Address 2"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.address_3"
                      label="Address 3"
                  ></v-text-field>

                  <v-text-field
                      v-model="payload.town"
                      :rules="nameRules"
                      label="Town"
                      required
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="6">
                  <v-text-field
                      v-model="payload.county"
                      :rules="nameRules"
                      label="County"
                      required
                  ></v-text-field>

                  <v-text-field
                      v-model="payload.post_code"
                      :rules="nameRules"
                      label="Post Code"
                      required
                  ></v-text-field>
                </v-col>
              </v-row>

              <h3>Lead Information</h3>
              <v-row justify="space-between">
                <v-col cols="12" sm="6">
                  <v-menu
                      v-model="menu"
                      :close-on-content-click="false"
                      min-width="auto"
                      offset-y
                      transition="scale-transition"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field
                          v-model="payload.date_to_be_contacted"
                          label="Date to be contacted"
                          prepend-icon="mdi-calendar"
                          readonly
                          v-bind="attrs"
                          v-on="on"
                      ></v-text-field>
                    </template>
                    <v-date-picker
                        v-model="payload.date_to_be_contacted"
                        @input="menu = false"
                    ></v-date-picker>
                  </v-menu>

                  <div class="products">
                    <h5>Products Interested in</h5>
                    <v-checkbox
                        v-model="payload.products.home_broadband"
                        label="Home Broadband"
                    ></v-checkbox>
                    <v-checkbox
                        v-model="payload.products.home_energy"
                        label="Home Energy"
                    ></v-checkbox>
                    <v-checkbox
                        v-model="payload.products.home_tv"
                        label="Home TV"
                    ></v-checkbox>
                  </div>

                </v-col>
                <v-col cols="12" sm="6">
                  <v-menu
                      ref="menu"
                      v-model="menuTime"
                      :close-on-content-click="false"
                      :return-value.sync="payload.time_to_be_contacted"
                      max-width="290px"
                      min-width="290px"
                      offset-y
                      transition="scale-transition"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field
                          v-model="payload.time_to_be_contacted"
                          label="Time to be contacted"
                          prepend-icon="mdi-clock-time-four-outline"
                          readonly
                          v-bind="attrs"
                          v-on="on"
                      ></v-text-field>
                    </template>
                    <v-time-picker
                        v-if="menuTime"
                        v-model="payload.time_to_be_contacted"
                        format="24hr"
                        full-width
                        @click:minute="$refs.menu.save(payload.time_to_be_contacted)"
                    ></v-time-picker>
                  </v-menu>
                </v-col>
              </v-row>

              <v-btn
                  :disabled="disabled"
                  class="mr-4"
                  @click="submit"
              >
                Submit Lead
              </v-btn>
            </v-form>
            <validation-errors v-if="validationErrors" :errors="validationErrors"></validation-errors>
            <v-snackbar
                v-model="snackbar"
                :color="snackbarType"
            >
              {{ success }}
            </v-snackbar>
          </div>
        </v-container>
      </div>
    </v-flex>
  </v-app>
</template>


<script>
import Vue from 'vue'
import axios from 'axios'

Vue.component('validation-errors', {
  data() {
    return {}
  },
  props: ['errors'],
  template: `
    <div v-if="validationErrors">
    <div class="alert alert-danger mt-5">
      <v-alert type="error" v-for="(value, key, index) in validationErrors">{{ value }}</v-alert>
    </div>

    </div>`,
  computed: {
    validationErrors() {
      let errors = Object.values(this.errors);
      errors = errors.flat();
      return errors;
    }
  }
});
export default {
  data: () => ({
    valid: false,
    disabled: false,
    payload: {
      group: null,
      advisor_name: '',
      agent_name: '',
      property_ref: '',
      title: '',
      first_name: '',
      last_name: '',
      address_1: '',
      address_2: '',
      address_3: '',
      town: '',
      county: '',
      post_code: '',
      contact_n: '',
      email: '',
      dont_contact_again: false,
      date_to_be_contacted: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
      time_to_be_contacted: "09:00",
      products: {
        home_broadband: null,
        home_energy: null,
        home_tv: null,
      },
      mobile: ''
    },
    snackbar: false,
    snackbarType: 'success',
    menu: false,
    menuTime: false,
    groups: [
      'Homelet',
      'Let Alliance',
      'Rent4Sure'
    ],
    titles: [
      'Mr',
      'Mrs',
      'Ms',
      'Miss'
    ],
    nameRules: [
      v => !!v || 'Field is required',
    ],
    emailRules: [
      v => !!v || 'E-mail is required',
      v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
    ],
    validationErrors: '',
    success: ''
  }),
  components: {},
  methods: {
    submit() {
      if (!this.$refs.form.validate()) {
        this.$nextTick(() => {
          const el = this.$el.querySelector(".v-messages.error--text:first-of-type");
          el && this.$vuetify.goTo(el);

        });
        return;
      }
      this.disabled = true;
      const url = process.env.VUE_APP_TELESALES_APP_URL ? process.env.VUE_APP_TELESALES_APP_URL : 'http://localhost:8085'
      axios.post(`${url}/api/external/leads-form`, this.payload)
          .then((response) => {
            if (response.data.success === true) {
              this.snackbarTrigger();
            }
            if (response.data.success === false) {
              this.snackbarTrigger('error')
            }
            this.resetValidation();
          })
          .catch((error) => {
            if (error.response && error.response.data) {
              this.validationErrors = error.response.data.errors;
            }
            this.snackbarTrigger('error');
            console.log(error);
          })
          .finally(() => this.disabled = false)

    },
    snackbarTrigger(type = 'success') {
      this.snackbarType = type
      this.snackbar = true;
      this.success = type === 'success' ? 'Lead has been created successfully' : 'Failed to created the lead!'
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },

  },
}
</script>
<style lang="scss">
@import "assets/app";
</style>
