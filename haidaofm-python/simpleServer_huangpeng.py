__author__ = 'bruceyang'
# -*- coding: utf-8 -*-

from bottle import route, run, static_file, request, response
import json
from settings import host_ip
from time import time

@route('/:name')

def index(name='World'):
    return '<b>Hello %s !!</b>' % name

@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='./files')

@route('/some/example', method='get')
def g_exapmle():
    name = request.forms.get('name', '')
    value = request.forms.get('value', '')
    return name + 'xxxx' + value;

@route('/some/post-example', method='post')
def p_example():
    name = request.forms.get('name', '')
    value = request.forms.get('value', '')
    print 'post: '  + name + '...' + value
    return 'post: '  + name + '...' + value

@route('/some/auto-complete', method='get')
def g_auto():
    # data
    data = [
            {'image':'', 'name': 1},
            {'image':'', 'name': 2},
            {'image':'', 'name': 3},
            {'image':'', 'name': 4}
    ]

    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/covers.json', method='get')
def g_cover():
    data = [{'url': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'}] * 20
    print  data
    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/channel/list.json', method='get')
def g_public_fm_list():
    np = request.query.get('np')
    ps = request.query.get('ps')
    print np
    print ps

    data = {
        'channelList': [
                {'uuid': "1"
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'title': u'一个女人五百只鸭子'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'author': u'狗血'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
		, 'latestProgram': {
                	'uuid': 1234213
                	, 'title': u'金大班的最后一夜'
                	, 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                	, 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                	, 'author': u'几乎'
                	, 'favorateCnt': 120
                	, 'commentCnt': 300
                	, 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
		   }
                },
                {'uuid': "2"
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'title': u'一个女人五百只鸭子'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'author': u'狗血'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
		, 'latestProgram': {
                	'uuid': 1234213
                	, 'title': u'金大班的最后一夜'
                	, 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                	, 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                	, 'author': u'几乎'
                	, 'favorateCnt': 120
                	, 'commentCnt': 300
                	, 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
		   }
                },
                {'uuid': "3"
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'title': u'一个女人五百只鸭子'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'author': u'狗血'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
		, 'latestProgram': {
                	'uuid': 1234213
                	, 'title': u'金大班的最后一夜'
                	, 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                	, 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                	, 'author': u'几乎'
                	, 'favorateCnt': 120
                	, 'commentCnt': 300
                	, 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
		   }
                }]

    }

    import time
    time.sleep(1)

    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/channel/detail.json', method='get')
def g_fm_detail():
    fm_id = request.query.get('puuid')
    np = request.query.get('np')
    ps = request.query.get('ps')
    print fm_id
    print np
    print ps
    # data
    data = {
        'covers':
                {'url': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'}

        ,  'title': u'一个女人五百只鸭子'
        , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
        , 'programList': [
                {
                'uuid': 1234213
                , 'title': u'金大班的最后一夜'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
            }
            , {
                'uuid': 1233213
                , 'title': u'金大班的最后一夜'
                , 'description': u'2222222222222不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/2.mp3'
            }, {
                'uuid': 1236213
                , 'title': u'金大班的最后一夜'
                , 'description': u'33333333333不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/3.mp3'
            }

        ]
    }

    import time
    time.sleep(1)
    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/program/list.json', method='get')
def g_program_list():
    data = {
        'programPageList': {
            'programList': [
                    {
                    'uuid': 1234213
                    , 'title': u'金大班的最后一夜'
                    , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                    , 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                    , 'author': u'几乎'
                    , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                    , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                    , 'favorateCnt': 120
                    , 'commentCnt': 300
                    , 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
                }
                , {
                    'uuid': 1233213
                    , 'title': u'金大班的最后一夜'
                    , 'description': u'2222222222222不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                    , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                    , 'author': u'几乎'
                    , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                    , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                    , 'favorateCnt': 120
                    , 'commentCnt': 300
                    , 'fileUrl': 'http://' + host_ip + ':5000/2.mp3'
                }, {
                    'uuid': 1236213
                    , 'title': u'金大班的最后一夜'
                    , 'description': u'33333333333不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                    , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                    , 'author': u'几乎'
                    , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                    , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                    , 'favorateCnt': 120
                    , 'commentCnt': 300
                    , 'fileUrl': 'http://' + host_ip + ':5000/3.mp3'
                }
            ]
        }
    }

    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/channel/fav', method='get')
def g_my_fav():
    data = {
        'channelList': [
                               {'uuid': 123
                               , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                               , 'title': u'一个女人五百只鸭子'
                               , 'author': u'狗血'
                               , 'commentCnt': 120
                               , 'favorateCnt': 300}] * 10

    }
    import time
    time.sleep(1)
    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/channel/my')
def g_my_channel():
    np = request.query.get('np')
    ps = request.query.get('ps')
    print np
    print ps
    # data
    data = {
        'cover':'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg',
        'title': u'一个女人五百只鸭子'
        , 'programList': [
                {
                'uuid': 1232143
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/1.mp3'
            }
            , {
                'uuid': 123213
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/2.mp3'
            }, {
                'uuid': 123613
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/3.mp3'
            }

        ]
    }

    import time
    time.sleep(1)
    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/program/comments.json', method='get')
def g_topic_comments():
    topic_id = request.forms.get('topic_id', '')
    print topic_id
    data = [
                   {
                   'user': u'我是你爸爸'
                   , 'content': u'【逆向思维】割草打工的男孩'
               }] * 20

    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/program/comment.json', method='post')
def p_topic_comment():
    # RETURN JSON
    topic_id = request.forms.get('topic_id', '')
    comment = request.forms.get('comment', '')
    print topic_id
    print comment
    data = {'status': 'succ'}
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/subject/list.json', method='get')
def g_topic_program_list():
    data = [{
                'uuid': 1234213
                , 'title': u'金大班的最后一夜'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/5.mp3'
            }
            , {
                'uuid': 1233213
                , 'title': u'金大班的最后一夜'
                , 'description': u'2222222222222不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/2.mp3'
            }, {
                'uuid': 1236213
                , 'title': u'金大班的最后一夜'
                , 'description': u'33333333333不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'headerPic': 'http://img03.taobaocdn.com/tps/i3/T1eIqpXjBLXXXXXXXX-63-63.png'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/3.mp3'
            }];
    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/recommend.json', method='get')
def g_rec_list():
    data = [
        {
            'program': {
                'uuid': 1232143
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'author': u'几乎'
                , 'profile': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://' + host_ip + ':5000/1.mp3'
            }
        }
        , {
            'subject':{
                'title': u'jajajajaja'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
            }
        }
        ,{
            'subject':{
                'title': u'jajajajaja'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
            }
        },{
            'subject':{
                'title': u'jajajajaja'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
            }
        },{
            'subject':{
                'title': u'jajajajaja'
                , 'coverPic': 'http://ww3.sinaimg.cn/bmiddle/449f2634jw1dy8vyp04ifj.jpg'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
            }
        }
    ]
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/feedback', method='post')
def p_feedback():
    input = request.forms.get('input', '')
    print input
    return ''

run(host=host_ip, port=8888)


