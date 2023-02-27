Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1273BC64ED8
	for <rcu@archiver.kernel.org>; Mon, 27 Feb 2023 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjB0S1f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Feb 2023 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0S1e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Feb 2023 13:27:34 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9E911147
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 10:27:33 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d7so7665983qtr.12
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnu/A3lo00CkYnu7J1Nmm/m+KVr4M/Hyu3oSaSIMHfM=;
        b=BtUKLU7u+7WkjyTaPxfeGnnGg+47iyKRUsIyEF+RWC2vjSeQLyTmgI93CKjTQ00l1u
         QOuSKe3o7g/X/GwMBxs1UpAvgzbnf2mzJ/+dvxdQduzUv2qkPnoZZtgP8DeQArJ+5usR
         dEHHgj0cQKNUcIFkSCgNelp0KXKnGKXAmIbG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnu/A3lo00CkYnu7J1Nmm/m+KVr4M/Hyu3oSaSIMHfM=;
        b=B+azMr5zC0mhMVJLxfijlQ3OYtaJZ/7kaYDPF+oUuysgBbdihoeEqzLuCQD4yboyMC
         HsmZJJe65HM9Xfj/7z0n0fTANM/AjMzerRIQx1pt3d4RYoZCZh5/s39SHOVEAyvwTlLS
         arechKjvDIQm9xBTep7/GhdZMkv6LmAU1mJ0UMcwuB4zEidBgXgbSbPfcCbm+qGIKNTE
         1Hk5uxndVZgjaIrzkTenWsn6r3tDx2EPX5zdXTsZxjo4NHeGFucXonvxtl3kZcz+X3RK
         ofmXag1xuJO3oCUXY7T8+aB8Q2o9NIn94ww3AHJSjzOyTsCVfcPbiBMkQDCefopGptQr
         MuXA==
X-Gm-Message-State: AO0yUKWA2iZJbCba62kcuKNAtDhBgVsuOgLdSJQlFY5Q1BEdN/io3IZG
        gwqRRm+qNkwtUWuY8Qp5RkMoGhskZSmahEpU
X-Google-Smtp-Source: AK7set+ZEtK/WiaZolXFTmyib1CYcjCMNWgUIkUkczjnQ978e6QD6VQNDLHw2VijJqF9J6RNoiNqLg==
X-Received: by 2002:a05:622a:1820:b0:3b6:2e12:4d25 with SMTP id t32-20020a05622a182000b003b62e124d25mr555448qtc.31.1677522452164;
        Mon, 27 Feb 2023 10:27:32 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id e10-20020ac8130a000000b003b63a734434sm5086861qtj.52.2023.02.27.10.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:27:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
Date:   Mon, 27 Feb 2023 13:27:20 -0500
Message-Id: <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
References: <Y/z0fHHYdxEXcWMT@pc636>
Cc:     paulmck@kernel.org, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <Y/z0fHHYdxEXcWMT@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Feb 27, 2023, at 1:20 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:=

>>>=20
>>> =EF=BB=BFOn Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:=

>>>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>>>=20
>>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrot=
e:
>>>>>>>=20
>>>>>>> =EF=BB=BF
>>>>>>>>=20
>>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
>>>>>>>> To: linux-kernel@vger.kernel.org
>>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weis=
becker
>>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linu=
x-
>>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
>>>>>>>> rcu@vger.kernel.org
>>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as=

>>>>>>>> completed
>>>>>>>>=20
>>>>>>>> On many systems, a great deal of boot happens after the kernel thin=
ks the
>>>>>>>> boot has completed. It is difficult to determine if the system has r=
eally
>>>>>>>> booted from the kernel side. Some features like lazy-RCU can risk s=
lowing
>>>>>>>> down boot time if, say, a callback has been added that the boot
>>>>>>>> synchronously depends on.
>>>>>>>>=20
>>>>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_=
boot' to
>>>>>>>> stay expedited for as long as the system is still booting.
>>>>>>>>=20
>>>>>>>> For these reasons, this commit adds a config option
>>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
>>>>>>>> rcupdate.boot_end_delay.
>>>>>>>>=20
>>>>>>>> By default, this value is 20s. A system designer can choose to spec=
ify a value
>>>>>>>> here to keep RCU from marking boot completion.  The boot sequence w=
ill not
>>>>>>>> be marked ended until at least boot_end_delay milliseconds have pas=
sed.
>>>>>>>=20
>>>>>>> Hi Joel,
>>>>>>>=20
>>>>>>> Just some thoughts on the default value of 20s, correct me if I'm wr=
ong :-).
>>>>>>>=20
>>>>>>> Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more about the=

>>>>>>> real-time latency than the overall OS boot time?
>>>>>>=20
>>>>>> But every system has to boot, even an RT system.
>>>>>>=20
>>>>>>>=20
>>>>>>> If so, we might make rcupdate.boot_end_delay =3D 0 as the default va=
lue
>>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?
>>>>>>=20
>>>>>> Could you measure how much time your RT system takes to boot before t=
he application runs?
>>>>>>=20
>>>>>> I can change it to default 0 essentially NOOPing it, but I would rath=
er have a saner default (10 seconds even), than having someone forget to tun=
e this for their system.
>>>>>=20
>>>>> Provide a /sys location that the userspace code writes to when it
>>>>> is ready?  Different systems with different hardware and software
>>>>> configurations are going to take different amounts of time to boot,
>>>>> correct?
>>>>=20
>>>> I could add a sysfs node, but I still wanted this patch as well
>>>> because I am wary of systems where yet more userspace changes are
>>>> required. I feel the kernel should itself be able to do this. Yes, it
>>>> is possible the system completes "booting" at a different time than
>>>> what the kernel thinks. But it does that anyway (even without this
>>>> patch), so I am not seeing a good reason to not do this in the kernel.
>>>> It is also only a minimum cap, so if the in-kernel boot takes too
>>>> long, then the patch will have no effect.
>>>>=20
>>>> Thoughts?
>>>>=20
>>> Why "rcu_boot_ended" is not enough? As i see right after that an "init"
>>> process or shell or panic is going to be invoked by the kernel. It basic=
ally
>>> indicates that a kernel is fully functional.
>>>=20
>>> Or an idea to wait even further? Until all kernel modules are loaded by
>>> user space.
>>=20
>> I mentioned in commit message it is daemons, userspace initialization etc=
. There is a lot of userspace booting up as well and using the kernel while d=
oing so.
>>=20
>> So, It does not make sense to me to mark kernel as booted too early. And n=
o harm in adding some builtin kernel hysteresis. What am I missing?
>>=20
> Than it is up to user space to decide when it is ready in terms of "boot c=
ompleted".

I dont know if you caught up with the other threads. See replies from Paul a=
nd my reply to that.

Also what you are proposing can be more harmful. If user space has a bug and=
 does not notify the kernel that boot completed, then the boot can stay inco=
mplete forever. The idea with this patch is to make things better, not worse=
.

Thanks,

- Joel


>=20
> --
> Uladzislau Rezki
