Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B4EB64DD
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGKOu6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjGKOus (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 10:50:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4C10EF;
        Tue, 11 Jul 2023 07:50:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8ad9eede0so43395675ad.1;
        Tue, 11 Jul 2023 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689087046; x=1691679046;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4ZzFzAztfqK0e7nkwa1BjTDaDChluF9bXjvpbun8PI=;
        b=R/k2hs5C5/Cl58kLv2+KS5vPN1DSl5nI0tt6vxsn81gt01uHcQEy2bBCUthK7Gf9fs
         8jd6QRqeG7L9P7zCR+3TliChllVfVM4jJoYtIfQhgHmO0CyYALJTjftLBUbxRAlc6R1u
         m3rKHUcVMrXkpuwrjXPaGugKuD7gl7qtOP4JBBVl9PZhUnrTTz+EaEJtl81965PW6cxy
         WP9JOGu/p3E19iRbXei84m5IIREEfWLnpg3+YDt1rRusxr8jNQa9SG1/jCe/Qqy7VoeV
         VIHGiByKtjGKEcR4r+5XrXvlx2s1jF8QH7ohGMA8KJwvel/lYovRgDClNCuFYfj/ve85
         9Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087046; x=1691679046;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4ZzFzAztfqK0e7nkwa1BjTDaDChluF9bXjvpbun8PI=;
        b=SaqPOItBwoXw9jDwZya8gXygafBJVigKZu3M4Dbi8Pdok7fTYKa6RgtfHfjKbeVV3l
         W/X8u/ZpJ64dWF8vDmYWYxAGeFmtaQBD/hXggImWIWF2dh3a9/eVr9CyRO0sbPTxsz3L
         tDZVvq4Rrjx1UBFNMLsoJqAVzxCV1Blwb4nAnAW2CPUzHd0rnDKPe8IQr2LKQmdvBKiX
         vtE2vTstyZpRzUfrGpjDuJRjoXOLelzFq61ZtdsjAFGTXkYP+Cr9C4Lw1EQEwF9XsEnz
         mayJHe2R924lmowJlwUv2VpiV58FP+tWkXhlwa0Iu1Ix7CvYWpM0y4y8hwJlk9QlwFao
         XUKg==
X-Gm-Message-State: ABy/qLbScWIaWBWnz7CJoGELVVi/1iX9gYebHKfIKrlpDNlKqJy/1nyh
        KLSZjac6WKDM+pTORz+1EZA=
X-Google-Smtp-Source: APBJJlHjZzmDa1X4yHQg7QWutCktdzqnBiWb7lCfIcxfrUTXqTuFOD5Jzrf9KT4Fi7IZluMoJXtQgg==
X-Received: by 2002:a17:902:d2cf:b0:1b3:d357:5ea6 with SMTP id n15-20020a170902d2cf00b001b3d3575ea6mr18298958plc.53.1689087046443;
        Tue, 11 Jul 2023 07:50:46 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902848100b001b03cda6389sm2031189plo.10.2023.07.11.07.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:50:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 2/2] docs/RCU: Bring back smp_wmb()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <41aa064b-7d30-40a7-b454-0da2028f5669@paulmck-laptop>
Date:   Tue, 11 Jul 2023 22:50:14 +0800
Cc:     frederic@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1640133-C0F4-4A33-980D-600C3E7D2973@gmail.com>
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-3-mmpgouride@gmail.com>
 <41aa064b-7d30-40a7-b454-0da2028f5669@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8811=E6=97=A5 03:11=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 06, 2023 at 10:28:49AM +0000, Alan Huang wrote:
>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
>> n->next =3D first within hlist_add_head_rcu() before =
rcu_assign_pointer(),
>> which modifies obj->obj_node.next. There may be readers holding the
>> reference of obj in lockless_lookup, and when updater modifies =
->next,
>> readers can see the change immediately because of =
SLAB_TYPESAFE_BY_RCU.
>>=20
>> There are two memory ordering required in the insertion algorithm,
>> we need to make sure obj->key is updated before obj->obj_node.next
>> and obj->refcnt, atomic_set_release is not enough to provide the
>> required memory barrier.
>>=20
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>> ---
>> Documentation/RCU/rculist_nulls.rst | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>> index 21e40fcc08de..fa3729dc7e74 100644
>> --- a/Documentation/RCU/rculist_nulls.rst
>> +++ b/Documentation/RCU/rculist_nulls.rst
>> @@ -64,7 +64,7 @@ but a version with an additional memory barrier =
(smp_rmb())
>>   {
>>     struct hlist_node *node, *next;
>>     for (pos =3D rcu_dereference((head)->first);
>> -         pos && ({ next =3D pos->next; smp_rmb(); prefetch(next); 1; =
}) &&
>> +         pos && ({ next =3D READ_ONCE(pos->next); smp_rmb(); =
prefetch(next); 1; }) &&
>=20
> This one looks good, though the READ_ONCE() becoming rcu_dereference()
> would allow the smp_rmb() to be dropped, correct?

The pattern here is:

reader 									 =
              updater

// pos->next is also obj->obj_node.next				    =20
READ_ONCE(pos->next); 							=
WRITE_ONCE(obj->key, key);
smp_rmb();									=
	smp_wmb();
										=
		// this is n->next =3D first; within hlist_add_head_rcu
READ_ONCE(obj->key);							=
WRITE_ONCE(obj->obj_node.next, h->first);

The point here is that the objects are allocated with =
SLAB_TYPESAFE_BY_RCU, and there is=20

	 n->next =3D first;

within hlist_add_head_rcu, the modification is visible to readers =
immediately (before the invocation of rcu_assign_pointer)

Therefore, the smp_rmb() is necessary to ensure that we won=E2=80=99t =
get the new value of ->next and the old ->key.
(If we get the new ->next and old ->key, we can not detect movement of =
the object.)

But in this patch, I forgot to add READ_ONCE to obj->key, will send v2.

>=20
>>          ({ obj =3D hlist_entry(pos, typeof(*obj), obj_node); 1; });
>>          pos =3D rcu_dereference(next))
>>       if (obj->key =3D=3D key)
>> @@ -112,7 +112,12 @@ detect the fact that it missed following items =
in original chain.
>>   obj =3D kmem_cache_alloc(...);
>>   lock_chain(); // typically a spin_lock()
>>   obj->key =3D key;
>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>> +  /*
>> +   * We need to make sure obj->key is updated before =
obj->obj_node.next
>> +   * and obj->refcnt.
>> +   */
>> +  smp_wmb();
>> +  atomic_set(&obj->refcnt, 1);
>=20
> ...but what is smp_wmb() doing that the combination of =
atomic_set_release()
> and hlist_add_head_rcu() was not already doing?  What am I missing?

Like above.

>=20
> Thanx, Paul
>=20
>>   hlist_add_head_rcu(&obj->obj_node, list);
>>   unlock_chain(); // typically a spin_unlock()
>>=20
>> --=20
>> 2.34.1


