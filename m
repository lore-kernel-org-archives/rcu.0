Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79BC4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiLOWOD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLOWOC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Dec 2022 17:14:02 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018024F14
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 14:13:59 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z12so1297364qtv.5
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ltjy3SFMTcDnLwxFuf0TBLx83jMpWdOeNMJlia5xDc=;
        b=nKFoDFh8DW3eXE6uQOnmps0cIDtNMJZi7moLWOOuKddQ/3r3imPsB+R87x5/y91yAy
         XsrH24E6wtV4qSrnnp0oYWTDrcHCGn91zF7X+Fbegu/WgcBA6gC7HX62Vigre2cjhJZK
         Yl4y0moK1vastlMCIGqRwAfIHxBCRsAXD5plg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ltjy3SFMTcDnLwxFuf0TBLx83jMpWdOeNMJlia5xDc=;
        b=JKwuMQsPfkNa5Asda46P3V2VCLO6UrvMuNZNdIS2KHgcxks6OArEPb80hHm2ZHj/aI
         TvIeBYCjnaYJEOocVmEIoueEvVvdxrtnwQNFaTBm31+m5h8OELxZXWalWFT3lQpsSE+/
         f3R9SFOn9qPs9bnnDUldCharnakUk98YAhhJkuGm2f8uXkMrRNNN9rZL/tDKgsM8zycG
         RWA/N96G1hNeBJpJGYAnhV9SxQ94N1SoZgDOLg5/2TrApCrc10KWAu101a+zzdmcEBD+
         8h/9Y9pLuAWG7vQnW3r5Xyhh7j0+7PA7Zj2bBbbN7DoJxaygge63lkcsM+6u/kyS6XsU
         YkkQ==
X-Gm-Message-State: ANoB5plqO+2lqqIENE6vydVKxtqimJW0g9JDBE1nDWhYyEc9FcWGiCVk
        bsAXTtzROjfkMKNuQM5fQNQJ9w==
X-Google-Smtp-Source: AA0mqf4q+o/ppFxKZbMVIufsLD3NCvtWFrVQpi/bcfiNoHEclviPxqgHT4KLgTH6kNvOa3ZudJVLyA==
X-Received: by 2002:a05:622a:6114:b0:3a7:fd82:f69b with SMTP id hg20-20020a05622a611400b003a7fd82f69bmr33904879qtb.8.1671142439043;
        Thu, 15 Dec 2022 14:13:59 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id m1-20020ac86881000000b0039a55f78792sm109972qtq.89.2022.12.15.14.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 14:13:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Thu, 15 Dec 2022 17:13:47 -0500
Message-Id: <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
References: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 15, 2022, at 3:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 15, 2022 at 05:58:14PM +0000, Joel Fernandes wrote:
>>> On Thu, Dec 15, 2022 at 5:48 PM Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>=20
>>>> On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>=20
>>>>> Scenario for the reader to increment the old idx once:
>>>>>=20
>>>>> _ Assume ssp->srcu_idx is initially 0.
>>>>> _ The READER reads idx that is 0
>>>>> _ The updater runs and flips the idx that is now 1
>>>>> _ The reader resumes with 0 as an index but on the next srcu_read_lock=
()
>>>>>  it will see the new idx which is 1
>>>>>=20
>>>>> What could be the scenario for it to increment the old idx twice?
>>>>=20
>>>> Unless I am missing something, the reader must reference the
>>>> srcu_unlock_count[old_idx] and then do smp_mb() before it will be
>>>> absolutely guaranteed of seeing the new value of ->srcu_idx.
>>>=20
>>> I think both of you are right depending on how the flip raced with the
>>> first reader's unlock in that specific task.
>>>=20
>>> If the first read section's srcu_read_unlock() and its corresponding
>>> smp_mb()  happened before the flip, then the increment of old idx
>>> would happen only once. The next srcu_read_lock() will read the new
>>> index. If the srcu_read_unlock() and it's corresponding smp_mb()
>>> happened after the flip, the old_idx will be sampled again and can be
>>> incremented twice. So it depends on how the flip races with
>>> srcu_read_unlock().
>>=20
>> I am sorry this is inverted, but my statement's gist stands I believe:
>>=20
>> 1. Flip+smp_mb() happened before unlock's smp_mb() -- reader will not
>> increment old_idx the second time.
>=20
> By "increment old_idx" you mean "increment ->srcu_lock_count[old_idx]",
> correct?

