Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00BEB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjFQSWL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjFQSWK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 14:22:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB81988;
        Sat, 17 Jun 2023 11:22:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54fd6aa3b0dso953602a12.2;
        Sat, 17 Jun 2023 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687026129; x=1689618129;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNlaQjCzRCtj6+QVvj17zK7OgCx+s9oSz+rg6Gn0AI4=;
        b=j9szqf4MrZg9YKmZJqAHmotGHzCvB6UOPMxITjyF3yO8pVLgRcfvRonOH8fxGXSega
         3Z5GVFWt50HEfBVEVQEOaoE+ZRX/kpeXkDLmhxSyPvDtSYkTGkyJ+T3FzlcqAcdNfDeh
         FJJqDmR2SnxJmMqDLRC/CyHnb6Nm44l9A9wI9PLkc6oTEFVeTZUWrqf4Bq3rm5j2N70x
         JUdauPZz4igKCjxRRaOG9kQ3E2L6bg+ZffzIZeU2W7UPpM+7h1bLnaZi/DzeincUN3zM
         35+jwm9xsW7zCFGC/dW92RJ7Qr53RmjfHwd6XcZpvHxBkXZKrcT9TjkWqzZ6BmKexZWK
         E+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687026129; x=1689618129;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNlaQjCzRCtj6+QVvj17zK7OgCx+s9oSz+rg6Gn0AI4=;
        b=kwcGK8ULk/hfqyGZin9RG0Uh4InI9DFFOJjbiPzKmTCiz78GX1RhDeeCKtYdzvaMb3
         VRADap1CSL3vZVZafeSSLOZbWnyRiOw2ENmz2FiDwihAzVgDEiW4kvDa+FXmtPsMBbAm
         X97Xj4aJD5W9fMZfIbD5oiNP7AvEemEiMyzBsyjxrlINBPtphd/RQNdWFqYSIJvdp/7h
         ZHnCLz9HQn9NDmKnkWxVqfw8UHjGve+iSQpHcDL1PE3VtjTgefKN3bu0FUNaYwil1nmO
         D8cp9dPBrbkxPn4VDuaR/RE41Qdd+l+BkfewqgR+lkWd3DZ75Sh4tz1EPRgMiFgoTlLj
         nPag==
X-Gm-Message-State: AC+VfDycjHhsrmy/LvLZZAXzp8lGBmVcDGeM69VMXd1GK00EKoNzJGab
        1kq9VzTnHfsNIuGyqaC+GD8=
X-Google-Smtp-Source: ACHHUZ72cZG8ROFi6pNdpDT/Ac7bbKRd5sT05O/DYZtS31hLGwFh3CSzCqsR14x1TJOEhIPQxIOLIg==
X-Received: by 2002:a05:6a21:78b:b0:10b:26b9:57c3 with SMTP id mg11-20020a056a21078b00b0010b26b957c3mr3927965pzb.14.1687026128901;
        Sat, 17 Jun 2023 11:22:08 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001aad4be4503sm17836427plc.2.2023.06.17.11.22.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2023 11:22:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ZI32Zzxm/6m30L7g@casper.infradead.org>
Date:   Sun, 18 Jun 2023 02:21:48 +0800
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <747B154D-906B-4D3F-9E0B-40686BDF8B09@gmail.com>
References: <20230617145346.29009-1-mmpgouride@gmail.com>
 <ZI3r9zH8+xlzGU1H@casper.infradead.org>
 <CC48F50F-0121-4E77-95CF-9E0DEE6991E4@gmail.com>
 <ZI32Zzxm/6m30L7g@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8818=E6=97=A5 02:07=EF=BC=8CMatthew Wilcox =
