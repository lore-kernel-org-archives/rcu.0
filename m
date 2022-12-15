Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E8C4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLOVm3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLOVm2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Dec 2022 16:42:28 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2781CFEC
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 13:42:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u10so377249qvp.4
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyAul30Dlo0Qi+nZ6ABNWPasZot+uvnehOd4uveE51s=;
        b=H+NwbDuKB8t7a45P51soZAPjRShYDJZObTcUg6/L9Y1QhFZqDsFY8MiCfqy11zQsKS
         slt8mdd2YftNZ3pudujwwF/CDoDew3Z9NtvwZD1jAINu0ldUOv/6AD3yf3PVTDd9aase
         A7ni6Bb+TW+6/haELJtEdkc/oVqoeJVwA2IwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyAul30Dlo0Qi+nZ6ABNWPasZot+uvnehOd4uveE51s=;
        b=Dmnd+2SOK7lQqo388SconrBkT9tj4F/DXUWB+o1llnSnNLuvdJlj1BBQC5MktIrAuB
         CztjGegKlePCVTZwoDxc54X3635mQPphO9C+aTW9kwmhU/aNWK1tKMJWDGABaPyraboO
         C1+2wdih2aEN0g1KmWcITSEZ/oLM1rl3gF5+caNhBdaGV29bhm48hlyTNe/hekbY6GXQ
         CfIGouEQ6SPl9PoAH5gssde2A9U3bgP3NWs0r0ShYJcgYMH1AFPXxF04VD/Q5OVffCED
         2sNQva8Rc5rcGVdMGmslchmfarMwupHj687zAYrzGZy3JnI1bgLL3+Igdf03fCnivSVY
         ag6Q==
X-Gm-Message-State: ANoB5pkOTtsF+eSvFXDMg6zZA947xImYszLuJFM46UTr/+f/J29PZfHm
        KS6Cf/fMtZCBtRQUNBgFwcBzWg==
X-Google-Smtp-Source: AA0mqf4fuiqcqjjGtJ4rS+jP/30QgZUorBODzGY2oEGCOwIvpJ9BokPpw0JVW3/Bf2XI6vOxOH4bqQ==
X-Received: by 2002:a05:6214:390a:b0:4c9:8d2e:33d1 with SMTP id nh10-20020a056214390a00b004c98d2e33d1mr43329402qvb.35.1671140546920;
        Thu, 15 Dec 2022 13:42:26 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u25-20020a37ab19000000b006feea093006sm15711qke.124.2022.12.15.13.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 13:42:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Thu, 15 Dec 2022 16:42:15 -0500
Message-Id: <8E05ED42-A391-48D3-97B3-FBD667E72D10@joelfernandes.org>
References: <20221215213900.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221215213900.GQ4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 15, 2022, at 4:39 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 15, 2022 at 03:33:39PM -0500, Joel Fernandes wrote:
>>> On Thu, Dec 15, 2022 at 3:03 PM Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>=20
>>> Hi Paul,
>>>=20
>>>> On Thu, Dec 15, 2022 at 2:58 PM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>> [...]
>>>>> If the first read section's srcu_read_unlock() and its corresponding
>>>>> smp_mb()  happened before the flip, then the increment of old idx
>>>>> would happen only once. The next srcu_read_lock() will read the new
>>>>> index. If the srcu_read_unlock() and it's corresponding smp_mb()
>>>>> happened after the flip, the old_idx will be sampled again and can be
>>>>> incremented twice. So it depends on how the flip races with
>>>>> srcu_read_unlock().
>>>>=20
>>>> I do understand that a number of people like reasoning about
>>>> memory-barrier ordering, courtesy of the sequentially consistent portio=
ns
>>>> of the C and C++ memory models, but thinking in terms of the accesses
>>>> surrounding the memory barriers has been far less error-prone.
>>>=20
>>> Sure, but we are already talking in terms of the access to idx right?
>>> That's what we're saying is visible by memory barriers and we are
>>> trying to reason here about the ordering (flip does the write to idx
>>> and followed by smp_mb(), and there is corresponding read of idx on
>>> the srcu_read_lock() side. So we are indeed talking in terms of
>>> access, but let me know if I missed something.
>>>=20
>>>>> Also, since this is all hard to reason about I started making some
>>>>> diagrams, LOL. For your amusement, here is why need to scan both idx
>>>>> during grace period detection: https://i.imgur.com/jz4bNKd.png
>>>>=20
>>>> Nice!
>>>>=20
>>>> I suggest placing a gap between GP 2 and GP 3.  That way, you can make i=
t
>>>> very clear that Reader 1's critical section starts after the end of GP 2=

>>>> (thus clearly never blocking GP 2) and before GP 3 (thus possibly havin=
g
>>>> a reference to some data that is going to be freed at the end of GP 3).=

>>>>=20
>>>> I also suggest coloring Reader 1 red and Reader 2 green, given that the=

>>>> color red generally indicates danger.
>>>=20
>>> Thanks for these suggestions! I will make the update. I am planning to
>>> make a number of diagrams for other scenarios as well, as it helps
>>> visualize. Google drawing is nice for these. I am happy to share these
>>> with you all if there is interest :).
>>=20
>> I made these updates, please see: https://i.imgur.com/hoKLvtt.png
>>=20
>> Feel free to use the image for any purpose and thanks ;-)
>=20
> Very good, thank you!
>=20
> Would it be possible to have an arrow marked "X" or "reference to X"
> from the beginning of the 'Mark "x" for GC' box to the box labeled
> 'Enter RSCS (access "X")'?

I am currently away from desk. I shared the google drawing with you. Could y=
ou check and make the change, if that=E2=80=99s ok with you?

Thank you so much,

 - Joel

>=20
>                            Thanx, Paul
