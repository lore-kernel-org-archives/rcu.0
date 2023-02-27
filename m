Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A9C64ED8
	for <rcu@archiver.kernel.org>; Mon, 27 Feb 2023 23:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB0XZG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB0XZF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Feb 2023 18:25:05 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69025E22
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 15:25:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id by8so8265491ljb.7
        for <rcu@vger.kernel.org>; Mon, 27 Feb 2023 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJJWaVVSIZjZ+G1Kq23FeuZRyr8NP+H9jObI+RlAcBc=;
        b=OAqBVmHElZUUac2UEEd5qN3zHG0rmaqrkQFbRTl5Udk6yioQ5yN+6IOWG7JrnOo/Dd
         QpnUS0uiNCVFNl9LwoJ1a4gvICtAA7T9+YGFBjEHgT804BaMohkfqlUhxSqCJGrZMGpq
         jefEB2JNLfK01bmZVlUWcm7uJRmSNK+iDbAag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJJWaVVSIZjZ+G1Kq23FeuZRyr8NP+H9jObI+RlAcBc=;
        b=dQFleYINKnL/qT65jTqiC+v79RE2DIsQUgnSRz11RuOfkTYMX5RCpGO53jVv0l0RRt
         5yHKCMHJVh1YGup5g8YCN7ylj4YzXTtw5wbBpOPIeDSsOt3PjHSakBPvd1WWYrikB5oE
         TGwChG3yK/wdp8/vWR1FIWgfbePqRi/EINhPFGjRInZAQ7aIxa+ni4FRXE1b1/U7ZJzg
         ZmolU5VHmYjaRgolxG/WYpZZsb+7ecf+KZBkfAs7v5RHgOFpNExYPOmt9cWLhNXGXQyi
         A4HdItHa6o5P/gVhV/MbYC8dROlFlnsjDo4iTmb1gqt7IZoXjSZfvqEdUD0fbU250Obp
         wxEg==
X-Gm-Message-State: AO0yUKX70N12gyCT+hSWxxtiV1g9FMOFiWLj63qK0X32QllP8kRANGvg
        0MjO+v+pI+96t419Wwjy0mLNtcHVrWCKLWilhYjBVA==
X-Google-Smtp-Source: AK7set/31E/pohifRX6cBtI3PF7l0+17H08NElgVXjj+uGTprnsv18lGVW0twqT0rAUeaZWgH2gNo66h2V8LZzozUlU=
X-Received: by 2002:a05:651c:10af:b0:295:a8d1:8a28 with SMTP id
 k15-20020a05651c10af00b00295a8d18a28mr139590ljn.3.1677540301001; Mon, 27 Feb
 2023 15:25:01 -0800 (PST)
MIME-Version: 1.0
References: <Y/z0fHHYdxEXcWMT@pc636> <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636> <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 18:24:49 -0500
Message-ID: <CAEXW_YR6qnU=35Ang7S5brRRDX_HgiNgPpQ_w-+REYkujZE6rQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
To:     paulmck@kernel.org
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 27, 2023 at 6:05=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
[...]
> > > > >>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrot=
e:
> > > > >>>>>>
> > > > >>>>>>
> > > > >>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.=
com> wrote:
> > > > >>>>>>>
> > > > >>>>>>> =EF=BB=BF
> > > > >>>>>>>>
> > > > >>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> > > > >>>>>>>> To: linux-kernel@vger.kernel.org
> > > > >>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Fred=
eric Weisbecker
> > > > >>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.c=
om>; linux-
> > > > >>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>=
;
> > > > >>>>>>>> rcu@vger.kernel.org
> > > > >>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for markin=
g boot as
> > > > >>>>>>>> completed
> > > > >>>>>>>>
> > > > >>>>>>>> On many systems, a great deal of boot happens after the ke=
rnel thinks the
> > > > >>>>>>>> boot has completed. It is difficult to determine if the sy=
stem has really
> > > > >>>>>>>> booted from the kernel side. Some features like lazy-RCU c=
an risk slowing
> > > > >>>>>>>> down boot time if, say, a callback has been added that the=
 boot
> > > > >>>>>>>> synchronously depends on.
> > > > >>>>>>>>
> > > > >>>>>>>> Further, it is better to boot systems which pass 'rcu_norm=
al_after_boot' to
> > > > >>>>>>>> stay expedited for as long as the system is still booting.
> > > > >>>>>>>>
> > > > >>>>>>>> For these reasons, this commit adds a config option
> > > > >>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> > > > >>>>>>>> rcupdate.boot_end_delay.
> > > > >>>>>>>>
> > > > >>>>>>>> By default, this value is 20s. A system designer can choos=
e to specify a value
> > > > >>>>>>>> here to keep RCU from marking boot completion.  The boot s=
equence will not
> > > > >>>>>>>> be marked ended until at least boot_end_delay milliseconds=
 have passed.
