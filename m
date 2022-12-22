Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D8C4332F
	for <rcu@archiver.kernel.org>; Thu, 22 Dec 2022 13:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiLVNDz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Dec 2022 08:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiLVNDx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Dec 2022 08:03:53 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC9E03D
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 05:03:52 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-14449b7814bso2421614fac.3
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwiWTzqj/URiG9KMNln406wHiUZ0+55hkaim2A7PwtI=;
        b=ksc+2ycceyZRNMINddimECSkdYNk4QYerO+V+S7kuT9l4VcYVCqWcnlESUtlevuKqa
         TtFn7KRMypVq/iqBABDHk2TttAo4YZYK0lyWXSiOFP42TSzc6LTyD4p6VRe0WWfaaiyt
         OHEFBeACtKbFXKj6TTacUSQmZRgXpMGSGyv84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwiWTzqj/URiG9KMNln406wHiUZ0+55hkaim2A7PwtI=;
        b=CDxhFg8Fc+VXR17v119XXfxl6o/Oh8h+zwGxahHjJxdZ65Q7B9NDyv3FyNBOL9zXIR
         S5c51fI6uRr2RExsTn/EOyQ1XpRy3UoUitnZv2cmMPfUlE6V0thE1F1i/wlZH2wqB4P/
         eXlUtHFhDC+KROOl0AjnHHRhn6lwQfX3PNv2gWR8qYS86YjHii/2fNf493zR9TSO+Vkm
         mCFPCMveQJ4pIMG8F6RPlEBmTw45ozKLnFpTqzKT5ij0wFzuqJ8DkT26bCuuqHIA66yx
         3UoadXxPALQQDN5NZCBV2gJBWgPhq+M2SQXBWKboUsLe0vPGtfx3Jzgh+MFtqNpPGA7o
         vsrQ==
X-Gm-Message-State: AFqh2kphwfN2ScmZeI3nevILEaIfoMZZ/1xxe6DzO6vVNuHpGvEa9vqX
        hScMPV8w5ITC20ftrKUMCNHFCw==
X-Google-Smtp-Source: AMrXdXt1cSwyp5GlfCxdEjLJ8EHu/Z203zZ65bKIIP378oVp0b1t4E8IStddkVRFgI7zkB0bbElfZQ==
X-Received: by 2002:a05:6871:281:b0:144:d1f4:96de with SMTP id i1-20020a056871028100b00144d1f496demr3296560oae.36.1671714231163;
        Thu, 22 Dec 2022 05:03:51 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a430900b006fba44843a5sm264433qko.52.2022.12.22.05.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 05:03:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] srcu: Remove memory barrier "E" as it does not do anything
Date:   Thu, 22 Dec 2022 08:03:39 -0500
Message-Id: <19A03A16-9F38-481F-824D-4C883AB8B105@joelfernandes.org>
References: <20221222120319.GA44533@lothringen>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, neeraj.iitr10@gmail.com
In-Reply-To: <20221222120319.GA44533@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 22, 2022, at 7:03 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Thu, Dec 22, 2022 at 12:20:11AM +0000, Joel Fernandes (Google)=
 wrote:
>> During a flip, we have a full memory barrier before srcu_idx is increment=
ed.
>>=20
>> The idea is we intend to order the first phase scan's read of lock
>> counters with the flipping of the index.
>>=20
>> However, such ordering is already enforced because of the
>> control-dependency between the 2 scans. We would be flipping the index
>> only if lock and unlock counts matched.
>>=20
>> But such match will not happen if there was a pending reader before the f=
lip
>> in the first place (observation courtesy Mathieu Desnoyers).
>>=20
>> The litmus test below shows this:
>> (test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):
>>=20
>> C srcu
>>=20
>> {}
>>=20
>> // updater
>> P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
>> {
>>        int lock1;
>>        int unlock1;
>>        int lock0;
>>        int unlock0;
>>=20
>>        // SCAN1
>>        unlock1 =3D READ_ONCE(*UNLOCK1);
>>        smp_mb(); // A
>>        lock1 =3D READ_ONCE(*LOCK1);
>>=20
>>        // FLIP
>>        if (lock1 =3D=3D unlock1) {         // Control dep
>>                smp_mb(); // E
>>                WRITE_ONCE(*IDX, 1);
>>                smp_mb(); // D
>>=20
>>                // SCAN2
>>                unlock0 =3D READ_ONCE(*UNLOCK0);
>>                smp_mb(); // A
>>                lock0 =3D READ_ONCE(*LOCK0);
>>        }
>> }
>>=20
>> // reader
>> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
>> {
>>        int tmp;
>>        int idx1;
>>        int idx2;
>>=20
>>        // 1st reader
>>        idx1 =3D READ_ONCE(*IDX);
>>        if (idx1 =3D=3D 0) {
>>                tmp =3D READ_ONCE(*LOCK0);
>>                WRITE_ONCE(*LOCK0, tmp + 1);
>>                smp_mb(); /* B and C */
>>                tmp =3D READ_ONCE(*UNLOCK0);
>>                WRITE_ONCE(*UNLOCK0, tmp + 1);
>>        } else {
>>                tmp =3D READ_ONCE(*LOCK1);
>>                WRITE_ONCE(*LOCK1, tmp + 1);
>>                smp_mb(); /* B and C */
>>                tmp =3D READ_ONCE(*UNLOCK1);
>>                WRITE_ONCE(*UNLOCK1, tmp + 1);
>>        }
>>=20
>>        // second reader
>>        idx2 =3D READ_ONCE(*IDX);
>>        if (idx2 =3D=3D 0) {
>>                tmp =3D READ_ONCE(*LOCK0);
>>                WRITE_ONCE(*LOCK0, tmp + 1);
>>                smp_mb(); /* B and C */
>>                tmp =3D READ_ONCE(*UNLOCK0);
>>                WRITE_ONCE(*UNLOCK0, tmp + 1);
>>        } else {
>>                tmp =3D READ_ONCE(*LOCK1);
>>                WRITE_ONCE(*LOCK1, tmp + 1);
>>                smp_mb(); /* B and C */
>>                tmp =3D READ_ONCE(*UNLOCK1);
>>                WRITE_ONCE(*UNLOCK1, tmp + 1);
>>        }
>> }
>>=20
>> The following bad condition will not occur even if memory barrier E
>> is dropped:
>>=20
>> (* bad condition: SCAN1 saw lock count changes though 1st reader saw flip=
 *)
