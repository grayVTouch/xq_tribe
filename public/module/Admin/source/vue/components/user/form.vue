<template>
    <section class="verify-form">
        <div class="background">
            <img src="./images/back.jpg" class="image">
        </div>
        <div class="content">
            <h1 class="header">
                <slot name="title"></slot>
            </h1>

            <slot name="form"></slot>
        </div>
    </section>
</template>

<script>
    export default {
        name: "v-form"
    }
</script>

<style src="./css/g_form.css"></style>
<style scoped src="./css/form.css"></style>