import React from 'react';
import {Button, Card} from 'galio-framework';
import bg from '../assets/bg16.png';
import {StyleSheet, ImageBackground, View, Text} from "react-native";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: "column"
    },
    image: {
        flex: 1,
        resizeMode: "cover",
        justifyContent: "center",
        width: "100%",
        height: "100%",
    },
    text: {
        color: "white",
        fontSize: 42,
        fontWeight: "bold",
        // textAlign: "center",
        backgroundColor: "#000000a0"
    }
});

const LoginPage = () => {
    return (
        <View styles={styles.container}>
            <ImageBackground source={bg} style={styles.image}>
                {/*<Text style={styles.text}>Inside</Text>*/}
            </ImageBackground>
        </View>
        // <Card
        //     flex
        //     borderless
        //     title="Christopher Moon"
        //     caption="139 minutes ago"
        //     location="Los Angeles, CA"
        //     avatar="http://i.pravatar.cc/100?id=skater"
        //     image="https://images.unsplash.com/photo-1497802176320-541c8e8de98d?&w=1600&h=900&fit=crop&crop=entropy&q=300"
        // />
    );
}

export default LoginPage;