>> exists (0:lock1=3D1 /\ 1:idx1=3D1 /\ 1:idx2=3D1)
>=20
> Good catch!
>=20
> The litmus test can be shorten with removing the second reader and limit t=
he
> exists clause to 0:lock1=3D1 :

Yes. Made the change and that works too.

>=20
> ---
> C srcu-E
>=20
> {}
>=20
> // updater
> P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>    int lock1;
>    int unlock1;
>    int lock0;
>    int unlock0;
>=20
>    // SCAN1
>    unlock1 =3D READ_ONCE(*UNLOCK1);
>    smp_mb(); // A
>    lock1 =3D READ_ONCE(*LOCK1);
>=20
>    // FLIP
>    if (lock1 =3D=3D unlock1) {         // Control dep
>        WRITE_ONCE(*IDX, 1);
>        smp_mb(); // D
>=20
>        // SCAN2
>        unlock0 =3D READ_ONCE(*UNLOCK0);
>        smp_mb(); // A
>        lock0 =3D READ_ONCE(*LOCK0);
>    }
> }
>=20
> // reader
> P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
> {
>    int tmp;
>    int idx1;
>    int idx2;
>=20
>    // 1st reader
>    idx1 =3D READ_ONCE(*IDX);
>    if (idx1 =3D=3D 0) {
>        tmp =3D READ_ONCE(*LOCK0);
>        WRITE_ONCE(*LOCK0, tmp + 1);
>        smp_mb(); /* B and C */
>        tmp =3D READ_ONCE(*UNLOCK0);
>        WRITE_ONCE(*UNLOCK0, tmp + 1);
>    } else {
>        tmp =3D READ_ONCE(*LOCK1);
>        WRITE_ONCE(*LOCK1, tmp + 1);
>        smp_mb(); /* B and C */
>        tmp =3D READ_ONCE(*UNLOCK1);
>        WRITE_ONCE(*UNLOCK1, tmp + 1);
>    }
> }
> exists (0:lock1=3D1) (* only happens if the control dep is removed *)
> --
>=20
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 1c304fec89c0..d1368d64fdba 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -983,15 +983,9 @@ static bool try_check_zero(struct srcu_struct *ssp, i=
nt idx, int trycount)
>> static void srcu_flip(struct srcu_struct *ssp)
>> {
>>    /*
>> -     * Ensure that if this updater saw a given reader's increment
>> -     * from __srcu_read_lock(), that reader was using an old value
>> -     * of ->srcu_idx.  Also ensure that if a given reader sees the
>> -     * new value of ->srcu_idx, this updater's earlier scans cannot
>> -     * have seen that reader's increments (which is OK, because this
>> -     * grace period need not wait on that reader).
>> +     * Control dependency locks=3D=3Dunlocks ensures that if a reader se=
es the
>> +     * flip, previous scan would only see before-flip reader lock counts=
.
>=20
> I would personally prefer that we keep the detailed comment explaining the=

> ordering requirements here, just mentioning it's performed via control
> dependency now. This way we don't need to debate that again in 10 years.

Cool, will update the patch.

Thanks.



>=20
>=20
>>     */
>> -    smp_mb(); /* E */  /* Pairs with B and C. */
>> -
>>    WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>>=20
>>    /*
>> --=20
>> 2.39.0.314.g84b9a713c41-goog
>>=20
