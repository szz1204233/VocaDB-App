import api from '../../common/api'

const songApi = {
    find: params => api.songs.find({ ...params, 'preferAccurateMatches': true }),
    highlighted: () => api.songs.highlighted({ 'fields': 'thumbUrl,PVs' }),
    getRecentSongs: () => api.songs.find({ 'sort': 'AdditionDate', 'fields': 'thumbUrl' }),
    getPopularSongs: () => api.songs.find({ 'sort': 'AdditionDate', 'fields': 'thumbUrl' }),
    getFollowedSongs: artistIds => api.songs.find({ 'sort': 'AdditionDate', 'fields': 'thumbUrl' , 'artistId': artistIds }),
    getPopularSongsByTag: tagId => api.songs.find({ 'maxResults': 20, 'fields': 'thumbUrl' , tagId }),
    getSong: id => api.songs.get(id, { 'fields': ['ThumbUrl', 'Albums', 'Artists', 'Tags', 'WebLinks', 'PVs', 'Lyrics'].join(',') }),
    getTopRated: params => api.songs.topRated({ ...params, 'fields': 'MainPicture,PVs,ThumbUrl'})
}

export default songApi