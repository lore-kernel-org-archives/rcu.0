Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA338F9C;
	Mon, 28 Apr 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837996; cv=none; b=GBaqKywXPX9tARerTsLoouKnY0irnezEvchkMgKTEdufQ/mwBH0NVjW7eWuIETOdkGsE5A/JGjYwDIR+XPWDHJTaTx+5/TTz5iArdtUR1YhlUoQwXmAISomBOIxhP9PlzpjQ21vsz+c+7MpnTQU4EhfNoYvUL8YmfnFNqlZL+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837996; c=relaxed/simple;
	bh=WGWADiMzN8KshFwXwGl1pejqqmTv2bI4GWJx1TxcLa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjMwVdLkooYJlxSeEodnKotY07pJ9ZDamj7vrAexGmHjhny5ePkGNXc45p6jSCjR2Nh2pno2S6QqexZ2caHn7/0VKxfEYCzefAvHFY0z//yE9SYFd4dunkcVrSClZluGFDaJdCZFM93RyBiqsa0L/zSaX3zvQt+EM3tYTNIMtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPL/7koY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPL/7koY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22d95f0dda4so68297195ad.2;
        Mon, 28 Apr 2025 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745837994; x=1746442794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21iw96XdMkH4QpPZ1iM8W1s+sZupdpaayQRV0rXNgf4=;
        b=UPL/7koYzc4bjFZkmXbcKlbPoKzlwUqzz6A1ryRGhco3Lfg22E2Y8oCjvIfwyXwmOt
         Aevs5+ury5DQbMutM/9O8i0EFojwKtGc4slAPl5Z3yUJWvoijMW06T1E5SYCEC1mcS57
         muBuw02QmGgw0+lH4FGmVhi+5wJMIx23Ek6quKFHbqPREvBCCJxLnZbwh5PoUZilBB2K
         OGScdR+WONcZi8lhXj4n9zTv43Za33V5o6vnCfMAw36ls5DxBAsNj+lV5t114zCahH1D
         B+7Ox1zH1fbw5TJRne3BY8vTd9YuK3bU2jVp2P9lEEiXzRulO9hpjAd6YRzV2WEGu1HN
         EOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837994; x=1746442794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21iw96XdMkH4QpPZ1iM8W1s+sZupdpaayQRV0rXNgf4=;
        b=WdFd1yU6Ldmdw/Nh2rMsxGfQwxLJbqmVyZq22vd6o6darLz9GlMz7Gw7XqspQ7McZ7
         7tIxEhlJrzUZE28Tq5fjOVS33XVyNHHIN9tD7ai52lWx7NQPwcPzq4SqPxbN3gV3bNYh
         dlX0To+rlPAhReGyNFV2PqI/yrqE9oVg/A1MScnyz8RX24J5+XCc8UIj5Kve2RxvFbCZ
         KTctCu09bzGzPhp6xb/f1lJ2h0msd9wphOZfjW9/6FvMVcpzyV0PrwIDRb+x+yLLJtwK
         XUL0fpuGgvFV1OVnvjExoaZQvOphTnu0mnElEvZsLVZGRxjZsWrtpltxYsphZNjfyGZb
         EC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCdGxkMXM2cjMDktAGAi75kPJVpqoagy1UfRSE7LenzNWPfLkIJbZtECyiZm5ly/+GOy8i@vger.kernel.org, AJvYcCWNS8xECWNgfG8sd0DDJvXdwWwf4i0zORTO/0XGkRaqvFyratpCe7iAXCiSFJlI4M2P9sw+iE9f5TRI+GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhq6dJK+n+cMKCmH1rqrG56lyfbE7ZunJSoq/2+Nig6NZch4O
	lfM552r2WAgGa98cmwqCk7/LQyqTt86JnVU9kt4LFZ1hwzbonNTI+h1hzALZWI4JM4lvdzHzjY7
	OmZpXZIVcrKSJ8qKlCUOFMScomVo=
X-Gm-Gg: ASbGncuNJ11t4ZljEL+lwYE6hJjqH3uceQZ2ZSZ/59l993kNrG0Z1cf8eiYE4nDw7Ws
	+jup+bl/UOhjFgaZWVV9ZGJrGOMWdyiSm/2K0XGKbNX3jiWUmyPO5+Ch08BsvM56vAZFjM8eijv
	Fvrb23bqevjq49ZatqvGboGyM=
X-Google-Smtp-Source: AGHT+IHpFWruSoaJfi5Zu9FkvO/rw7OsW+Ep9QDYygLmD6+dJvXDLLBwM+/J0/1ZCPXl1cH3KCoA0fu2iqUWxeejpF4=
X-Received: by 2002:a17:902:e84c:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-22dbf5efce5mr186834705ad.24.1745837994321; Mon, 28 Apr 2025
 03:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com> <aA9U9QvB2t2MLuU2@pavilion.home>
In-Reply-To: <aA9U9QvB2t2MLuU2@pavilion.home>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 28 Apr 2025 18:59:43 +0800
X-Gm-Features: ATxdqUHiy63_hlCnW9UIXsqT-dGrf-8zBT9xEah_b0guOwxISnr_aVjq30HTTsA
Message-ID: <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a =C3=A9crit :
> > For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
> > disable local bh in rcuc kthreads will not affect preempt_count(),
> > this resulted in the following splat:
> >
> > WARNING: suspicious RCU usage
> > kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> > Call Trace:
> > [    0.407907]  <TASK>
> > [    0.407910]  dump_stack_lvl+0xbb/0xd0
> > [    0.407917]  dump_stack+0x14/0x20
> > [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> > [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> > [    0.407939]  rcu_core+0x471/0x900
> > [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> > [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> > [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> > [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> > [    0.407970]  ? trace_preempt_on+0x54/0x120
> > [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [    0.407982]  kthread+0x40e/0x840
> > [    0.407990]  ? __pfx_kthread+0x10/0x10
> > [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> > [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> > [    0.408000]  ? __pfx_kthread+0x10/0x10
> > [    0.408006]  ? __pfx_kthread+0x10/0x10
> > [    0.408011]  ret_from_fork+0x40/0x70
> > [    0.408013]  ? __pfx_kthread+0x10/0x10
> > [    0.408018]  ret_from_fork_asm+0x1a/0x30
> > [    0.408042]  </TASK>
> >
> > Currently, triggering an rdp offloaded state change need the
> > corresponding rdp's CPU goes offline, and at this time the rcuc
> > kthreads has already in parking state. this means the corresponding
> > rcuc kthreads can safely read offloaded state of rdp while it's
> > corresponding cpu is online.
> >
> > This commit therefore add rdp->rcu_cpu_kthread_task check for
> > Preempt-RT kernels.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 003e549f6514..fe728eded36e 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp=
)
> >                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> >                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &=
&
> >                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
> > -               rcu_current_is_nocb_kthread(rdp)),
> > +               rcu_current_is_nocb_kthread(rdp) ||
> > +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > +                current =3D=3D rdp->rcu_cpu_kthread_task)),
>
> Isn't it safe also on !CONFIG_PREEMPT_RT ?

For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
but the following check will passed :

(!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
          rdp =3D=3D this_cpu_ptr(&rcu_data))

Thanks
Zqiang


>
> Thanks.
>
> >               "Unsafe read of RCU_NOCB offloaded state"
> >       );
> >
> > --
> > 2.17.1
> >
>
> --
> Frederic Weisbecker
> SUSE Labs
