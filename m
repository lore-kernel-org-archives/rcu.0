Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DF7260A;
	Tue,  6 May 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512769; cv=none; b=CK54l2wVzBMJL6rGlk2E5dsjAR9tCqRu/Gw0qUERpqHjxK8pHvllKPpx4WNop0nXWyzRr1lQ5pFN9Sg1NbWBuYgxfLPp9oTYwC5E2v1X0eqMKRfAY0RHiKU3PpvmRo1f0KVIkDG2uKxQQXcWBKW9+hFr86ZI9ZyzFJ+biGv/gWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512769; c=relaxed/simple;
	bh=Oa7GEmVwDIyoFuJivqYvFuaJTUkd2IHxguH1TOIdb68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiW6F7yKeZyNi7X6VUuJSi/2630UrRsOk5PlvHzv1MFPqZMLh78yZrLUL7Z8fR/+ojKvkPjq45BlsedA8e6+YnlnFcxigzgtjzlmn7ObvQR0SMzfVXFz8puv66tybhbs/NiSGx8eKypcG8eKEsWo7UkfRVo/aRCfog8q8bduYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R56LLUc+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R56LLUc+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224171d6826so77401845ad.3;
        Mon, 05 May 2025 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746512767; x=1747117567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd5qXJZnOi771YIqf3qDOzHLFEjnUn3XDmfjn9FChrA=;
        b=R56LLUc+19TDjc94XvoZEc8zIuXWI39bwwp6yPGlPqdKyZjbVmIz14Y9VKoS1cuBky
         Y8GcYDxWtNnjVX2pZX3dKQcBeRuX5DajZ9dHOsu12PXFOLaqUWxWGEew1bWskjsQhwy8
         62vlRJRPrrCso2uQfm1HMVdAATskkvSP1nCdmai3f9CNABqOZMQIUYrcChMo27SNF5v4
         ppzsBCXVJFzEO1L9QA+5cCR1eDVyEwmOO/y851FR3XbpYxC397OhRyJG+DVJIWRn4IR2
         fghH95Mfwc+yYKsHFhaL0CKHli6/Ffj+2z4ZNsLHN/MSakwnKbIKJfBsxSQ4Ze3uNCnt
         2BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746512767; x=1747117567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd5qXJZnOi771YIqf3qDOzHLFEjnUn3XDmfjn9FChrA=;
        b=dscSjqIMUaC8RQ5XUPDfunIksjZH8AXrc0qsDNtwb9uulOPtdO4hHTVWjRUKXt1fO5
         f96Z1hBMWzaGAZV/S/+qV596zYOxdRWjI/4uFEQK8lmOvFX1aYyu9K1PpgT/EZZYzBeL
         VN/gsrZNa1i8rpTmDw0t4UNaZffDQalLefrbL4oPwSFUMroYxdpOQoyMrxs8n71Pw3GQ
         haEET0eRBfaJGb3kYtcDbFsjUrWAdsVgi0NfxBAKyDP3+43HAEmBk8/kakH0sd1L1pWa
         fsJXKILemX3XIJtd+tnx+1amqeg1GDjpE9npQtkp3sxG7z3AmuD78xp+/HASL8V8e7Mk
         6QOA==
X-Forwarded-Encrypted: i=1; AJvYcCUeL4z7osp5h8Q4YH0OJWgW8oNJLauX3MOU6CftfQgvFw+a5MQ7cqPrMML/GOhTji0SJj/B@vger.kernel.org, AJvYcCVnmL9p3LA5zc1YOt/xi26ZhhkFagD7wrjg59QwXcrN8NjBpDiZQhQVDy9q5jzxEs7MhzuBiNRK+ocx/dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuEQHB1RXOnkqfwUuHlf/z76MM77+FCrvgJtizcFKioKQd6H3
	z28Pkxk3/tDNaZfyiNYdv0jYheI4CUdvou8xbnMRmOdhqUNlqftJKWYgSoSxP7yDshCk+wF67DH
	KXgjzXeQQYhlsq6nkOTeR+xptC4o=
X-Gm-Gg: ASbGncuRSefNcLfLryNefjE+2JjDGWiNbDHt3D9ugUol5bpfOkRpV+vx9aJ0Pkg+I5v
	ePPoGq7cNQKYBzLbwgjESXZ1yjF5rsi4SrUGgxK938CPBhPL1K/sELoRM69/oAztmKbvstlNQGQ
	nI3PUKiCJGqkGOf2B3H0+i0+c=
X-Google-Smtp-Source: AGHT+IGNUUuvtxWkWTxsOK8iYAV++2+yYFz+cHnebnwgULotgbGheEhe6B0asDvI0hJ5qecsO+KumN7/j/pYZRjhhVk=
X-Received: by 2002:a17:902:ccc5:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-22e32eeea8amr29101175ad.33.1746512766626; Mon, 05 May 2025
 23:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home> <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
 <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com> <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
 <2c8098f0-2010-4714-97ca-7f46629d67f8@nvidia.com> <6dc114e4-83d3-40ff-9642-114552f40a75@nvidia.com>
