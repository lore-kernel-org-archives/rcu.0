Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50787C83F12
	for <rcu@archiver.kernel.org>; Mon, 28 Aug 2023 21:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjH1Vvh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjH1VvZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Aug 2023 17:51:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363DF9
        for <rcu@vger.kernel.org>; Mon, 28 Aug 2023 14:51:22 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76dc7b0da9fso211479185a.1
        for <rcu@vger.kernel.org>; Mon, 28 Aug 2023 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693259482; x=1693864282;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIqTNAjPY+VUAW068eZyQLaVcp03kXm2oJePXL8lR2M=;
        b=wJ9jthLeE7iqKkgn1gR4y/Yy5/VpVlUYX4w22c6E/sQJpl1dtuZUbkjV+x8YaBt2y0
         R/Pcx0Hp+aLdoEbs9VkCPii1d1Vabx0f+GC+uaQSr8jVb+1uIz+12D2yzx93XSp+n73x
         /ok191HfnJ9KwctVq/RbcGRzrhwQOU+t/FbCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693259482; x=1693864282;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIqTNAjPY+VUAW068eZyQLaVcp03kXm2oJePXL8lR2M=;
        b=VTFdTmYDrE4Jg+qKX1Zivr5KAZwRXgLIIcpj3PcCUPLbf5YQN1PoibrwBn9QTf+9da
         qXMZapkJOKrY/qoOo4Wn+G7a7y3Fj1coxjF5BcEjhYGouAUZMh09+vytkd60RXzTZ4Nd
         uvqbflTRxKWgBvkmuPvHyCd56oWj2iddu5QMUwBPG/FcxmS+jCNFClvkhyBKnhSHqDJL
         bhIpCxl1FgJSRZ0uG4q5NG/MiXwzp+UjSS6Lu0Aj4kRdNlgNWxzd6QzDCiDdqYp/B/nQ
         SkFS7XM0WMxBbKx6Q2qrM+ANf2NN3YonFdxPUQcj1f8ttO2HiqaFoc2dSGHJVl75rz0h
         R+RQ==
X-Gm-Message-State: AOJu0YyFJLE0bChYiai/TXdZ4+gggeM6FWujdoz0b8ydt+WfbOGFa2vs
        vEehU8yK70NImKeGArLTeMdnkA==
X-Google-Smtp-Source: AGHT+IEYyt30w6LDneVAxBk4QX8458Yg5unSYCV7cmDLaEknIzlk1isDcR+TLgYJrzjU3hJ6oHOtww==
X-Received: by 2002:a05:620a:11b6:b0:76f:4:c9ed with SMTP id c22-20020a05620a11b600b0076f0004c9edmr7491659qkk.40.1693259481736;
        Mon, 28 Aug 2023 14:51:21 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.224])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b00767c961eb47sm2557927qki.43.2023.08.28.14.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 14:51:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Mon, 28 Aug 2023 17:51:09 -0400
Message-Id: <16F11103-75C4-4DCE-8272-D619ECAA96BD@joelfernandes.org>
References: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Aug 28, 2023, at 11:17 AM, Frederic Weisbecker <frederic@kernel.org> wr=
ote:
>=20
> =EF=BB=BFLe Sat, Aug 26, 2023 at 06:06:20AM -0700, Paul E. McKenney a =C3=A9=
crit :
>> On Sat, Aug 26, 2023 at 02:13:39PM +0800, Z qiang wrote:
>>>>=20
>>>> On Fri, Aug 25, 2023 at 10:28:37AM +0800, Z qiang wrote:
>>>>>>=20
>>>>>>> On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
>>>>>>>> Currently, the maxcpu is set by traversing online CPUs, however, if=

>>>>>>>> the rcutorture.onoff_holdoff is set zero and onoff_interval is set
>>>>>>>> non-zero, and the some CPUs with larger cpuid has been offline befo=
re
>>>>>>>> setting maxcpu, for these CPUs, even if they are online again, also=

>>>>>>>> cannot be offload or deoffload.
>>>>>>>>=20
>>>>>>>> This commit therefore use for_each_possible_cpu() instead of
>>>>>>>> for_each_online_cpu() in rcu_nocb_toggle().
>>>>>>>>=20
>>>>>>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>>>>>>>> ---
>>>>>>>> kernel/rcu/rcutorture.c | 2 +-
>>>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>=20
>>>>>>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>>>>>>> index a58372bdf0c1..b75d0fe558ce 100644
>>>>>>>> --- a/kernel/rcu/rcutorture.c
>>>>>>>> +++ b/kernel/rcu/rcutorture.c
>>>>>>>> @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
>>>>>>>>      VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
>>>>>>>>      while (!rcu_inkernel_boot_has_ended())
>>>>>>>>              schedule_timeout_interruptible(HZ / 10);
>>>>>>>> -     for_each_online_cpu(cpu)
>>>>>>>> +     for_each_possible_cpu(cpu)
>>>>>>>=20
>>>>>>> Last I checked, bad things could happen if the code attempted to
>>>>>>> nocb_toggle a CPU that had not yet come online.  Has that changed?
>>>>>>=20
>>>>>> For example, there are 8 online CPUs in the system, before we travers=
ing online
>>>>>> CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss n=
ocb_toggle
>>>>>> for CPU7(maxcpu=3D6)
>>>>>>=20
>>>>>> Even though we still use for_each_online_cpu(), the things described
>>>>>> above also happen.  before we toggle the CPU, this CPU has been offli=
ne.
>>>>>=20
>>>>> Suppose we have a system whose possible CPUs are 0, 1, 2, and 3.  Howe=
ver,
>>>>> only 0 and 1 are present in this system, and until some manual action i=
s
>>>>> taken, only 0 and 1 will ever be online.  (Yes, this really can happen=
!)
>>>>> In that state, won't toggling CPU 2 and 3 result in failures?
>>>>>=20
>>>=20
>>> Agree.
>>> As long as we enabled rcutorture.onoff_interval,  regardless of whether w=
e use
>>> online CPUs or possible CPUs to set maxcpu,  It is all possible to
>>> toggling the CPUs failure
>>> and print "NOCB: Cannot CB-offload offline CPU" log. but the failures
>>> due to CPU offline are acceptable.
>>>=20
>>> but at least the toggling operation on CPU7 will not be missed. when
>>> CPU7 comes online again.
>>>=20
>>> Would it be better to use for_each_present_cpu() ?
>>=20
>> The problem we face is that RCU and rcutorture have no reasonable way
>> of knowing when the boot-time CPU bringup has completed.  If there was a
>> way of knowing that, then my approach would be to make rcutorture react
>> to a holdoff of zero by waiting for all the CPUs to come online.
>>=20
>> Failing that, for_each_present_cpu() with a holdoff of zero will likely
>> get us transient failures between the time rcutorture starts and the
>> last CPU has come online.
>>=20
>> Or is there now a way for in-kernel code know when boot-time CPU onlining=

>> has completed?
>=20
> We don't need to wait for all CPUs to be online though. Toggling
> already handles well failures due to offline CPUs and since toggling
> happens concurrently with offlining in rcutorture, we already see lots
> of failures reported in the logs.

I think the issue is the loop later in the function does
not try to toggle cpus that came online too late.

So it does not test offloading on all CPUs just because max got updated too l=
ate.

One fix could be to periodically check in the loop if a new cpu at maxcpu + 1=

ever got onlined. If it did, update the maxcpu.

Thanks.


>=20
> Thanks.
