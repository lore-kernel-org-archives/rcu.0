Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A73EB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFQRza (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFQRz3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 13:55:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ADC10C1;
        Sat, 17 Jun 2023 10:55:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1461082a12.1;
        Sat, 17 Jun 2023 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687024527; x=1689616527;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhhfk2zps/3pALjesyg6wBhXniVGIz1VBa57K3rDBFw=;
        b=r/pgapOm8OELbDipsdLW7ZSq1jzcEqAyMYnHlfPMpgrnDNFFBLSwcq4jEboR8RL7Cx
         jyGoHqjEpkpBN3tMiRDom4DNdT99aSiEMvU9NAsgseXSzR7t4ocfn/gyYjFEiGVtRksp
         J8rtfTbUQrEzPq+kW2CVUtYaCi3Jk5kC0C5a6XfGblJ1VWSWklmBUo01V2lTltHEyPxa
         KuidughZ6sufYBDh5YwuSLk4QDi3l3p5IlnNntjAUyfhLj0oNxZPH/UA68PYnUxpqOPG
         Tq4K6wldeyHk4J2Gkcx4idpwnEnjso9ppy6ULgPoS4QSZfmeJuEzzXml7DqaY4cYSm92
         g77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687024527; x=1689616527;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhhfk2zps/3pALjesyg6wBhXniVGIz1VBa57K3rDBFw=;
        b=XUj4j3a38Mi+uTCQiA8Wd2j9F0R+9/Nali3CwpAfBQSF02EPGxrbjRssUyQcolT09z
         vBBVKx8pfJOmwIvLDsV/5EH5SUPOQx4U1SJOS0cb0EBI1rZ/9sgwBbjHt1crvIJ+g/So
         wO5BO/2zivnOT2Xf0LNw83azst68j/PJcUIDjzAfVLvRb99r/TiK67HTqXhVg1hSBiAp
         GHLhOZRLZXwPz8jDfA2MSAifwHZrsPoU7WYoLi61VeCVCbTX0Vu2LtfBt2Pug26DHzBf
         e4eE/A/TKisAj3nKhDKrJYz3xAJ5CRw4q0Si9KP+rBpYA9c4Iwwq5fgaThj+K7eJqQT8
         35Gg==
X-Gm-Message-State: AC+VfDxK1Kf4kKxkJmSU6FnjeZmFJN5eFXWJ41MzHsVaFT5scfWJ8GAW
        kck41DpTikt+QqRKc4z7RF7d7z5IIIwf5Q==
X-Google-Smtp-Source: ACHHUZ7gWkBODHkk/ywhx2jciEV210mcEbr00APKsatXp2kyOgDrPPUWTf5NUUQLmyufK8zYVYC2EA==
X-Received: by 2002:a05:6a20:e616:b0:10b:f331:d1c0 with SMTP id my22-20020a056a20e61600b0010bf331d1c0mr6131794pzb.30.1687024527266;
        Sat, 17 Jun 2023 10:55:27 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id r64-20020a632b43000000b0054fe6bae952sm5263589pgr.4.2023.06.17.10.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2023 10:55:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ZI3r9zH8+xlzGU1H@casper.infradead.org>
Date:   Sun, 18 Jun 2023 01:55:10 +0800
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC48F50F-0121-4E77-95CF-9E0DEE6991E4@gmail.com>
References: <20230617145346.29009-1-mmpgouride@gmail.com>
 <ZI3r9zH8+xlzGU1H@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8818=E6=97=A5 01:23=EF=BC=8CMatthew Wilcox =
<willy@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
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
>=20
> "at the same time" doesn't make a lot of sense to me.  CPUs don't do
> anything "at the same time".  I think the way this is worded now is
> fine; I tried coming up with a few variants of this, but none are as
> clear and succinct as what is there now.
>=20
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
> Perhaps this could be a little clearer for those of us who aren't as
> deep into the memory model as others ... are you saying that the
> atomic_set_release() would only order references to obj->refcount and
> would not order accesses to obj->key?  Because reading this:
>=20
>     The use of ACQUIRE and RELEASE operations generally precludes the =
need
>     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE =
pair is
>     -not- guaranteed to act as a full memory barrier.  However, after =
an
>     ACQUIRE on a given variable, all memory accesses preceding any =
prior
>     RELEASE on that same variable are guaranteed to be visible.  In =
other
>     words, within a given variable's critical section, all accesses of =
all
>     previous critical sections for that variable are guaranteed to =
have
>     completed.
>=20
> makes me think that this example is fine; anybody doing a load-acquire
> on obj->refcount will see the update to obj->key that happened before
> the store-release to obj->refcount.

Two memory ordering required here, atomic_set_release only provides one =
of them (the one you mentioned)

The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is:
=09
		n->next =3D first;

in hlist_add_head_rcu, which modifies obj->obj_node.next.

So, we must make sure obj->key is updated before obj->obj_node.next, =
without smp_wmb(), we can read
the new 'obj->obj_node.next=E2=80=99 value and previous value of =
'obj->key=E2=80=99 at the same time, and in this case, we
can not detect the movement of the object.

The following link might be helpful:

		=
https://patchwork.ozlabs.org/project/netdev/patch/491C282A.5050802@cosmosb=
ay.com/


>=20
> I am not an expert and would welcome the opportunity to learn more =
here.


