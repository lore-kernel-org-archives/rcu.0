Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA83BC0015E
	for <rcu@archiver.kernel.org>; Sat, 15 Jul 2023 00:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGOAvX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Jul 2023 20:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOAvX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Jul 2023 20:51:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28558E5C;
        Fri, 14 Jul 2023 17:51:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668730696a4so1763875b3a.1;
        Fri, 14 Jul 2023 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689382281; x=1691974281;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDRscaBv1w0JWMXd2m8J/EKtFh9sNf9PLS46tboQ92A=;
        b=lEQpUhXoaQYq3ipsCgvn6ndAkMtqdYR33+sgW68eu0ocD14HS/NNWiGEDopcOs/GdZ
         2u3CqZCITqL0ZnAClIJdxI0Q+peqW+0I5HCc1e6L6BV/T9JPuZPTAE5j0ZecAzTd3n52
         FigZHs4dYcWPoX3V6NQkLubQtbgekjg0Sp6XxMwSclMjgd5J/QYZiYxG3oWa6NfhiOw+
         jh+rB5El0lqLIskBvrlQvRfvxxWahdjB+/TmtSrYMmpe7nXcUXXYdXrRhfCseED2eoVi
         OqUDB9Pi8Sac3y0ay/97IeIQW0KvxH2Z+/QRClTzZkBmF3P5CnZckthmmIBxym9nlmbs
         A5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382281; x=1691974281;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDRscaBv1w0JWMXd2m8J/EKtFh9sNf9PLS46tboQ92A=;
        b=N24LRDYn8U0tfVxIAID67vmIsLs6EbXNlPNsURU7LlZiG8ZRAXNzf+lU6iabXwumYy
         0gJHlR0FEydmDQ3XB/+odEQoAZ0E7OaBxv9e6eRfd/VX7Z8qvo310TDvME7y4BWX2iCB
         gXKqMvOnu5cTdbKrDFcQjZj4C66JZuvO/01XBljY9MarFB0mfT3XRj1t5n8TfxT/cMIL
         WA9lInY/oTrQhrnkwNxMdR7FzT6PqK71jZ2rUvpa3eY2D+8FCWQXd1ni8oGsnJoKA3pp
         bl88VMtUT0VfJRAZ14TO1OFbtetLg9GyryiHA6k2iF1EjCO8Y/dGu8iMJGtvIYKyUDJm
         BZ1A==
X-Gm-Message-State: ABy/qLYn10PcE+E+YCNbV1u3SzEKnb2XdkQtzBuhIpLXu5ZdLhz/OZCU
        RVqAxKRR1bQShp9RJvJfyEA=
X-Google-Smtp-Source: APBJJlHnnok9Mx+f7RYJsZHV8yEum4Sn1wcdAs7XUsX21sDjr1H6pLwz8q+mTssH7RCTpLZGXrDz3g==
X-Received: by 2002:a05:6a00:392a:b0:668:8596:752f with SMTP id fh42-20020a056a00392a00b006688596752fmr6380571pfb.4.1689382281476;
        Fri, 14 Jul 2023 17:51:21 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0066a4e561beesm7959658pfo.173.2023.07.14.17.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 17:51:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop>
Date:   Sat, 15 Jul 2023 08:50:23 +0800
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D42CEB7-FE22-4BC6-9E5C-8131579C129D@gmail.com>
References: <20230711150906.466434-1-mmpgouride@gmail.com>
 <9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8815=E6=97=A5 07:23=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang wrote:
