import React from 'react'
import { Image, View, Text, TouchableOpacity, StyleSheet } from 'react-native'
import PropTypes from 'prop-types';
import images from './../../assets/images'

class Event extends React.Component {
    render () {
        return (
            <TouchableOpacity onPress={this.props.onPress}>
                <View style={styles.listItem}>
                    <View style={styles.infoContainer}>
                        <Text style={styles.title}>{this.props.name}</Text>
                        <Text note numberOfLines={1}>{this.props.artist}</Text>
                    </View>
                </View>
            </TouchableOpacity>
        )
    }
}

Event.propTypes = {
    name: PropTypes.string
};

Event.defaultProps = {
};

const styles =  StyleSheet.create({
    listItem: {
        flexDirection: 'row',
        backgroundColor: 'white',
        padding: 4,
        height: 100
    },
    imageContainer: {
        padding: 4,
        // backgroundColor: '#546E7A',
        width: 100
    },
    infoContainer: {
        flex: 1,
        padding: 4
    },
    image: {
        flex: 1
    },
    title: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 4
    },
    subtitle: {

    }
})


export default Event;