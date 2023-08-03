Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73474EB64DD
	for <rcu@archiver.kernel.org>; Thu,  3 Aug 2023 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHCNvF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjHCNut (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Aug 2023 09:50:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49836E75;
        Thu,  3 Aug 2023 06:50:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba48b0bd2so6706575ad.3;
        Thu, 03 Aug 2023 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691070648; x=1691675448;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icgZFTNA7+ou9gRUoHpJnkgJTOtg/9uMYpq1FuS6Hrk=;
        b=rcNXuAzWpfJixSWOjgE+3QOshhFqdh2ClZ3smqMU2ZRSZZMuI9ARIQqNSiQDHGLU/1
         Uy1sFfx9pe7URCc8RFi2gYtKImDtnqPzPkndJ4/QAKUWfXcmBxaFls9msWMFJEGEj+Rt
         36TTgJg6yd8rGbiHJBQ6to7JVEJ43gmji3IhWF/yYo+4WFu5Z6qZutyaAZS/HCcZgtGW
         Qc495zRsQmM8il6hSz/jYL1lCvVoU327mcvXBq4CV+S0M8tcG+h1HS5aPuOGoJnFRNSl
         70MdwHSnV8dhCKs2rNlDZnU6yzUXGCJPHBa9tAJUGnAGLHh9CnBFw6RKrk75c52F8UNg
         X/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070648; x=1691675448;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icgZFTNA7+ou9gRUoHpJnkgJTOtg/9uMYpq1FuS6Hrk=;
        b=CBzM0bZUhIQSyN0N0ISoPMGcgPfkxLTyf2S/Gd34GtxOJcN/DoVg+0vO49S7EvtmhQ
         Q3Nncg2MPIMgKOpaBsC8qBgBKKVQxjc6bhyTKLFe/DfRSc+ApEGFo7/dag+jHDCu9iXL
         /n6dCOr8cLilN+4k9wbQznJgOpqVcdPkPSzIIAMcEjXf8evo9FQZUk/rk9QEe0lSTr62
         tTsRR+qAgMtJy3zmwMBwNHLatSkRTTy0+zPi09HVxipGdNsX0g9vEQFOWx4Fhd8+c0Dc
         gC5BPQQCKC7Fs5wqoDWoo7PB1Z6R4gYkQG00rY4g8MYA5NJFKzmya/I3RLZUWXj8JpAJ
         PIbw==
X-Gm-Message-State: ABy/qLZG9bv2SadCcXyBfTuB8ATYjpOcol6hWrt4UOKa9zRTbMaaNArt
        TZZfBxUcfB2VVEdX1JVpCAE=
X-Google-Smtp-Source: APBJJlGbC9O+LHzdWtcEhmztKut23zTBSQCYNTrrbcp3B5v/CO+riby7WyuFtHJO6rIlVJAxx4/TKA==
X-Received: by 2002:a17:902:e5ce:b0:1bb:fffd:63d8 with SMTP id u14-20020a170902e5ce00b001bbfffd63d8mr16241082plf.36.1691070647581;
        Thu, 03 Aug 2023 06:50:47 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001b7fd27144dsm14478772plh.40.2023.08.03.06.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:50:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <901e9495-74f3-4837-94ad-396f5b6899fc@paulmck-laptop>
Date:   Thu, 3 Aug 2023 21:50:35 +0800
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <62EB7DEA-EA2E-4F42-9766-BB3E0BA145EE@gmail.com>
References: <eabec10a-9283-42eb-85c7-e447e2368c91@paulmck-laptop>
 <6E813D30-2791-4DE8-A70C-E1F91011631D@gmail.com>
 <02a84e4b-a322-4c43-ad9d-1832ce277c2f@paulmck-laptop>
 <636D1ED4-C90D-47CA-A46A-28E40E777966@gmail.com>
 <9b1967c5-6b8d-4d66-879c-42818d6e3170@paulmck-laptop>
 <30E3504D-4E64-4C61-9503-690C1657C6F3@gmail.com>
 <8d54c0a5-11ab-48e2-b187-25b229406b2a@paulmck-laptop>
 <99F1D0AB-5085-42CA-BFF0-6D5AC488F960@gmail.com>
 <2c7ebfde-40e7-442c-9483-4a3ca3b72f2d@paulmck-laptop>
 <BB359D4F-67B1-459F-A3E5-18BCD39D022B@gmail.com>
 <901e9495-74f3-4837-94ad-396f5b6899fc@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B48=E6=9C=881=E6=97=A5 =E4=B8=8A=E5=8D=884:06=EF=BC=8CPaul =
E. McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jul 29, 2023 at 11:17:31PM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 00:09=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Sat, Jul 22, 2023 at 09:02:46AM +0800, Alan Huang wrote:
>>>>=20
>>>>> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8A=E5=8D=886:49=EF=BC=8CPa=
ul E. McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> On Wed, Jul 19, 2023 at 12:08:33AM +0800, Alan Huang wrote:
>>>>>>=20
>>>>>>> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 03:06=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>=20
>>>>>>> On Tue, Jul 18, 2023 at 01:53:10AM +0800, Alan Huang wrote:
>>>>>>>>> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 00:02=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>>> On Sun, Jul 16, 2023 at 07:21:28PM +0800, Alan Huang wrote:
>>>>>>>>>>> 2023=E5=B9=B47=E6=9C=8816=E6=97=A5 01:19=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>>>>> On Sat, Jul 15, 2023 at 08:50:23AM +0800, Alan Huang wrote:
>>>>>>>>>>>>> 2023=E5=B9=B47=E6=9C=8815=E6=97=A5 07:23=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>>>>>>> On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang =
wrote:
>>>>>>>>>>>>>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and =
there is
>>>>>>>>>>>>>> n->next =3D first within hlist_add_head_rcu() before =
rcu_assign_pointer(),
>>>>>>>>>>>>>> which modifies obj->obj_node.next. There may be readers =
holding the
>>>>>>>>>>>>>> reference of obj in lockless_lookup, and when updater =
modifies ->next,
>>>>>>>>>>>>>> readers can see the change immediately because =
ofSLAB_TYPESAFE_BY_RCU.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> There are two memory ordering required in the insertion =
algorithm,
>>>>>>>>>>>>>> we need to make sure obj->key is updated before =
obj->obj_node.next
>>>>>>>>>>>>>> and obj->refcnt, atomic_set_release is not enough to =
provide the
>>>>>>>>>>>>>> required memory barrier.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> This is an interesting one!!!
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Now I am having a hard time believing that the smp_rmb() =
suffices.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> Changelog:
>>>>>>>>>>>>>> v1 -> v2: Use _ONCE to protect obj->key.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Documentation/RCU/rculist_nulls.rst | 21 =
+++++++++++++--------
>>>>>>>>>>>>>> 1 file changed, 13 insertions(+), 8 deletions(-)
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>>>>>> index 21e40fcc08de..2a9f5a63d334 100644
>>>>>>>>>>>>>> --- a/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>>>>>> +++ b/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>>>>>> @@ -47,7 +47,7 @@ objects, which is having below type.
>>>>>>>>>>>>>> * reuse these object before the RCU grace period, we
>>>>>>>>>>>>>> * must check key after getting the reference on object
>>>>>>>>>>>>>> */
>>>>>>>>>>>>>> -    if (obj->key !=3D key) { // not the object we =
expected
>>>>>>>>>>>>>> +    if (READ_ONCE(obj->key) !=3D key) { // not the =
object we expected
>>>>>>>>>>>>>> put_ref(obj);
>>>>>>>>>>>>>> rcu_read_unlock();
>>>>>>>>>>>>>> goto begin;
>>>>>>>>>>>>>> @@ -64,10 +64,10 @@ but a version with an additional =
memory barrier (smp_rmb())
>>>>>>>>>>>>>> {
>>>>>>>>>>>>>> struct hlist_node *node, *next;
>>>>>>>>>>>>>> for (pos =3D rcu_dereference((head)->first);
>>>>>>>>>>>>>> -         pos && ({ next =3D pos->next; smp_rmb(); =
prefetch(next); 1; }) &&
>>>>>>>>>>>>>> +         pos && ({ next =3D READ_ONCE(pos->next); =
smp_rmb(); prefetch(next); 1; }) &&
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Suppose that lockless_lookup() is delayed just before =
fetching pos->next,
>>>>>>>>>>>>> and that there were 17 more node to search in the list.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Then consider the following sequence of events:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> o The updater deletes this same node and =
kmem_cache_free()s it.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> o Another updater kmem_cache_alloc()s that same memory and
>>>>>>>>>>>>> inserts it into an empty hash chain with a different key.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> o Then lockless_lookup() fetches pos->next and sees a NULL =
pointer,
>>>>>>>>>>>>> thus failing to search the remaining 17 nodes in the list,
>>>>>>>>>>>>> one of which had the desired key value.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> o The lookup algorithm resumes and sees the NULL return =
from
>>>>>>>>>>>>> lockless_lookup(), and ends up with a NULL obj.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> And this happens even with the strongest possible ordering
>>>>>>>>>>>>> everywhere.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> OK, yes, it is late on Friday.  So what am I missing here?
>>>>>>>>>>>>=20
>>>>>>>>>>>> You missed nothing!
>>>>>>>>>>>>=20
>>>>>>>>>>>> The lockless_lockup should not be a function, but a macro =
like hlist_for_each_entry_rcu.
>>>>>>>>>>>=20
>>>>>>>>>>> How would you fix this using a macro?
>>>>>>>>>>=20
>>>>>>>>>> With additional detection code. A moved object (in another =
chain) will have a different slot.
>>>>>>>>>> (I have sent patch v3. )
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>>> Independent of that, does hlist_add_head_rcu() need to =
replace its
>>>>>>>>>>>>> "n->next =3D first" with "WRITE_ONCE(n->next, first)"?
>>>>>>>>>>>>=20
>>>>>>>>>>>> I think users who want to use hlist with =
SLAB_TYPESAFE_BY_RCU should use rculist_nulls?
>>>>>>>>>>>=20
>>>>>>>>>>> I believe that you are correct.  Would you like to propose a =
patch, or
>>>>>>>>>>> would you rather I put something together?  My current =
thought is to
>>>>>>>>>>=20
>>>>>>>>>> Feel free to add.=20
>>>>>>>>>>=20
>>>>>>>>>> One thing I think would be useful is to tell readers where =
the =E2=80=98next' is.=20
>>>>>>>>>> The document mentions =E2=80=99next=E2=80=99 many times, but =
it=E2=80=99s hard for me, as a reader, to realize that
>>>>>>>>>> the =E2=80=98next' is within hlist_add_head_rcu(). (I have no =
idea where to put the hint.)
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> keep the examples, but to show why the one with smp_rmb() is =
broken.
>>>>>>>>>>=20
>>>>>>>>>> I think the example needs to be fixed. :)
>>>>>>>>>=20
>>>>>>>>> Even better!  I will take a look, but in the meantime, would =
you be
>>>>>>>>> interested in updating the wording to explain how the =
back-pointer works?
>>>>>>>>=20
>>>>>>>> Which document needs to be updated?=20
>>>>>>>> And is there anything that I can refer to? It=E2=80=99s the =
first time I have ever heard about it.
>>>>>>>=20
>>>>>>> Documentation/RCU/rculist_nulls.rst, the one that you are =
updating.
>>>>>>>=20
>>>>>>> There admittedly isn't a whole lot of commentary.
>>>>>>>=20
>>>>>>>>> (Looks similar to the is_a_nulls() pointer, but in each =
element instead of
>>>>>>>>> just at the end.  One advantage is the ability to detect a =
move mid-list,
>>>>>>>>> though that is not a big deal in well-tuned hash tables, which =
tend to
>>>>>>>>> have short hash chains.  The need to move elements to the =
front of the
>>>>>>>>> destination list remains, though in both cases only if it has =
been less
>>>>>>>>> than a grace period since the last move.)
>>>>>>>>=20
>>>>>>>> Looks like that I need to learn it first. :)
>>>>>>>=20
>>>>>>> Well, you wrote the code, so...  ;-)
>>>>>>=20
>>>>>> If I understand correctly, it works only for 64-bit machines?
>>>>>>=20
>>>>>> And the number of slots of the hash table will be limited?
>>>>>=20
>>>>> You are asking about the is_a_nulls() value?  If so, it works on =
both
>>>>> 32-bit and 64-bit machines.  They each have enough bits for the =
nulls
>>>>> value to cover all possible two-byte objects in the full address =
space.
>>>>>=20
>>>>> If that wasn't what you were asking, please help me with your =
question.
>>>>=20
>>>> I=E2=80=99m asking the =E2=80=98back-pointer=E2=80=99, which
>>>>=20
>>>> "Looks similar to the is_a_nulls() pointer, but in each element =
instead of
>>>> just at the end=E2=80=9D
>>>>=20
>>>> If I understand correctly, we need to store the nulls in the upper =
unused bits.
>>>>=20
>>>> And we only have several bits unused. One advantage I can think of =
is that it=20
>>>> will improve the performance once we have something like the Intel =
Upper Address Ignore (UAI),
>>>> which also works only for 64-bit machine.
>>>=20
>>> Ah, I was using the word "similar" very loosely.  Not "implemented =
in
>>> a manner similar to is_a_nulls(), but rather "serves roughly the =
same
>>> function as is_a_nulls()".
>>=20
>> I got it.
>>=20
>>>=20
>>> You should be able to just have the pointer to the bucket in each
>>> element, and just compare for each element.  No need for extra bits,
>>=20
>> It might have the same functionality if we put the nulls value in =
each element.
>=20
> There are some strange things that are easier to do with a nulls value
> than with an explicit pointer, but yes.
>=20
> (For example, if for some odd reason you wanted to group the hash =
buckets
> into classes within which moving a reader to another bucket was OK.
> Why would you want to do this?  I have no idea!)

Interesting example.

I=E2=80=99ll try to update the wording to explain how the back-pointer =
works.

By the way, would you like a separate patch or a patch V4 containing the =
content of
V3 of "docs/RCU: Bring back smp_wmb()=E2=80=9D and the back-pointer?

>=20
> 							Thanx, Paul
>=20
>>> though UAI, like its pre-existing ARM counterpart, might also help =
catch
>>> use-after-free bugs when resizing the hash table.
>>>=20
>>> Thanx, Paul
>>>=20
>>>>>>>>>>>> I didn=E2=80=99t find a case using hlist with =
SLAB_TYPESAFE_BY_RCU, but I did find a case using list
>>>>>>>>>>>> with SLAB_TYPESAFE_BY_RCU in drivers/gpu/drm/i915, the =
driver also doesn=E2=80=99t use _ONCE
>>>>>>>>>>>> on the fields of the objects allocated with =
SLAB_TYPESAFE_BY_RCU.
>>>>>>>>>>>=20
>>>>>>>>>>> Feel free to send them a patch, though I cannot speak for =
their
>>>>>>>>>>> reception of it.
>>>>>>>>>>>=20
>>>>>>>>>>> Thanx, Paul
>>>>>>>>>>>=20
>>>>>>>>>>>>> Thanx, Paul
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>    ({ obj =3D hlist_entry(pos, typeof(*obj), obj_node); =
1; });
>>>>>>>>>>>>>>    pos =3D rcu_dereference(next))
>>>>>>>>>>>>>> -      if (obj->key =3D=3D key)
>>>>>>>>>>>>>> +      if (READ_ONCE(obj->key) =3D=3D key)
>>>>>>>>>>>>>>   return obj;
>>>>>>>>>>>>>> return NULL;
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>> @@ -111,8 +111,13 @@ detect the fact that it missed =
following items in original chain.
>>>>>>>>>>>>>> */
>>>>>>>>>>>>>> obj =3D kmem_cache_alloc(...);
>>>>>>>>>>>>>> lock_chain(); // typically a spin_lock()
>>>>>>>>>>>>>> -  obj->key =3D key;
>>>>>>>>>>>>>> -  atomic_set_release(&obj->refcnt, 1); // key before =
refcnt
>>>>>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
>>>>>>>>>>>>>> +  /*
>>>>>>>>>>>>>> +   * We need to make sure obj->key is updated before =
obj->obj_node.next
>>>>>>>>>>>>>> +   * and obj->refcnt.
>>>>>>>>>>>>>> +   */
>>>>>>>>>>>>>> +  smp_wmb();
>>>>>>>>>>>>>> +  atomic_set(&obj->refcnt, 1);
>>>>>>>>>>>>>> hlist_add_head_rcu(&obj->obj_node, list);
>>>>>>>>>>>>>> unlock_chain(); // typically a spin_unlock()
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> @@ -165,12 +170,12 @@ Note that using hlist_nulls means =
the type of 'obj_node' field of
>>>>>>>>>>>>>> begin:
>>>>>>>>>>>>>> rcu_read_lock();
>>>>>>>>>>>>>> hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) =
{
>>>>>>>>>>>>>> -    if (obj->key =3D=3D key) {
>>>>>>>>>>>>>> +    if (READ_ONCE(obj->key) =3D=3D key) {
>>>>>>>>>>>>>> if (!try_get_ref(obj)) { // might fail for free objects
>>>>>>>>>>>>>> rcu_read_unlock();
>>>>>>>>>>>>>>   goto begin;
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>> -      if (obj->key !=3D key) { // not the object we =
expected
>>>>>>>>>>>>>> +      if (READ_ONCE(obj->key) !=3D key) { // not the =
object we expected
>>>>>>>>>>>>>>   put_ref(obj);
>>>>>>>>>>>>>> rcu_read_unlock();
>>>>>>>>>>>>>>   goto begin;
>>>>>>>>>>>>>> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
>>>>>>>>>>>>>> */
>>>>>>>>>>>>>> obj =3D kmem_cache_alloc(cachep);
>>>>>>>>>>>>>> lock_chain(); // typically a spin_lock()
>>>>>>>>>>>>>> -  obj->key =3D key;
>>>>>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
>>>>>>>>>>>>>> atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>>>>>>>>>>>> /*
>>>>>>>>>>>>>> * insert obj in RCU way (readers might be traversing =
chain)
>>>>>>>>>>>>>> --=20
>>>>>>>>>>>>>> 2.34.1