>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
>> n->next =3D first within hlist_add_head_rcu() before =
rcu_assign_pointer(),
>> which modifies obj->obj_node.next. There may be readers holding the
>> reference of obj in lockless_lookup, and when updater modifies =
->next,
>> readers can see the change immediately because =
ofSLAB_TYPESAFE_BY_RCU.
>>=20
>> There are two memory ordering required in the insertion algorithm,
>> we need to make sure obj->key is updated before obj->obj_node.next
>> and obj->refcnt, atomic_set_release is not enough to provide the
>> required memory barrier.
>>=20
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>=20
> This is an interesting one!!!
>=20
> Now I am having a hard time believing that the smp_rmb() suffices.
>=20
>> ---
>> Changelog:
>>  v1 -> v2: Use _ONCE to protect obj->key.
>>=20
>> Documentation/RCU/rculist_nulls.rst | 21 +++++++++++++--------
>> 1 file changed, 13 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>> index 21e40fcc08de..2a9f5a63d334 100644
>> --- a/Documentation/RCU/rculist_nulls.rst
>> +++ b/Documentation/RCU/rculist_nulls.rst
>> @@ -47,7 +47,7 @@ objects, which is having below type.
>>     * reuse these object before the RCU grace period, we
>>     * must check key after getting the reference on object
>>     */
>> -    if (obj->key !=3D key) { // not the object we expected
>> +    if (READ_ONCE(obj->key) !=3D key) { // not the object we =
expected
>>       put_ref(obj);
>>       rcu_read_unlock();
>>       goto begin;
>> @@ -64,10 +64,10 @@ but a version with an additional memory barrier =
(smp_rmb())
>>   {
>>     struct hlist_node *node, *next;
>>     for (pos =3D rcu_dereference((head)->first);
>> -         pos && ({ next =3D pos->next; smp_rmb(); prefetch(next); 1; =
}) &&
>> +         pos && ({ next =3D READ_ONCE(pos->next); smp_rmb(); =
prefetch(next); 1; }) &&
>=20
> Suppose that lockless_lookup() is delayed just before fetching =
pos->next,
> and that there were 17 more node to search in the list.
>=20
> Then consider the following sequence of events:
>=20
> o The updater deletes this same node and kmem_cache_free()s it.
>=20
> o Another updater kmem_cache_alloc()s that same memory and
> inserts it into an empty hash chain with a different key.
>=20
> o Then lockless_lookup() fetches pos->next and sees a NULL pointer,
> thus failing to search the remaining 17 nodes in the list,
> one of which had the desired key value.
>=20
> o The lookup algorithm resumes and sees the NULL return from
> lockless_lookup(), and ends up with a NULL obj.
>=20
> And this happens even with the strongest possible ordering
> everywhere.
>=20
> OK, yes, it is late on Friday.  So what am I missing here?

You missed nothing!

The lockless_lockup should not be a function, but a macro like =
hlist_for_each_entry_rcu.

>=20
> Independent of that, does hlist_add_head_rcu() need to replace its
> "n->next =3D first" with "WRITE_ONCE(n->next, first)"?

I think users who want to use hlist with SLAB_TYPESAFE_BY_RCU should use =
rculist_nulls?

I didn=E2=80=99t find a case using hlist with SLAB_TYPESAFE_BY_RCU, but =
I did find a case using list
with SLAB_TYPESAFE_BY_RCU in drivers/gpu/drm/i915, the driver also =
doesn=E2=80=99t use _ONCE
on the fields of the objects allocated with SLAB_TYPESAFE_BY_RCU.

>=20
> Thanx, Paul
>=20
>>          ({ obj =3D hlist_entry(pos, typeof(*obj), obj_node); 1; });
>>          pos =3D rcu_dereference(next))
>> -      if (obj->key =3D=3D key)
>> +      if (READ_ONCE(obj->key) =3D=3D key)
>>         return obj;
>>     return NULL;
>>   }
>> @@ -111,8 +111,13 @@ detect the fact that it missed following items =
in original chain.
>>    */
>>   obj =3D kmem_cache_alloc(...);
>>   lock_chain(); // typically a spin_lock()
>> -  obj->key =3D key;
>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>> +  WRITE_ONCE(obj->key, key);
>> +  /*
>> +   * We need to make sure obj->key is updated before =
obj->obj_node.next
>> +   * and obj->refcnt.
>> +   */
>> +  smp_wmb();
>> +  atomic_set(&obj->refcnt, 1);
>>   hlist_add_head_rcu(&obj->obj_node, list);
>>   unlock_chain(); // typically a spin_unlock()
>>=20
>> @@ -165,12 +170,12 @@ Note that using hlist_nulls means the type of =
'obj_node' field of
>>   begin:
>>   rcu_read_lock();
>>   hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
>> -    if (obj->key =3D=3D key) {
>> +    if (READ_ONCE(obj->key) =3D=3D key) {
>>       if (!try_get_ref(obj)) { // might fail for free objects
>> rcu_read_unlock();
>>         goto begin;
>>       }
>> -      if (obj->key !=3D key) { // not the object we expected
>> +      if (READ_ONCE(obj->key) !=3D key) { // not the object we =
expected
>>         put_ref(obj);
>> rcu_read_unlock();
>>         goto begin;
>> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
>>    */
>>   obj =3D kmem_cache_alloc(cachep);
>>   lock_chain(); // typically a spin_lock()
>> -  obj->key =3D key;
>> +  WRITE_ONCE(obj->key, key);
>>   atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>   /*
>>    * insert obj in RCU way (readers might be traversing chain)
>> --=20
>> 2.34.1


