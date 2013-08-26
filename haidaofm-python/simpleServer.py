__author__ = 'bruceyang'
# -*- coding: utf-8 -*-

from bottle import route, run, static_file, request, response
import json
from time import time


#host_ip = '192.168.1.100'
host_ip = '127.0.0.1'

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
    data = [{'url': 'http://www.baidu.com/img/baidu_sylogo1.gif'}] * 20
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
                               {'uuid': 123
                               , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                               , 'title': u'一个女人五百只鸭子'
                               , 'author': u'狗血'
                               , 'commentCnt': 120
                               , 'favorateCnt': 300}] * 10

    }

    import time
    time.sleep(1)

    response.content_type = "application/json"
    return json.dumps(data)


@route('/api/program/list.json', method='get')
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
                {'url': 'http://www.baidu.com/img/baidu_sylogo1.gif'},

        'title': u'一个女人五百只鸭子'
        , 'programList': [
                {
                'uuid': 1234213
                , 'title': u'金大班的最后一夜'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'description': u'1111111111111不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://zhangmenshiting.baidu.com/data2/music/226905/22689375600.mp3?xcode=7793e373c4d3b476c45549e4ad875038'
            }
            , {
                'uuid': 1233213
                , 'title': u'金大班的最后一夜'
                , 'description': u'2222222222222不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://tingge.5nd.com/20060919//2010/2010b/2012-9-14/56581/1.Mp3'
            }, {
                'uuid': 1236213
                , 'title': u'金大班的最后一夜'
                , 'description': u'33333333333不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。不要让青少年有判断力。只要给他们汽车摩托车明星、刺圌激的音乐、流行的服饰、以及竞争意识就行了。剥夺青少年的思考力，根植他们服从指导者命令的服从心。让他们对批判国家、社会和领袖抱着一种憎恶。让他们深信那是少数派和异端者的罪恶。让他们认为想法和大家不同的就是公敌。'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://tingge.5nd.com/20060919//2010/2010b/2012-9-14/56581/1.Mp3'
            }

        ]
    }

    import time
    time.sleep(1)
    # RETURN JSON
    response.content_type = "application/json"
    return json.dumps(data)

@route('/api/channel/fav', method='get')
def g_my_fav():
    data = {
        'channelList': [
                               {'uuid': 123
                               , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
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
        'cover':'http://www.baidu.com/img/baidu_sylogo1.gif',
        'title': u'一个女人五百只鸭子'
        , 'programList': [
                {
                'uuid': 1232143
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://zhangmenshiting2.baidu.com/data2/music/9073342/9073342.mp3?xcode=a674fc36709828f9273650a58d1b4b7f&mid=0.88143046809309'
            }
            , {
                'uuid': 123213
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://tingge.5nd.com/20060919//2010/2010b/2012-9-14/56581/1.Mp3'
            }, {
                'uuid': 123613
                , 'title': u'金大班的最后一夜'
                , 'description': u'Windows 8是微软最新一代操作系统，并有可能成为微软有史以来对该操作系统做出的最大调整。从上周日起，Windows 8电视广告开始投放。在最新的广告中“8”这个数字被反复播放着，结尾打出“Windows重新想象”的标语'
                , 'coverPic': 'http://www.baidu.com/img/baidu_sylogo1.gif'
                , 'author': u'几乎'
                , 'favorateCnt': 120
                , 'commentCnt': 300
                , 'fileUrl': 'http://tingge.5nd.com/20060919//2010/2010b/2012-9-14/56581/1.Mp3'
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

run(host=host_ip, port=8888)