> > > > >>>>>>>
> > > > >>>>>>> Hi Joel,
> > > > >>>>>>>
> > > > >>>>>>> Just some thoughts on the default value of 20s, correct me =
if I'm wrong :-).
> > > > >>>>>>>
> > > > >>>>>>> Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more =
about the
> > > > >>>>>>> real-time latency than the overall OS boot time?
> > > > >>>>>>
> > > > >>>>>> But every system has to boot, even an RT system.
> > > > >>>>>>
> > > > >>>>>>>
> > > > >>>>>>> If so, we might make rcupdate.boot_end_delay =3D 0 as the d=
efault value
> > > > >>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?
> > > > >>>>>>
> > > > >>>>>> Could you measure how much time your RT system takes to boot=
 before the application runs?
> > > > >>>>>>
> > > > >>>>>> I can change it to default 0 essentially NOOPing it, but I w=
ould rather have a saner default (10 seconds even), than having someone for=
get to tune this for their system.
> > > > >>>>>
> > > > >>>>> Provide a /sys location that the userspace code writes to whe=
n it
> > > > >>>>> is ready?  Different systems with different hardware and soft=
ware
> > > > >>>>> configurations are going to take different amounts of time to=
 boot,
> > > > >>>>> correct?
> > > > >>>>
> > > > >>>> I could add a sysfs node, but I still wanted this patch as wel=
l
> > > > >>>> because I am wary of systems where yet more userspace changes =
are
> > > > >>>> required. I feel the kernel should itself be able to do this. =
Yes, it
> > > > >>>> is possible the system completes "booting" at a different time=
 than
> > > > >>>> what the kernel thinks. But it does that anyway (even without =
this
> > > > >>>> patch), so I am not seeing a good reason to not do this in the=
 kernel.
> > > > >>>> It is also only a minimum cap, so if the in-kernel boot takes =
too
> > > > >>>> long, then the patch will have no effect.
> > > > >>>>
> > > > >>>> Thoughts?
> > > > >>>>
> > > > >>> Why "rcu_boot_ended" is not enough? As i see right after that a=
n "init"
> > > > >>> process or shell or panic is going to be invoked by the kernel.=
 It basically
> > > > >>> indicates that a kernel is fully functional.
> > > > >>>
> > > > >>> Or an idea to wait even further? Until all kernel modules are l=
oaded by
> > > > >>> user space.
> > > > >>
> > > > >> I mentioned in commit message it is daemons, userspace initializ=
ation etc. There is a lot of userspace booting up as well and using the ker=
nel while doing so.
> > > > >>
> > > > >> So, It does not make sense to me to mark kernel as booted too ea=
rly. And no harm in adding some builtin kernel hysteresis. What am I missin=
g?
> > > > >>
> > > > > Than it is up to user space to decide when it is ready in terms o=
f "boot completed".
> > > >
> > > > I dont know if you caught up with the other threads. See replies fr=
om Paul and my reply to that.
> > > >
> > > > Also what you are proposing can be more harmful. If user space has =
a bug and does not notify the kernel that boot completed, then the boot can=
 stay incomplete forever. The idea with this patch is to make things better=
, not worse.
> > > >
> > > I saw that Paul proposed to have a sysfs attribute using which you ca=
n
> > > send a notification.
> >
> > Maybe I am missing something but how will a sysfs node on its own work =
really?
> >
> > 1. delete kernel marking itself boot completed  -- and then sysfs
> > marks it completed?
> >
> > 2. delete kernel marking itself boot completed  -- and then sysfs
> > marks it completed, if sysfs does not come in in N seconds, then
> > kernel marks as completed?
> >
> > #1 is a no go, that just means a bug waiting to happen if userspace
> > forgets to write to sysfs.
> >
> > #2 is just an extension of this patch. So I can add a sysfs node on
> > top of this. And we can make the minimum time as a long period of
> > time, as you noted below:
> >
> > > IMHO, to me this patch does not provide a clear correlation between w=
hat
> > > is a boot complete and when it occurs. A boot complete is a synchrono=
us
> > > event whereas the patch thinks that after some interval a "boot" is c=
ompleted.
> >
> > But that is exactly how the kernel code is now without this patch, so
> > it is already broken in that sense, I am not really breaking it more
> > ;-)
> >
> > > We can imply that after, say 100 seconds an initialization of user sp=
ace
> > > is done. Maybe 100 seconds then? :)
> >
> > Yes I am Ok with that. So are you suggesting we change the default to
> > 100 seconds and then add a sysfs node to mark as boot done whenever
> > userspace notifies?
>
> The combination of sysfs manipulated by userspace and a kernel failsafe
> makes sense to me.  Especially if by default triggering the failsafe
> splats.  That way, bugs where userspace fails to update the sysfs file
> get caught.

By splat, if we could do an "info" message, that would work for me
instead of a WARN_ON. I'm afraid of Android and other folks who
upgrade to the new kernel only to now have to go patch userspace.

So,
pr_info("RCU is still in boot-mode for the next N seconds, please
consider writing X to /sys/.. to avoid this message.");
?

> The non-default silent-failsafe mode is also useful to allow some power
> savings in advance of userspace getting the sysfs updating in place.
> And of course the default splatting setup can be used in internal testing
> with the release software being more tolerant of userspace foibles.

Sounds good, would 100 seconds be a good fail-safe trigger value?

Thanks,

 - Joel
