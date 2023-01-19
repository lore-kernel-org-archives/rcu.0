Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A820C38142
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 08:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjASI0l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjASI0c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 03:26:32 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807644BE8
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 00:26:30 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h21so992104qta.12
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb47sNPh7rfUFAkXxIEcmZ1M3b1o9cMWz4qnX9Oxfjc=;
        b=Z26pBOFrwNQvcDXMan64KwU9Cdljj755nvoYkFKqBhFCJ5qxohZp30USDMWXap0qTk
         OLWdQ1P3N+CbK90ArTXCu1QI1WMZTheDXPvytt8fGn2ixzvx93vuijsR9LTQaW8Nt/LT
         mIz72C5vzVYIJ3zFkK6uCUwS5/xdFON97Uwew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yb47sNPh7rfUFAkXxIEcmZ1M3b1o9cMWz4qnX9Oxfjc=;
        b=p4fWjMhwhwfWp5MI5236+taDCRqwRiyzljOviDH5Ok9iuyWo4DnEBQo5u/cdhi0Rv0
         Uqq+Jq3H4PNxnnjFsaUmujPwGjAve13eTKEygZAqVPBUkWXpSDIaKivNA4sHvNvljvcm
         0iwmYGUnCiwZVtk8IDWwTqDa7gyjyzaZPcVwofYSJwCUxzp2po1IwsgD4XwEAxJGJIzO
         ZelzAbNQqnm0nnVtnHHb+n/YJWlSU41D316KVgzdyaYLpV86SaW4K6V1eK9giPAo0L7G
         AO4oqsZE+GV9Vbm6gwZODtYbMZOV6RnC9KirsiILV3RQ3DZmk5yWxts62T7jNklITGrI
         yukA==
X-Gm-Message-State: AFqh2kogCSoww0uvNAPSr5+kUF3CrLmPcdSwfXXWZ9wg/MjxLwpr4hvo
        rdE0C0pdFeL/v4phJ3d3i1q87g==
X-Google-Smtp-Source: AMrXdXvYYR8G1yEPhDxgi5NZrdflYygydRMVmn3HUnqwzZGutMiIeGTzTDOEqFBRUJte/NYOWoPlBw==
X-Received: by 2002:ac8:6a0f:0:b0:3b6:3542:2b4 with SMTP id t15-20020ac86a0f000000b003b6354202b4mr12466894qtr.43.1674116789188;
        Thu, 19 Jan 2023 00:26:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006fcb77f3bd6sm23974195qkp.98.2023.01.19.00.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 00:26:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Date:   Thu, 19 Jan 2023 03:26:16 -0500
Message-Id: <72EAFF5B-CE11-4672-BBFF-48B0E8A7F70D@joelfernandes.org>
References: <CAABZP2xq5tCbXiOaH92X1F885FANX70p=H0nHg5P7BkjcYy+yQ@mail.gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <CAABZP2xq5tCbXiOaH92X1F885FANX70p=H0nHg5P7BkjcYy+yQ@mail.gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 18, 2023, at 10:21 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 19, 2023 at 6:39 AM Joel Fernandes <joel@joelfernande=
s.org> wrote:
>>=20
>>> On Wed, Jan 18, 2023 at 10:37 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>=20
>>>> On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
>>> [...]
>>>>>>>> Is there a plan to make CPU hotplug failures more frequent?
>>>>>>>=20
>>>>>>> I am not aware of such a plan but I was going by "There are quite so=
me
>>>>>>> reasons why a CPU-hotplug or a hot-unplug operation can fail, which i=
s
>>>>>>> not a fatal problem, really." in [1].
>>>>>>>=20
>>>>>>> What about an rcutorture to skip hotplug for a certain cpu id,
>>>>>>> rcutorture.skip_hotplug_cpus=3D"0". Can be a last resort. But we/I
>>>>>>> should debug this issue more before getting to that.
>>>>>>=20
>>>>>> Yes, in fact there already are some checks along those lines, for exa=
mple,
>>>>>> the torture_offline() function's check of cpu_is_hotpluggable().  So f=
or
>>>>>> example, as I understand it, a CONFIG_NO_HZ_FULL=3Dy system should ma=
rk
>>>>>> the housekeeping CPU as !cpu_is_hotpluggable().
>>>>>=20
>>>>> I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
>>>>> not seeing it). Even on x86, if you enable
>>>>> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy , and CONFIG_NO_HZ_FULL=3Dy, and run=

>>>>> rcutorture with boot args:
>>>>>=20
>>>>> nohz_full=3D0-3 rcutorture.onoff_interval=3D100 rcutorture.onoff_holdo=
ff=3D2
>>>>> rcutorture.shutdown_secs=3D30
>>>>>=20
>>>>> You will see this in the kernel logs:
>>>>> [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno=
 -16
>>>>> [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno=
 -16
>>>>>=20
>>>>> So RCU torture test clearly thought the CPUs were hot-pluggable, when
>>>>> they was chance for them to return -EBUSY (due to housekeeping and
>>>>> what not). So this issue seems to be architecture independent, in that=

>>>>> sense.
>>>>>=20
>>>>> So the 2 ways forward I see are:
>>>>> - Make the torture test aware of which CPUs are 'house keeping'
>>>>> - Make it possible to turn off CPU0 hotplugging on ARM64 by default
>>>>> (via CONFIG or boot option).
>>>>>=20
>>>>> Another option could be, forgive -EBUSY on CPU0 for
>>>>> CONFIG_NO_HZ_FULL=3Dy.  Is it possible to assign a non-0 CPU id as a
>>>>> housekeeping CPU?
>>>>=20
>>>> I would be happier to forgive failure to offline housekeeping CPUs than=

>>>> blanket forgiveness of CPU 0.  Especially given that I recently got
>>>> burned by a non-zero boot cpu.  ;-)
>>>>=20
>>>> But wouldn't it be even better for cpu_is_hotpluggable() to know the
>>>> NO_HZ_FULL rules of the road?
>>>=20
>>> That's a great idea. I found a way to do that without having to do the
>>> EXPORT_SYMBOL (like in Zhouyi's patch).
>>>=20
>>> Would the following be acceptable (only build-tested)?
>>>=20
>>> I can run more tests and submit a patch:
>>>=20
>>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>>> index 55405ebf23ab..f73bc520b70e 100644
>>> --- a/drivers/base/cpu.c
>>> +++ b/drivers/base/cpu.c
>>> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_g=
roups[] =3D {
>>> bool cpu_is_hotpluggable(unsigned int cpu)
>>> {
>>>        struct device *dev =3D get_cpu_device(cpu);
>>> -       return dev && container_of(dev, struct cpu, dev)->hotpluggable;
>>> +       return dev && container_of(dev, struct cpu, dev)->hotpluggable
>>> +               && !tick_nohz_cpu_hotpluggable(cpu);
>>=20
>> Oops, I should lose that "!" , but otherwise should be ok.
> Looks plausible to me, According to your fantastic fix, I will perform
> a new round of tests on the PPC VM of open source Lab of Oregon State
> University.

Thank you! And if it passes, I will add your Tested-by tag for attribution i=
f you do not mind.

> I learned a lot during this process

Cool!!

 - Joel


>=20
> Thanks
> Zhouyi
