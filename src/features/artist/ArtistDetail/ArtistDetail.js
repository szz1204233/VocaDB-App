import React from 'react'
import { View, Text } from 'react-native'
import images from '../../../common/assets/images'
import Icon from '../../../components/Icon/index'
import Theme from '../../../theme'
import TagGroup from '../../tag/TagGroup/index'
import WebLinkList from '../../webLink/WebLinkList/index'
import EventList from '../../releaseEvent/EventList/index'
import SongList from '../../song/SongList/index'
import ScrollableTabView from 'react-native-scrollable-tab-view'
import AlbumList from '../../album/AlbumList/index'
import Content from '../../../components/Content/index'
import Cover from '../../../components/Cover/index'
import Divider from '../../../components/Divider/index'
import SongHorizontalList from '../../song/SongHorizontalList'
import AlbumHorizontalList from '../../album/AlbumHorizontalList'

class ArtistDetailPage extends React.Component {

    componentDidMount () {
        const { params } = this.props.navigation.state;
        this.props.fetchArtist(params.id)
    }

    render () {
        const artist = this.props.artist
        const { params } = this.props.navigation.state;
        const imageUri = images.getArtistUri(params.id)
        const { latestSongs, popularSongs, latestAlbums, popularAlbums, latestEvents } = this.props;
        const hasAlbum = (latestAlbums && latestAlbums.length > 0) || (popularAlbums && popularAlbums.length > 0)
        const hasSong = (latestSongs && latestSongs.length > 0) || (popularSongs && popularSongs.length > 0)
        const hasEvent = (latestEvents && latestEvents.length > 0)

        if(!artist) {
            return (<View></View>)
        }

        const Section = props => (<View style={[{ marginVertical: 8, paddingHorizontal: 4 },props.style]}>{props.children}</View>)

        const renderTagGroup = () => (
            <Section>
                <Divider />
                <TagGroup tags={artist.tags} max={5} onPressTag={this.props.onPressTag} />
            </Section>
        )

        const renderDescription = () => (
            <Section>
                <Text style={Theme.body}>{artist.description}</Text>
            </Section>
        )

        const renderPopularSongs = () => (
                <SongHorizontalList title='Popular songs' songs={popularSongs} onPressItem={this.props.onPressSong} />
        )

        const renderPopularAlbums = () => (
                <AlbumHorizontalList title='Popular albums' albums={popularAlbums} onPressItem={this.props.onPressAlbum} />
        )

        const renderWebLink = () => (
            <Section>
                <Divider />
                <WebLinkList webLinks={artist.webLinks} category='Official' title='Official' />
                <WebLinkList webLinks={artist.webLinks} category='Commercial' title='Commercial' />
                <WebLinkList webLinks={artist.webLinks} category='Reference' title='Reference' />
            </Section>
        )

        const InfoPage = () => (
            <Content>
                <Cover
                    imageUri={imageUri}
                    title={artist.name}
                    subtitle={artist.artistType}
                />
                <Section style={{ flex: 1, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-around' }}>
                    {!this.props.followed && <Icon name='md-heart' text='Follow' onPress={() => this.props.onPressFollow(artist)} />}
                    {this.props.followed && <Icon name='md-heart' text='Followed' color={Theme.buttonActiveColor} onPress={() => this.props.onPressUnFollow(artist)} />}
                    <Icon name='md-share' text='Share' onPress={() => this.props.onPressShare(artist)} />
                </Section>
                {artist.tags != undefined && renderTagGroup()}
                {popularSongs && popularSongs.length > 0 && renderPopularSongs()}
                {popularAlbums && popularAlbums.length > 0 && renderPopularAlbums()}
                {artist.description != undefined && renderDescription()}
                {artist.webLinks != undefined && renderWebLink()}
            </Content>
        )

        const SongListPage = () => {

            const renderLatestSongs = () => (
                <SongList max={7}
                          songs={latestSongs}
                          title='Latest'
                          showHeader={false}
                          onPressItem={this.props.onPressSong}
                          onPressMore={() => this.props.onPressMoreLatestSongs(artist)} />
            )

            return (<Content>
                {latestSongs && latestSongs.length > 0 && renderLatestSongs()}
            </Content>)
        }

        const AlbumListPage = () => {

            const renderLatestAlbum = () => (
                <AlbumList max={7} albums={latestAlbums} title='Latest' showHeader={false} onPressItem={this.props.onPressAlbum} />
            )

            return (
                <Content>
                    {latestAlbums && latestAlbums.length > 0 && renderLatestAlbum()}
                </Content>
            )
        }



        const EventListPage = () => (
            <Content>
                <EventList events={latestEvents} />
            </Content>
        )

        return (
            <ScrollableTabView>
                <InfoPage tabLabel='Info' />
                <SongListPage tabLabel='Songs' />
                {hasAlbum && <AlbumListPage tabLabel='Albums' />}
                {hasEvent && <EventListPage tabLabel='Events' />}
            </ScrollableTabView>
        )
    }
}

export default ArtistDetailPage