Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF31EB64D7
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 01:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFUBY6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 21:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFUBY6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 21:24:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB91988;
        Tue, 20 Jun 2023 18:24:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b45e465d4fso3533046a34.3;
        Tue, 20 Jun 2023 18:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687310690; x=1689902690;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht7Hvz2clcouuvqbQCR8mufswcFst26xxquJxEe3eF4=;
        b=KHLuGKJ094RZXgksfWJB6K9PhrYZLnFumKM5gRwUovH1Inxi8XDAbDl7L3vETmbqs7
         mYpe5k8dRvjIQVH9LmVLJORlX/AYuP+qhgxwhRqnTxJPj8OdB7jdRXKX5bbHMJ5NLjvd
         l1W4ObldurLplfvE45pjtqLGSRus7O/5jOTeKimLE7XByVLfpP+PajgixgZ1i/Fd9Q+k
         cN8LT+Ivgbte2bXoxH33aATtuo+Tz4n90uKh10cWKwTVVh/7aDvn0ZFnYFI+vAnISuVy
         f4sOuLVMoWTTFixt5oxyZsV42BwBFEPgKSHjutlwlkEa4KRIp+gwk4NrR3iOiTW8RfN4
         SETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687310690; x=1689902690;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht7Hvz2clcouuvqbQCR8mufswcFst26xxquJxEe3eF4=;
        b=Gss3b3MsbaLo6fO49ahNp6NEgEOdq99m45tNsCzGroKxAG54RDBe22CcVZXyC+BxFY
         rmNcMjoVONeTOrpJLmuHyFOBApSvSVfheqcLvpJq9m7mQGOHA24EyGte9o6EmaWLTlUa
         il2HNvhM5byMvqxOAuzfWVZ8yT8jPIDpRW0oiNU8aDmY96NzwEGqIljychlsVx0DGXQS
         R1utpVgD2N8L4oOXYn1VEPOr025Ay9v95oR2PgmOOP0WszdSNBnr0HkRkllK01mpjYd6
         Sb5exoKSjfRyDf8zDoDQ5MQSUWk8egrRm4ySzva6WcRJfn/ys51u8vnp+KOp78/fxIpX
         Z38w==
X-Gm-Message-State: AC+VfDyDXTO861aEU+W4H9SUqTPE5ySVolv6/xB6tVlOeBO+ne5oIqHd
        4QcSLqzl7cHQHTWSqrJAe1vNgKErb34=
X-Google-Smtp-Source: ACHHUZ714CQayljNaVNuf8faXuCJR5ovrIeqDRf8X0bxkNecxSLfcCzvcyQhSGewWL1L/sUoyBr3+Q==
X-Received: by 2002:a05:6358:e91a:b0:12b:dc0e:d385 with SMTP id gk26-20020a056358e91a00b0012bdc0ed385mr7974623rwb.15.1687310689538;
        Tue, 20 Jun 2023 18:24:49 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b0065446092699sm1870347pfd.141.2023.06.20.18.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2023 18:24:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <002d991c-4064-4219-a4a1-ef98bba88a65@paulmck-laptop>
Date:   Wed, 21 Jun 2023 09:24:30 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC255E5C-5F0A-42DF-B16A-54731ED7426C@gmail.com>
References: <20230617145346.29009-1-mmpgouride@gmail.com>
 <002d991c-4064-4219-a4a1-ef98bba88a65@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> 2023=E5=B9=B46=E6=9C=8821=E6=97=A5 06:33=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jun 17, 2023 at 02:53:46PM +0000, Alan Huang wrote:
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
>> index e06ed40bb6..77244adbdf 100644
>> --- a/Documentation/RCU/rculist_nulls.rst
>> +++ b/Documentation/RCU/rculist_nulls.rst
>> @@ -98,7 +98,7 @@ Quoting Corey Minyard::
>> ----------------------
>>=20
>> We need to make sure a reader cannot read the new =
'obj->obj_node.next' value
>> -and previous value of 'obj->key'. Otherwise, an item could be =
deleted
>> +and previous value of 'obj->key' at the same time. Otherwise, an =
item could be deleted
>> from a chain, and inserted into another chain. If new chain was empty
>> before the move, 'next' pointer is NULL, and lockless reader can not
>> detect the fact that it missed following items in original chain.
>> @@ -112,7 +112,12 @@ detect the fact that it missed following items =
in original chain.
>>   obj =3D kmem_cache_alloc(...);
>>   lock_chain(); // typically a spin_lock()
>>   obj->key =3D key;
>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>> +  /*
>> +  * we need to make sure obj->key is updated before =
obj->obj_node.next
>> +  * and obj->refcnt
>> +  */
>> +  smp_wmb();
>> +  atomic_set(&obj->refcnt, 1);
>=20
> You lost me on this one.
>=20
> =46rom what I can see, in the original the atomic_set_release() =
provided
> ordering between the ->key assignment and the ->refcnt assignment,
> and then the rcu_assign_pointer() within hlist_add_head_rcu() provided
> ordering between both the ->key and the ->refcnt assignments on the =
one
> hand and the list insertion on the other.
>=20
> What am I missing here?

The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is=20
n->next =3D first within hlist_add_head_rcu() before =
rcu_assign_pointer(), which
modifies obj->obj_node.next. There may be readers holding the reference =
of obj in
lockless_lookup, and when updater modifies ->next, readers can see the =
change immediately=20
because of SLAB_TYPESAFE_BY_RCU.

So, the line n->next =3D first is running concurrently with the line =
pos->next in lockless_lookup.

As you can see, after pos->next in lockless_lookup is the smp_rmb(),=20
we need to make sure obj->key is updated before obj->obj_node.next =
(which is n->next =3D first in hlist_add_head_rcu).

So, the smp_wmb() is synchronized with the smp_rmb() in =
lockless_lookup() and the load acquire in try_get_ref().

>=20
> Thanx, Paul
>=20
>>   hlist_add_head_rcu(&obj->obj_node, list);
>>   unlock_chain(); // typically a spin_unlock()
>>=20
>> --=20
>> 2.34.1
>>=20

