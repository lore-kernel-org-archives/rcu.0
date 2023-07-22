Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BEBC0015E
	for <rcu@archiver.kernel.org>; Sat, 22 Jul 2023 01:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGVBC5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Jul 2023 21:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGVBC4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Jul 2023 21:02:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3882F30D7;
        Fri, 21 Jul 2023 18:02:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1647656a12.1;
        Fri, 21 Jul 2023 18:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689987774; x=1690592574;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGYnqhJpWuVQ6nBOOEbx55botldEKDEEdNGDus7lcb0=;
        b=QO51gEh7/OMPfhhqy195AGaii9iZZ+G5cuhcAC9nkdc6PaXtGe+EmoRittU3n1hub3
         dWbivs0bKvxU59muYh9WKgPLkYMfbtpIxlVaplfhGbLBCdmMHM0P/h85xS5EUvdF5Awe
         2h8Uwd3alOT3oFSsoCFOxQXeMuvaAW9Gdj8nhtvzQXgOE/x1oSBR+wMmqthfRD0Keex+
         +ljl/ag2FutSp8aKYQKVyTPrqhNGowwYHHClVSZudeaN1QO6ZZd2BdOvKHbsVXIshmU7
         3OKBW/FiCZdXmWP/PAZWHNP4UpmSKlSIHxHJMViF2+RrmXpTm/J7vqj6vrAOTX8NW95x
         WLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689987774; x=1690592574;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGYnqhJpWuVQ6nBOOEbx55botldEKDEEdNGDus7lcb0=;
        b=ZVQuIp1Pk79XU+qWKY4jj5Iz3VkDj8aEMUrr8Gr0F+cW+NGv5Tc5DAODaKI7E2knoU
         kcVIcqHCQjNvej9cKqXMXhxQ8P0dRivaBfwg1N7NgaCo6xvbNJeYLE7DRh26drki1c+g
         NxMpS5yaRBzD+qH0me87U/+XBAfIDPCHgVRGuPm5DPCkTgL6aX+SjPA4RUSPk1bZeEsm
         LL70JQZHa/qf682jBCdM0FoV51Sls9h+4FxhTnQ8LujJSNTAfkBc+oTfsyGZ63nu3wzV
         fMtfJmxFEOgBeZlBFDWFpY1QLWw5wqWvAIP5ADdQq+kHZ27rkuVLaTxvBoH9cZezqDC/
         Wkwg==
X-Gm-Message-State: ABy/qLYBcaoMq6ypCV/EfVF4M236JprlARZxjpt0ugr/m+XfcHAS2lGT
        1gnvkSpqszzLLgyUu4JDIuw=
X-Google-Smtp-Source: APBJJlEb8c+SPJEhCixQUxMSHr1TMATnCt/LGgbkiTVDpIZsQTKAO6DQ3f8nn+BVzJ1s0ziJ98dchw==
X-Received: by 2002:a17:90a:5895:b0:267:6a1d:323c with SMTP id j21-20020a17090a589500b002676a1d323cmr3161048pji.43.1689987774443;
        Fri, 21 Jul 2023 18:02:54 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a564800b002657aa777f1sm4695884pji.19.2023.07.21.18.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 18:02:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <8d54c0a5-11ab-48e2-b187-25b229406b2a@paulmck-laptop>
Date:   Sat, 22 Jul 2023 09:02:46 +0800
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99F1D0AB-5085-42CA-BFF0-6D5AC488F960@gmail.com>
References: <20230711150906.466434-1-mmpgouride@gmail.com>
 <9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop>
 <9D42CEB7-FE22-4BC6-9E5C-8131579C129D@gmail.com>
 <eabec10a-9283-42eb-85c7-e447e2368c91@paulmck-laptop>
 <6E813D30-2791-4DE8-A70C-E1F91011631D@gmail.com>
 <02a84e4b-a322-4c43-ad9d-1832ce277c2f@paulmck-laptop>
 <636D1ED4-C90D-47CA-A46A-28E40E777966@gmail.com>
 <9b1967c5-6b8d-4d66-879c-42818d6e3170@paulmck-laptop>
 <30E3504D-4E64-4C61-9503-690C1657C6F3@gmail.com>
 <8d54c0a5-11ab-48e2-b187-25b229406b2a@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8A=E5=8D=886:49=EF=BC=8CPaul =
E. McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 19, 2023 at 12:08:33AM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 03:06=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Tue, Jul 18, 2023 at 01:53:10AM +0800, Alan Huang wrote:
>>>>> 2023=E5=B9=B47=E6=9C=8818=E6=97=A5 00:02=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>> On Sun, Jul 16, 2023 at 07:21:28PM +0800, Alan Huang wrote:
>>>>>>> 2023=E5=B9=B47=E6=9C=8816=E6=97=A5 01:19=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>> On Sat, Jul 15, 2023 at 08:50:23AM +0800, Alan Huang wrote:
>>>>>>>>> 2023=E5=B9=B47=E6=9C=8815=E6=97=A5 07:23=EF=BC=8CPaul E. =
McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>>>> On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang wrote:
>>>>>>>>>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and =
there is
>>>>>>>>>> n->next =3D first within hlist_add_head_rcu() before =
rcu_assign_pointer(),
>>>>>>>>>> which modifies obj->obj_node.next. There may be readers =
holding the
>>>>>>>>>> reference of obj in lockless_lookup, and when updater =
modifies ->next,
>>>>>>>>>> readers can see the change immediately because =
ofSLAB_TYPESAFE_BY_RCU.
>>>>>>>>>>=20
>>>>>>>>>> There are two memory ordering required in the insertion =
algorithm,
>>>>>>>>>> we need to make sure obj->key is updated before =
obj->obj_node.next
>>>>>>>>>> and obj->refcnt, atomic_set_release is not enough to provide =
the
>>>>>>>>>> required memory barrier.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>>>>>>>=20
>>>>>>>>> This is an interesting one!!!
>>>>>>>>>=20
>>>>>>>>> Now I am having a hard time believing that the smp_rmb() =
suffices.
>>>>>>>>>=20
>>>>>>>>>> ---
>>>>>>>>>> Changelog:
>>>>>>>>>> v1 -> v2: Use _ONCE to protect obj->key.
>>>>>>>>>>=20
>>>>>>>>>> Documentation/RCU/rculist_nulls.rst | 21 =
+++++++++++++--------
>>>>>>>>>> 1 file changed, 13 insertions(+), 8 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>> index 21e40fcc08de..2a9f5a63d334 100644
>>>>>>>>>> --- a/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>> +++ b/Documentation/RCU/rculist_nulls.rst
>>>>>>>>>> @@ -47,7 +47,7 @@ objects, which is having below type.
>>>>>>>>>> * reuse these object before the RCU grace period, we
>>>>>>>>>> * must check key after getting the reference on object
>>>>>>>>>> */
>>>>>>>>>> -    if (obj->key !=3D key) { // not the object we expected
>>>>>>>>>> +    if (READ_ONCE(obj->key) !=3D key) { // not the object we =
expected
>>>>>>>>>>   put_ref(obj);
>>>>>>>>>>   rcu_read_unlock();
>>>>>>>>>>   goto begin;
>>>>>>>>>> @@ -64,10 +64,10 @@ but a version with an additional memory =
barrier (smp_rmb())
>>>>>>>>>> {
>>>>>>>>>> struct hlist_node *node, *next;
>>>>>>>>>> for (pos =3D rcu_dereference((head)->first);
>>>>>>>>>> -         pos && ({ next =3D pos->next; smp_rmb(); =
prefetch(next); 1; }) &&
>>>>>>>>>> +         pos && ({ next =3D READ_ONCE(pos->next); smp_rmb(); =
prefetch(next); 1; }) &&
>>>>>>>>>=20
>>>>>>>>> Suppose that lockless_lookup() is delayed just before fetching =
pos->next,
>>>>>>>>> and that there were 17 more node to search in the list.
>>>>>>>>>=20
>>>>>>>>> Then consider the following sequence of events:
>>>>>>>>>=20
>>>>>>>>> o The updater deletes this same node and kmem_cache_free()s =
it.
>>>>>>>>>=20
>>>>>>>>> o Another updater kmem_cache_alloc()s that same memory and
>>>>>>>>> inserts it into an empty hash chain with a different key.
>>>>>>>>>=20
>>>>>>>>> o Then lockless_lookup() fetches pos->next and sees a NULL =
pointer,
>>>>>>>>> thus failing to search the remaining 17 nodes in the list,
>>>>>>>>> one of which had the desired key value.
>>>>>>>>>=20
>>>>>>>>> o The lookup algorithm resumes and sees the NULL return from
>>>>>>>>> lockless_lookup(), and ends up with a NULL obj.
>>>>>>>>>=20
>>>>>>>>> And this happens even with the strongest possible ordering
>>>>>>>>> everywhere.
>>>>>>>>>=20
>>>>>>>>> OK, yes, it is late on Friday.  So what am I missing here?
>>>>>>>>=20
>>>>>>>> You missed nothing!
>>>>>>>>=20
>>>>>>>> The lockless_lockup should not be a function, but a macro like =
hlist_for_each_entry_rcu.
>>>>>>>=20
>>>>>>> How would you fix this using a macro?
>>>>>>=20
>>>>>> With additional detection code. A moved object (in another chain) =
will have a different slot.
>>>>>> (I have sent patch v3. )
>>>>>>=20
>>>>>>>=20
>>>>>>>>> Independent of that, does hlist_add_head_rcu() need to replace =
its
>>>>>>>>> "n->next =3D first" with "WRITE_ONCE(n->next, first)"?
>>>>>>>>=20
>>>>>>>> I think users who want to use hlist with SLAB_TYPESAFE_BY_RCU =
should use rculist_nulls?
>>>>>>>=20
>>>>>>> I believe that you are correct.  Would you like to propose a =
patch, or
>>>>>>> would you rather I put something together?  My current thought =
is to
>>>>>>=20
>>>>>> Feel free to add.=20
>>>>>>=20
>>>>>> One thing I think would be useful is to tell readers where the =
=E2=80=98next' is.=20
>>>>>> The document mentions =E2=80=99next=E2=80=99 many times, but =
it=E2=80=99s hard for me, as a reader, to realize that
>>>>>> the =E2=80=98next' is within hlist_add_head_rcu(). (I have no =
idea where to put the hint.)
>>>>>>=20
>>>>>>=20
>>>>>>> keep the examples, but to show why the one with smp_rmb() is =
broken.
>>>>>>=20
>>>>>> I think the example needs to be fixed. :)
>>>>>=20
>>>>> Even better!  I will take a look, but in the meantime, would you =
be
>>>>> interested in updating the wording to explain how the back-pointer =
works?
>>>>=20
>>>> Which document needs to be updated?=20
>>>> And is there anything that I can refer to? It=E2=80=99s the first =
time I have ever heard about it.
>>>=20
>>> Documentation/RCU/rculist_nulls.rst, the one that you are updating.
>>>=20
>>> There admittedly isn't a whole lot of commentary.
>>>=20
>>>>> (Looks similar to the is_a_nulls() pointer, but in each element =
instead of
>>>>> just at the end.  One advantage is the ability to detect a move =
mid-list,
>>>>> though that is not a big deal in well-tuned hash tables, which =
tend to
>>>>> have short hash chains.  The need to move elements to the front of =
the
>>>>> destination list remains, though in both cases only if it has been =
less
>>>>> than a grace period since the last move.)
>>>>=20
>>>> Looks like that I need to learn it first. :)
>>>=20
>>> Well, you wrote the code, so...  ;-)
>>=20
>> If I understand correctly, it works only for 64-bit machines?
>>=20
>> And the number of slots of the hash table will be limited?
>=20
> You are asking about the is_a_nulls() value?  If so, it works on both
> 32-bit and 64-bit machines.  They each have enough bits for the nulls
> value to cover all possible two-byte objects in the full address =
space.
>=20
> If that wasn't what you were asking, please help me with your =
question.

