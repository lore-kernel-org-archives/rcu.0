Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480ADC4321E
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiK3Rj5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiK3Rj4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 12:39:56 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFCE3E0B6
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 09:39:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z1so12820940qkl.9
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RPDJxCDoUkIgI6WB0ARKRxCF6fkBTiX2FleiNgBVrQ=;
        b=Mq1xLkf1xt6I+kmhLpR2DtzpAnypfTyN3ou6twnR+T7xtEoQxXJ7pKJnx4EmmL0HXM
         jv5We2jQyWeP2jp1wo+5zbxIqEvnfpJz4gMp8C71pzzZfNlj7Q0eJ9trim9cuN+fO9S/
         go/TCERUQ2wdh3eRuE+oyQosAgo5UsHwj7SIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RPDJxCDoUkIgI6WB0ARKRxCF6fkBTiX2FleiNgBVrQ=;
        b=yAoCSKvQZ32elZvkH3dpiQzpIBxQCjf+20ld7JOef7/uPSHRUOHhzPnnYaKk1KGxjS
         3RG6xBrx7xxWmRXs4H6kTAWdZ4/fuBUQ4xUnuRi4Vr9eHD3auBiMH7B7oF/Q6HcxIPwZ
         TwNcybkfzEs1p3xAcLO+1pjHrxAWyiQ3NuR75zOZ09MVqL/ENWkjEiV8LpqMnmIkx7Yy
         Y4Vk3UIQ7PFOjO+oJWAnBnC1f4Ml1Zw2+b+XfgXOBfemyENQh6y9L9CoeIfSZVlC6ySN
         LMK+X3l7X8b3hzAF64kv6HtBuwK7XekI1bBxUv6Ok2UdXuGB8Oi+mKCpCQLfVFyTXZVk
         40xQ==
X-Gm-Message-State: ANoB5plRkxyMmYHzdBUPxcT/Le6TlZLStIr+QdpbiM9yOvV1gby6Z1/2
        9rChzZvrWm5NbD2jPVxDtXNBUA==
X-Google-Smtp-Source: AA0mqf6m5wgiYoWQmyYLbBA+MIkxkNl3itCOS9alR7axmaR3lQ7bmo47DoLMoNaOihNrLIFmkpjM+A==
X-Received: by 2002:a05:620a:14a3:b0:6ce:df33:d684 with SMTP id x3-20020a05620a14a300b006cedf33d684mr38528983qkj.544.1669829994930;
        Wed, 30 Nov 2022 09:39:54 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id i10-20020ac813ca000000b0039cb59f00fcsm1184876qtj.30.2022.11.30.09.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:39:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] srcu: switch work func to allow concurrent gp
Date:   Wed, 30 Nov 2022 12:39:53 -0500
Message-Id: <0B944225-3E93-494D-A297-1B330735D44F@joelfernandes.org>
References: <Y4eKl2fCNDX2ka1g@boqun-archlinux>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
In-Reply-To: <Y4eKl2fCNDX2ka1g@boqun-archlinux>
To:     Boqun Feng <boqun.feng@gmail.com>
X-Mailer: iPhone Mail (19G82)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Nov 30, 2022, at 11:55 AM, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
>> ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
>> to advance as soon as possible. But according to the implement of
>> workqueue, the same work_struct is serialized and can not run
>> concurrently in fact.
>>=20
>> Quoting from Documentation/core-api/workqueue.rst
>> "
>> Non-reentrance Conditions
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>=20
>> Workqueue guarantees that a work item cannot be re-entrant if the followi=
ng
>> conditions hold after a work item gets queued:
>>=20
>>        1. The work function hasn't been changed.
>>        2. No one queues the work item to another workqueue.
>>        3. The work item hasn't been reinitiated.
>> "
>>=20
>> To allow the concurrence to some extent, it can be achieved by changing
>> the work function to break the conditions. As a result, when
>> srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
>>=20
>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>> To: rcu@vger.kernel.org
>> ---
>> kernel/rcu/srcutree.c | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>=20
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 1c304fec89c0..56dd9bb2c8b8 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
>> static void srcu_invoke_callbacks(struct work_struct *work);
>> static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)=
;
>> static void process_srcu(struct work_struct *work);
>> +static void process_srcu_wrap(struct work_struct *work);
>> static void srcu_delay_timer(struct timer_list *t);
>>=20
>> /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(=
). */
>> @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>        cbdelay =3D 0;
>>=20
>>    WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>> +    /* Change work func so work can be concurrent */
>> +    if (ssp->work.work.func =3D=3D process_srcu_wrap)
>> +        ssp->work.work.func =3D process_srcu;
>> +    else
>> +        ssp->work.work.func =3D process_srcu_wrap;
>=20
> This looks really hacky ;-) It would be good that workqueue has an API
> to allow "resetting" a work.
>=20
> Do you have any number of the potential performance improvement?


Agreed. Another question - have you verified the workqueue behavior after th=
is change (say using tracing), regardless of what the workqueue documentatio=
n says?

Thanks,

- Joel=20



>=20
> Regards,
> Boqun
>=20
>>    rcu_seq_end(&ssp->srcu_gp_seq);
>>    gpseq =3D rcu_seq_current(&ssp->srcu_gp_seq);
>>    if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
>> @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)=

>>    srcu_reschedule(ssp, curdelay);
>> }
>>=20
>> +/*
>> + * The ssp->work is expected to be concurrent to some extent, but the cu=
rrent
>> + * workqueue does not support the concurrence on the same work. (Refer t=
o the
>> + * section "Non-reentrance Conditions" in the file workqueue.rst)
>> + * Resolving it by changing the work func.
>> + *
>> + * Prevent compilering from optimizing out it.
>> + */
>> +static __used void process_srcu_wrap(struct work_struct *work)
>> +{
>> +    process_srcu(work);
>> +}
>> +
>> void srcutorture_get_gp_data(enum rcutorture_type test_type,
>>                 struct srcu_struct *ssp, int *flags,
>>                 unsigned long *gp_seq)
>> --=20
>> 2.31.1
>>=20
