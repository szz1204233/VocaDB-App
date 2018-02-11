import React from 'react';

import { storiesOf } from '@storybook/react-native';
import { action } from '@storybook/addon-actions';
import { ScrollView } from 'react-native'

import SongList from './index'
import mockSongs from './mock'

storiesOf('SongList', module)
    .addDecorator(getStory => <ScrollView>{getStory()}</ScrollView>)
    .add('with items', () => (
        <SongList
            songs={mockSongs.items}
            onPressItem={action('press song')}
        />
    ))
    .add('with max 3', () => (
        <SongList
            songs={mockSongs.items}
            max={3}
            onPressItem={action('press song')}
        />
    ))
    .add('with header', () => (
        <SongList
            songs={mockSongs.items}
            title='Recent songs'
            showHeader={true}
            onPressItem={action('press song')}
            onPressMore={action('press more')}
        />
    ));