I=E2=80=99m asking the =E2=80=98back-pointer=E2=80=99, which

	"Looks similar to the is_a_nulls() pointer, but in each element =
instead of
	 just at the end=E2=80=9D

If I understand correctly, we need to store the nulls in the upper =
unused bits.

And we only have several bits unused. One advantage I can think of is =
that it=20
will improve the performance once we have something like the Intel Upper =
Address Ignore (UAI),
which also works only for 64-bit machine.


>=20
> 						Thanx, Paul
>=20
>>> Thanx, Paul
>>>=20
>>>>> Thanx, Paul
>>>>>=20
>>>>>>>> I didn=E2=80=99t find a case using hlist with =
SLAB_TYPESAFE_BY_RCU, but I did find a case using list
>>>>>>>> with SLAB_TYPESAFE_BY_RCU in drivers/gpu/drm/i915, the driver =
also doesn=E2=80=99t use _ONCE
>>>>>>>> on the fields of the objects allocated with =
SLAB_TYPESAFE_BY_RCU.
>>>>>>>=20
>>>>>>> Feel free to send them a patch, though I cannot speak for their
>>>>>>> reception of it.
>>>>>>>=20
>>>>>>> Thanx, Paul
>>>>>>>=20
>>>>>>>>> Thanx, Paul
>>>>>>>>>=20
>>>>>>>>>>      ({ obj =3D hlist_entry(pos, typeof(*obj), obj_node); 1; =
});
>>>>>>>>>>      pos =3D rcu_dereference(next))
>>>>>>>>>> -      if (obj->key =3D=3D key)
>>>>>>>>>> +      if (READ_ONCE(obj->key) =3D=3D key)
>>>>>>>>>>     return obj;
>>>>>>>>>> return NULL;
>>>>>>>>>> }
>>>>>>>>>> @@ -111,8 +111,13 @@ detect the fact that it missed following =
items in original chain.
>>>>>>>>>> */
>>>>>>>>>> obj =3D kmem_cache_alloc(...);
>>>>>>>>>> lock_chain(); // typically a spin_lock()
>>>>>>>>>> -  obj->key =3D key;
>>>>>>>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
>>>>>>>>>> +  /*
>>>>>>>>>> +   * We need to make sure obj->key is updated before =
obj->obj_node.next
>>>>>>>>>> +   * and obj->refcnt.
>>>>>>>>>> +   */
>>>>>>>>>> +  smp_wmb();
>>>>>>>>>> +  atomic_set(&obj->refcnt, 1);
>>>>>>>>>> hlist_add_head_rcu(&obj->obj_node, list);
>>>>>>>>>> unlock_chain(); // typically a spin_unlock()
>>>>>>>>>>=20
>>>>>>>>>> @@ -165,12 +170,12 @@ Note that using hlist_nulls means the =
type of 'obj_node' field of
>>>>>>>>>> begin:
>>>>>>>>>> rcu_read_lock();
>>>>>>>>>> hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
>>>>>>>>>> -    if (obj->key =3D=3D key) {
>>>>>>>>>> +    if (READ_ONCE(obj->key) =3D=3D key) {
>>>>>>>>>>   if (!try_get_ref(obj)) { // might fail for free objects
>>>>>>>>>> rcu_read_unlock();
>>>>>>>>>>     goto begin;
>>>>>>>>>>   }
>>>>>>>>>> -      if (obj->key !=3D key) { // not the object we expected
>>>>>>>>>> +      if (READ_ONCE(obj->key) !=3D key) { // not the object =
we expected
>>>>>>>>>>     put_ref(obj);
>>>>>>>>>> rcu_read_unlock();
>>>>>>>>>>     goto begin;
>>>>>>>>>> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
>>>>>>>>>> */
>>>>>>>>>> obj =3D kmem_cache_alloc(cachep);
>>>>>>>>>> lock_chain(); // typically a spin_lock()
>>>>>>>>>> -  obj->key =3D key;
>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
>>>>>>>>>> atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>>>>>>>> /*
>>>>>>>>>> * insert obj in RCU way (readers might be traversing chain)
>>>>>>>>>> --=20
>>>>>>>>>> 2.34.1