<willy@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, Jun 18, 2023 at 01:55:10AM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B46=E6=9C=8818=E6=97=A5 01:23=EF=BC=8CMatthew Wilcox =
<willy@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Sat, Jun 17, 2023 at 02:53:46PM +0000, Alan Huang wrote:
>>>> There are two memory ordering required in the insertion algorithm,
>>>> we need to make sure obj->key is updated before obj->obj_node.next
>>>> and obj->refcnt, atomic_set_release is not enough to provide the
>>>> required memory barrier.
>>>>=20
>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>> ---
>>>> Documentation/RCU/rculist_nulls.rst | 9 +++++++--
>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>>>> index e06ed40bb6..77244adbdf 100644
>>>> --- a/Documentation/RCU/rculist_nulls.rst
>>>> +++ b/Documentation/RCU/rculist_nulls.rst
>>>> @@ -98,7 +98,7 @@ Quoting Corey Minyard::
>>>> ----------------------
>>>>=20
>>>> We need to make sure a reader cannot read the new =
'obj->obj_node.next' value
>>>> -and previous value of 'obj->key'. Otherwise, an item could be =
deleted
>>>> +and previous value of 'obj->key' at the same time. Otherwise, an =
item could be deleted
>>>=20
>>> "at the same time" doesn't make a lot of sense to me.  CPUs don't do
>>> anything "at the same time".  I think the way this is worded now is
>>> fine; I tried coming up with a few variants of this, but none are as
>>> clear and succinct as what is there now.
>>>=20
>>>> from a chain, and inserted into another chain. If new chain was =
empty
>>>> before the move, 'next' pointer is NULL, and lockless reader can =
not
>>>> detect the fact that it missed following items in original chain.
>>>> @@ -112,7 +112,12 @@ detect the fact that it missed following items =
in original chain.
>>>>  obj =3D kmem_cache_alloc(...);
>>>>  lock_chain(); // typically a spin_lock()
>>>>  obj->key =3D key;
>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>> +  /*
>>>> +  * we need to make sure obj->key is updated before =
obj->obj_node.next
>>>> +  * and obj->refcnt
>>>> +  */
>>>> +  smp_wmb();
>>>> +  atomic_set(&obj->refcnt, 1);
>>>=20
>>> Perhaps this could be a little clearer for those of us who aren't as
>>> deep into the memory model as others ... are you saying that the
>>> atomic_set_release() would only order references to obj->refcount =
and
>>> would not order accesses to obj->key?  Because reading this:
>>>=20
>>>    The use of ACQUIRE and RELEASE operations generally precludes the =
need
>>>    for other sorts of memory barrier.  In addition, a =
RELEASE+ACQUIRE pair is
>>>    -not- guaranteed to act as a full memory barrier.  However, after =
an
>>>    ACQUIRE on a given variable, all memory accesses preceding any =
prior
>>>    RELEASE on that same variable are guaranteed to be visible.  In =
other
>>>    words, within a given variable's critical section, all accesses =
of all
>>>    previous critical sections for that variable are guaranteed to =
have
>>>    completed.
>>>=20
>>> makes me think that this example is fine; anybody doing a =
load-acquire
>>> on obj->refcount will see the update to obj->key that happened =
before
>>> the store-release to obj->refcount.
>>=20
>> Two memory ordering required here, atomic_set_release only provides =
one of them (the one you mentioned)
>>=20
>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is:
>>=20
>> n->next =3D first;
>>=20
>> in hlist_add_head_rcu, which modifies obj->obj_node.next.
>=20
> But isn't that the bug?  ie this assignment should be WRITE_ONCE() or
> smp_store_release() or rcu_assign_pointer() or whichever of these
> similar functions is actually appropriate?

Without SLAB_TYPESAFE_BY_RCU, it=E2=80=99s fine, because it only =
modifies local data, which has not been published.

But with SLAB_TYPESAFE_BY_RCU, it might be a bug, but I=E2=80=99m not =
very sure.

>=20
>> So, we must make sure obj->key is updated before obj->obj_node.next, =
without smp_wmb(), we can read
>> the new 'obj->obj_node.next=E2=80=99 value and previous value of =
'obj->key=E2=80=99 at the same time, and in this case, we
>> can not detect the movement of the object.
>>=20
>> The following link might be helpful:
>>=20
>> =
https://patchwork.ozlabs.org/project/netdev/patch/491C282A.5050802@cosmosb=
ay.com/
>>=20
>>=20
>>>=20
>>> I am not an expert and would welcome the opportunity to learn more =
here.


