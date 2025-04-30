Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870AB640;
	Wed, 30 Apr 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024874; cv=none; b=PGRgmaE2FOFlpK6DIlrvf/oSBxIuuZF3a+ak7zc0Y3r9jtKEwl6olt/24d3GGlE+Y3t3OF+soSSfkNAY0aja9CCnTApeZhUMNWHK0Y2pyVYI+Zpi3Nhs6vByg18878Y/+6Ra5A7XFWMwiAwcHtUELIDK2Y9QgrWuS+Goo+QpAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024874; c=relaxed/simple;
	bh=/9xOhEYTUhZBBh0XlcuoEXdM4hfh4r7eUVkJMpaLNxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In4regcJAM669cT3gXNZcWUpnP6LHVcbH1dIYZhpNUEpBH3HZ9wKVJBmYtk/rTcI9kfr1GfBJhgAbpl9A3/UoYvvio5UGXiTPsUrwovbdSV0zrNpFDxKBpn40CfA8kHLf2d8FzvcX2DvpB3Zvbgdl5FH9VmWWHw7bGLE4RYuw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7dPx9OP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7dPx9OP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c1138ae5so7595140b3a.3;
        Wed, 30 Apr 2025 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746024872; x=1746629672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++Jf+Qeh1ch1PHZhlAOXZksniFtlc36EzIRFCLcsgmQ=;
        b=D7dPx9OPghf8389PNQFNsMAYon3ePNfeEMAMqB6yN3OTdnuh6BXbRc2KUCdQFv/KSe
         ppSC2/i98m9O6p2nReQTlGtDng1ZkmuaIdJXTk8Qva6fCjfk7FVDQjl8RKSzxyAjUbtw
         370LMgVa05p9I8/6PTNiwb1bv5F0rjRdKJDwiKJZuRUgl4sTTbD9PzrSwP6DHV+e2nkp
         SMOAHY/GYk2ioHQluvJX9Ghk9OSpBTIIwbWMSixiUsf1DYi7xIb3qmoc/c6aKR6Ufec6
         C8NS4dTZYUMC7vCjHdg6gGv7pLlAVTP3KSOYkIv3lDNZ/sW6r+ymAeVZkgQXlYBT0qsu
         1EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024872; x=1746629672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++Jf+Qeh1ch1PHZhlAOXZksniFtlc36EzIRFCLcsgmQ=;
        b=UecJ5AEBWjM48M4+QokWB8MlVTcFXg+hXiFWV3CiJUjMaLvl0UGefNzwKpfd2H1Wtk
         J4CvnRyhg8C2dLHOab5VwAlyFVHCd44mY+UbL4cLpOvOrdrd9/17AbMoyb+BgiLoIAHu
         EQ+kuwZqjjYPrNh/MXrFKCNvWTviH/jsMMa2QBpMnlpBVpzMAySN4e7qN81ghY3c+ye1
         I5zKNtGsTy2/8BmVxpUu6MSD6BQfKBQkM/9dj/sUxJs/fsZ5tyXm3z7xhCj+QvkDiMlr
         /g9vcM4aJbJXBlM2nJfTmXskjOdCx9vTsKLe3YKH/y16oswsXqY31isuFZEVBRqrA0Li
         Oxqg==
X-Forwarded-Encrypted: i=1; AJvYcCVDiHAU+87L9OxS91S9jNrR1yeNjwuv0pYLMZHg8mkES5fP0ZulVrC8JF5sbe+krPOCnRuXKsR2jKktcdI=@vger.kernel.org, AJvYcCXvfvCSBpiwIuARoK/jk3oYzHp3pGuBYqD+ekBfy7rX2RGhi3/OUAJk64Jf4K885pxBi3mQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ml4h6N15Z/JWiip49Ag6b43utaa+PnXZVL/xlxpUQVU61LaB
	naXkKt/uYr2BFRyLMCVd/HWAzIc2qKJ4/e3x31rYtnfF08SC2VcpuLfm8RwkXlSOk25Eta8mah8
	NXsNuWQW900sTdr5GcX7QVW8XwfQ=