Yes sorry for confusing, i indeed meant lock count increment corresponding t=
o the old index.
>=20
> Again, the important ordering isn't the smp_mb(), but the accesses,
> in this case, the accesses to ->srcu_unlock_count[idx].

I was talking about ordering of the flip of index (write) with respect to bo=
th the reading of the old index  in the rcu_read_lock() and its subsequent l=
ock count increment corresponding to that index. I believe we are talking he=
r about how this race can effect the wrap around issues when scanning for re=
aders in the pre flip index, and we concluded that there can be at most 2 of=
 these on the SAME task. The third time, reader will always see the new flip=
ped index because of the memory barriers on both sides. IOW, the same task c=
annot overflow the lock counter on the preflipped index and cause issues. Ho=
wever there can be Nt different tasks so perhaps you can have 2*Nt number of=
 preempted readers that had sampled the old index and now will do a lock and=
 unlock on that old index, potentially causing a lock=3D=3Dunlock match when=
 there should not be a match.

>=20
>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
>> has no new smp_mb() that happens AFTER the flip happened. So it can
>> totally sample the old idx again -- that particular reader will
>> increment twice, but the next time, it will see the flipped one.
>=20
> I will let you transliterate both.  ;-)

I think I see what you mean now :)

I believe the access I am referring to is the read of idx on one side and th=
e write to idx on the other. However that is incomplete and I need to pair t=
hat with some of other access on both sides.

So perhaps this:

Writer does flip + smp_mb + read unlock counts [1]

Reader does:
 read idx + smp_mb() + increment lock counts [2]

And subsequently reader does
Smp_mb() + increment unlock count. [3]

So [1] races with either [2] or [2]+[3].

Is that fair?

>> Did I get that right? Thanks.
>=20
> So why am I unhappy with orderings of smp_mb()?
>=20
> To see this, let's take the usual store-buffering litmus test:
>=20
>    CPU 0            CPU 1
>    WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>    smp_mb();        smp_mb();
>    r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>=20
> Suppose CPU 0's smp_mb() happens before that of CPU 1:
>=20
>    CPU 0            CPU 1
>    WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>    smp_mb();
>                smp_mb();
>    r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>=20
> We get r0 =3D=3D r1 =3D=3D 1.
>=20
> Compare this to CPU 1's smp_mb() happening before that of CPU 0:
>=20
>    CPU 0            CPU 1
>    WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>                smp_mb();
>    smp_mb();
>    r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>=20
> We still get r0 =3D=3D r1 =3D=3D 1.  Reversing the order of the two smp_mb=
()
> calls changed nothing.
>=20
> But, if we order CPU 1's write to follow CPU 0's read, then we have
> this:
>=20
>    CPU 0            CPU 1
>    WRITE_ONCE(x, 1);
>    smp_mb();
>    r0 =3D READ_ONCE(y);
>                WRITE_ONCE(y, 1);
>                smp_mb();
>                r1 =3D READ_ONCE(x);
>=20
> Here, given that r0 had the final value of zero, we know that
> r1 must have a final value of 1.
>=20
> And suppose we reverse this:
>=20
>    CPU 0            CPU 1
>                WRITE_ONCE(y, 1);
>                smp_mb();
>                r1 =3D READ_ONCE(x);
>    WRITE_ONCE(x, 1);
>    smp_mb();
>    r0 =3D READ_ONCE(y);
>=20
> Now there is a software-visible difference in behavior.  The value of
> r0 is now 1 instead of zero and the value of r1 is now 0 instead of 1.
>=20
> Does this make sense?

Yes I see what you mean. In first case, smp_mb() ordering didn=E2=80=99t mat=
ter. But in the second case it does.

Thanks,

 - Joel


>=20
>                            Thanx, Paul
