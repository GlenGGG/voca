from voca_site.models import Pspage, Univs, Position, UserMessages, Depart, Orgniza, PspageUserVisit, User, UserUnivsGra, UserUnivsAttend, UserMessages, PspageUserVisit
import random
import datetime


class MyTest():

    def generate_test_cases(self):
        userset = User.objects.all()
        usercnt = userset.count()
        pspageset = Pspage.objects.all()
        pspagecnt = pspageset.count()
        departset = Depart.objects.all()
        departcnt = departset.count()
        orgnizaset = Orgniza.objects.all()
        orgnizacnt = orgnizaset.count()
        positionset = Position.objects.all()
        positioncnt = positionset.count()
        univsset = Univs.objects.all()
        univscnt = univsset.count()

        useremail = "test@test.test"
        userpassword = "123123"
        username = "test"

        for i in range(50):
            email = useremail + str(i + 1)
            name = username + str(i + 1)
            de = departset[random.randint(0, departcnt - 1)]
            org = orgnizaset[random.randint(0, orgnizacnt - 1)]
            pos = positionset[random.randint(0, positioncnt - 1)]
            ua = univsset[random.randint(0, univscnt - 1)]
            ug = univsset[random.randint(0, univscnt - 1)]
            gender = random.randint(0, 1) + 1
            usernew = User(email=email, name=name, depart=de,
                           orgniza=org, position=pos, gender=gender)
            usernew.set_password(userpassword)
            usernew.save()

            ua = UserUnivsAttend(user=usernew, univs=ua)
            ug = UserUnivsGra(user=usernew, univs=ug)
            ua.save()
            ug.save()

        print("done")

    def generate_friend(self):
        userset = User.objects.all()
        usercnt = userset.count()
        pspageset = Pspage.objects.all()
        pspagecnt = pspageset.count()
        departset = Depart.objects.all()
        departcnt = departset.count()
        orgnizaset = Orgniza.objects.all()
        orgnizacnt = orgnizaset.count()
        positionset = Position.objects.all()
        positioncnt = positionset.count()
        univsset = Univs.objects.all()
        univscnt = univsset.count()

        for i in range(10, usercnt):
            user = userset[i]
            for i in range(10):
                friend = userset[random.randint(10, usercnt - 1)]
                if friend not in user.friend.all() and friend != user:
                    user.friend.add(friend)
                    user.save()
        print("friend add done")

    def generate_message(self):
        userset = User.objects.all()
        usercnt = userset.count()
        pspageset = Pspage.objects.all()
        pspagecnt = pspageset.count()
        departset = Depart.objects.all()
        departcnt = departset.count()
        orgnizaset = Orgniza.objects.all()
        orgnizacnt = orgnizaset.count()
        positionset = Position.objects.all()
        positioncnt = positionset.count()
        univsset = Univs.objects.all()
        univscnt = univsset.count()

        message = "This is a Test "

        for i in range(10, usercnt):
            user = userset[i]
            cnt = 0
            for i in range(10):
                userto = userset[random.randint(10, usercnt - 1)]
                if userto != user:
                    cnt += 1
                    me = message + str(cnt)
                    mess = UserMessages(message_sender=user,
                                        message_receiver=userto, message=me, message_read=random.randint(0, 1))
                    mess.save()
        print("message add done")

    def generate_visit(self):
        userset = User.objects.all()
        usercnt = userset.count()
        pspageset = Pspage.objects.all()
        pspagecnt = pspageset.count()
        departset = Depart.objects.all()
        departcnt = departset.count()
        orgnizaset = Orgniza.objects.all()
        orgnizacnt = orgnizaset.count()
        positionset = Position.objects.all()
        positioncnt = positionset.count()
        univsset = Univs.objects.all()
        univscnt = univsset.count()

        message = "This is a Test "

        for i in range(10, usercnt):
            user = userset[i]
            for j in range(10):
                userfrom = userset[random.randint(10, usercnt - 1)]
                if userfrom != user:
                    pspageto = user.my_pspage
                    vi = PspageUserVisit(pspage=pspageto, user=userfrom)
                    vi.save()
                    pspageto.visitor_cnt += 1
                    pspageto.save()

        print("visit add done")

    def all_generate(self):
        self.generate_test_cases()
        self.generate_friend()
        self.generate_message()
        self.generate_visit()
