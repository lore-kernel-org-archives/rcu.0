Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07195C4167B
	for <rcu@archiver.kernel.org>; Fri, 30 Dec 2022 13:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiL3NSP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 08:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3NSO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 08:18:14 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BCC1A23D
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 05:18:12 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id jr11so17125947qtb.7
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNKbJyWVmEQaBKNSqhwilGGI/lpzT6OeBLkHWXd9xzQ=;
        b=blObeyR8hkigKkNKFmBpe6p7JTzjTLkpLrtG55HhKKga4rwSs3vLaiQwqLXt8GUtvh
         kT7uGaoToyNYB3CulzYCYSsoQzZokwqgZgZnZ8jLEGKGbJYGYM5AyH3omXxX8C2SvWSi
         DE6zd78UKHLpAnbSYqm8OUflTK21HD1o/lPsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNKbJyWVmEQaBKNSqhwilGGI/lpzT6OeBLkHWXd9xzQ=;
        b=pbPJjHPLdiiSteS+puMVvoSXadSzsviXHBEcHYvKqmnamSoDGyBhQUV/ZwxGSLKkJR
         CSrtDCXud7tY/1zDee2zYz06nodFTnysY3dNK1E5rtz+AL4+iprmXUhZ0vStfbiOl2zY
         3bsxe+pB9siPUPBkp5UnpTncaZQ8gqNXF6BZTfvVe3e0bes92yoAIgQxrP9CdNkJOhq2
         nL8ljvOhSJtj7ezYtyBKKNHkRXrTpmb37rfsk3Y6SGZVaTpzqZBI1vv0EgHcCXsJSLSr
         bJhIKSZDDrkH7rA66VPizOgdVLllCMbYZ6NlCSCiQhyelX3qHj5Wdw4zliAtu80G7OMc
         1iZQ==
X-Gm-Message-State: AFqh2kobPS0QxygmsKYquWNylpEJqvPWfn82ZB3mmkvlEwXO5/tydKyy
        kMPSgMpy6+q4A6KLs5pEFSUtJg==
X-Google-Smtp-Source: AMrXdXuvs7jo6hCfe2Sf2NNwK+HsB9uXbGW1q4VXHzebXGl2vmjh6T+YWCM9rjqMyXWZpIdpfaKNiw==
X-Received: by 2002:a05:622a:1f09:b0:3a7:eb01:5dde with SMTP id ca9-20020a05622a1f0900b003a7eb015ddemr37252938qtb.14.1672406291973;
        Fri, 30 Dec 2022 05:18:11 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id a20-20020ac87214000000b003a57eb7f212sm12891916qtp.10.2022.12.30.05.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 05:18:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] Catch dwmw2's deadlock
Date:   Fri, 30 Dec 2022 08:18:00 -0500
Message-Id: <54057376-2A57-4D8B-B05D-DE768F506819@joelfernandes.org>
References: <122f38e724aae9ae8ab474233da1ba19760c20d2.camel@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <122f38e724aae9ae8ab474233da1ba19760c20d2.camel@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 30, 2022, at 7:28 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> =EF=BB=BFOn Fri, 2022-12-30 at 11:38 +0000, Matthew Wilcox wrote:
>>=20
>> <dwmw2> why doesn't lockdep catch us calling synchronize_srcu() with
>>    a lock held, and elsewhere obtaining that lock within an srcu critical=

>>    region ("read lock") ?
>>=20
>> Because synchronize_srcu() doesn't acquire the lock, merely checks that
>> it isn't held.
>>=20
>> Would this work?  Not even compile tested.
>>=20
>> You can put my SoB on this if it works.
>>=20
>=20
> Thanks. Not sure if this addresses the issue I was talking about.
>=20
> There exists a completely unrelated mutex, let's call it kvm->lock.
>=20
> One code path *holds* kvm->lock while calling synchronize_srcu().
> Another code path is in a read-side section and attempts to obtain the
> same kvm->lock.
>=20
> Described here:
>=20
> https://lore.kernel.org/kvm/20221229211737.138861-1-mhal@rbox.co/T/#m594c1=
068d7a659f0a1aab3b64b0903836919bb0a

I think the patch from Matthew Wilcox will address it because the read side s=
ection already acquires the dep_map. So lockdep subsystem should be able to n=
ail the dependency. One comment on that below:

>=20
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index ca4b5dcec675..e9c2ab8369c0 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -1267,11 +1267,11 @@ static void __synchronize_srcu(struct srcu_struct=
 *ssp, bool do_norm)
>>  {
>>         struct rcu_synchronize rcu;
>> =20
>> -       RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
>> -                        lock_is_held(&rcu_bh_lock_map) ||
>> +       rcu_lock_acquire(&ssp->dep_map);
>> +       RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
>>                          lock_is_held(&rcu_lock_map) ||
>>                          lock_is_held(&rcu_sched_lock_map),
>> -                        "Illegal synchronize_srcu() in same-type SRCU (o=
r in RCU) read-side critical section");
>> +                        "Illegal synchronize_srcu() in RCU read-side cri=
tical section");
>> =20
>>         if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>>                 return;

Should you not release here?

Thanks,

- Joel=20


>> @@ -1282,6 +1282,7 @@ static void __synchronize_srcu(struct srcu_struct *=
ssp, bool do_norm)
>>         __call_srcu(ssp, &rcu.head, wakeme_after_rcu, do_norm);
>>         wait_for_completion(&rcu.completion);
>>         destroy_rcu_head_on_stack(&rcu.head);
>> +       rcu_lock_release(&ssp->dep_map);
>> =20
>>         /*
>>          * Make sure that later code is ordered after the SRCU grace
>=20