X-Gm-Gg: ASbGncuvUOv4+vGQnnJmZe0QVBd8URixOK6H2D9I88DeHqV4RbKh0b+H3dNYqEK6IoF
	E7o7OjrF4v3i+hFtWob6Rmbv4rsueA0IbbAa8Ejz1BJtSFzIJkSfdTagVUxsYRC4VITxJwVnEWP
	WWmjhfRNXMbbJ+2G4rt8Mu9eGQilyOOkRvTV7jxNFnhK486x9XQ4/9aJGr2T8FQpDwF88=
X-Google-Smtp-Source: AGHT+IH4M4Y1gxipd7iUXF1rSQOnvemFi0LUS8rEqMjumMThqFnGY9acC4DF8NLzyzxBcfkBEL5DxTIfQSWVunvHOsQ=
X-Received: by 2002:a05:6a00:a83:b0:73e:30de:bacc with SMTP id
 d2e1a72fcca58-7403a75b576mr4533927b3a.3.1746024871871; Wed, 30 Apr 2025
 07:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home> <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
In-Reply-To: <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 30 Apr 2025 22:54:19 +0800
X-Gm-Features: ATxdqUE28K8dZfEMFoxL8v3ZvRTzDWSbyJCaIVynbhcB21yH3Qb0TqRJHuAUBz8
Message-ID: <CALm+0cWvx1N1KfGJU=kQoTaBRRf9trEU2TzL40b-gXHv5H+Utg@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> >
> > Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a =C3=A9crit :
> > > For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
> > > disable local bh in rcuc kthreads will not affect preempt_count(),
> > > this resulted in the following splat:
> > >
> > > WARNING: suspicious RCU usage
> > > kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> > > stack backtrace:
> > > CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> > > Call Trace:
> > > [    0.407907]  <TASK>
> > > [    0.407910]  dump_stack_lvl+0xbb/0xd0
> > > [    0.407917]  dump_stack+0x14/0x20
> > > [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> > > [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> > > [    0.407939]  rcu_core+0x471/0x900
> > > [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> > > [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> > > [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> > > [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> > > [    0.407970]  ? trace_preempt_on+0x54/0x120
> > > [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > > [    0.407982]  kthread+0x40e/0x840
> > > [    0.407990]  ? __pfx_kthread+0x10/0x10
> > > [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> > > [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> > > [    0.408000]  ? __pfx_kthread+0x10/0x10
> > > [    0.408006]  ? __pfx_kthread+0x10/0x10
> > > [    0.408011]  ret_from_fork+0x40/0x70
> > > [    0.408013]  ? __pfx_kthread+0x10/0x10
> > > [    0.408018]  ret_from_fork_asm+0x1a/0x30
> > > [    0.408042]  </TASK>
> > >
> > > Currently, triggering an rdp offloaded state change need the
> > > corresponding rdp's CPU goes offline, and at this time the rcuc
> > > kthreads has already in parking state. this means the corresponding
> > > rcuc kthreads can safely read offloaded state of rdp while it's
> > > corresponding cpu is online.
> > >
> > > This commit therefore add rdp->rcu_cpu_kthread_task check for
> > > Preempt-RT kernels.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 003e549f6514..fe728eded36e 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *r=
dp)
> > >                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> > >                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())=
 &&
> > >                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
> > > -               rcu_current_is_nocb_kthread(rdp)),
> > > +               rcu_current_is_nocb_kthread(rdp) ||
> > > +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > +                current =3D=3D rdp->rcu_cpu_kthread_task)),
> >
> > Isn't it safe also on !CONFIG_PREEMPT_RT ?

How about the following?

(current =3D=3D rdp->rcu_cpu_kthread_task && in_task())

Thanks
Zqiang

>
> For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
> but the following check will passed :
>
> (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
>           rdp =3D=3D this_cpu_ptr(&rcu_data))
>
> Thanks
> Zqiang
>
>
> >
> > Thanks.
> >
> > >               "Unsafe read of RCU_NOCB offloaded state"
> > >       );
> > >
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Frederic Weisbecker
> > SUSE Labs