In-Reply-To: <6dc114e4-83d3-40ff-9642-114552f40a75@nvidia.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 6 May 2025 14:25:55 +0800
X-Gm-Features: ATxdqUExgrDRkpeIllBabN5-IkHhuawjE3kM-lwfoxY15RwPwy3k4C1R4UyctX8
Message-ID: <CALm+0cUuze+CWJ2YS3TGeyayxBqO-pZbK=dq0E_7rfT+Od3KHQ@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, paulmck@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
>
> On 4/30/2025 12:14 PM, Joel Fernandes wrote:
> >
> >
> > On 4/30/2025 10:57 AM, Z qiang wrote:
> >>>
> >>>
> >>>
> >>> On 4/28/2025 6:59 AM, Z qiang wrote:
> >>>>>
> >>>>> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a =C3=A9crit :
> >>>>>> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
> >>>>>> disable local bh in rcuc kthreads will not affect preempt_count(),
> >>>>>> this resulted in the following splat:
> >>>>>>
> >>>>>> WARNING: suspicious RCU usage
> >>>>>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded stat=
e!
> >>>>>> stack backtrace:
> >>>>>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> >>>>>> Call Trace:
> >>>>>> [    0.407907]  <TASK>
> >>>>>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
> >>>>>> [    0.407917]  dump_stack+0x14/0x20
> >>>>>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> >>>>>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> >>>>>> [    0.407939]  rcu_core+0x471/0x900
> >>>>>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> >>>>>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> >>>>>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> >>>>>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> >>>>>> [    0.407970]  ? trace_preempt_on+0x54/0x120
> >>>>>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> >>>>>> [    0.407982]  kthread+0x40e/0x840
> >>>>>> [    0.407990]  ? __pfx_kthread+0x10/0x10
> >>>>>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> >>>>>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> >>>>>> [    0.408000]  ? __pfx_kthread+0x10/0x10
> >>>>>> [    0.408006]  ? __pfx_kthread+0x10/0x10
> >>>>>> [    0.408011]  ret_from_fork+0x40/0x70
> >>>>>> [    0.408013]  ? __pfx_kthread+0x10/0x10
> >>>>>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
> >>>>>> [    0.408042]  </TASK>
> >>>>>>
> >>>>>> Currently, triggering an rdp offloaded state change need the
> >>>>>> corresponding rdp's CPU goes offline, and at this time the rcuc
> >>>>>> kthreads has already in parking state. this means the correspondin=
g
> >>>>>> rcuc kthreads can safely read offloaded state of rdp while it's
> >>>>>> corresponding cpu is online.
> >>>>>>
> >>>>>> This commit therefore add rdp->rcu_cpu_kthread_task check for
> >>>>>> Preempt-RT kernels.
> >>>>>>
> >>>>>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >>>>>> ---
> >>>>>>  kernel/rcu/tree_plugin.h | 4 +++-
> >>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>>>>> index 003e549f6514..fe728eded36e 100644
> >>>>>> --- a/kernel/rcu/tree_plugin.h
> >>>>>> +++ b/kernel/rcu/tree_plugin.h
> >>>>>> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data=
 *rdp)
> >>>>>>                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> >>>>>>                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible=
()) &&
> >>>>>>                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
> >>>>>> -               rcu_current_is_nocb_kthread(rdp)),
> >>>>>> +               rcu_current_is_nocb_kthread(rdp) ||
> >>>>>> +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> >>>>>> +                current =3D=3D rdp->rcu_cpu_kthread_task)),
> >>>>>
> >>>>> Isn't it safe also on !CONFIG_PREEMPT_RT ?
> >>>>
> >>>> For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
> >>>> but the following check will passed :
> >>>>
> >>>> (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> >>>>           rdp =3D=3D this_cpu_ptr(&rcu_data))
> >>>
> >>> I think the fact that it already passes for !PREEMPT_RT does not matt=
er, because
> >>> it simplifies the code so drop the PREEMPT_RT check?
> >>>
> >>> Or will softirq_count() not work? It appears to have special casing f=
or
> >>> PREEMPT_RT's local_bh_disable():
> >>>
> >>> (   ( !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq=
_count() )
> >>>    && rdp =3D=3D this_cpu_ptr(&rcu_data))  )
> >>
> >> Thank you for Joel's reply,  I also willing to accept such
> >> modifications and resend :) .
> > Thanks, I am Ok with either approach whichever you and Frederic togethe=
r decide.
> > I can then pull this in for the v6.16 merge window once you resend, tha=
nks!
> >
>
> Frederic, there are a couple of ways we can move forward hear. Does the
> softirq_count() approach sound good to you? If yes, I can fixup the patch=
 myself.

Hello, Joel

If you send a patch to fix it, I'd be happy,  you can add me as the
Reported-by ;)

Thanks
Zqiang

>
> I am also Ok at this point to take it in for 6.16, though I've also store=
d it in
> my rcu/dev branch for Neeraj's 6.17 PR, just in case :)
>
>  - Joel
>
>
