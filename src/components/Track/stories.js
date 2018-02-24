import React from 'react';

import { storiesOf } from '@storybook/react-native';
import { action } from '@storybook/addon-actions';
import { View } from 'react-native'

import Track from './index'
import CenterView from './../CenterView'

storiesOf('Track', module)
    .addDecorator(getStory => <CenterView type='vertical'>{getStory()}</CenterView>)
    .add('with track', () => (
        <Track
            name='レメスタンス'
            artist='AVTechNO! feat. 初音ミク'
        />
    ));