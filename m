Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4316DC28;
	Wed, 30 Apr 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025093; cv=none; b=Y1Y1sjBSDaruKffSk62mdw6/fIt96Ot08zjeCHcm/aIhkR5iaXc6sGb6VKQYFBhq++XTzxiSVMfp48KVYmCouTEmWUslYydOtKviuw081hG5mTL3yvtMVYGzDgURhPj/afCWGdiYd+BdYwE+uLUOHrq85mjqAa5QbYgrOSrFwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025093; c=relaxed/simple;
	bh=EYPKCdUT0tsxaRq3eHTkcGgvwaOZjVXqHJtKFOSpnxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSjODfzqBTMrM827fku7Xd5Uk5h8VXy69rcdkFHvH4qK98yLNlrmukF0IDkZQ6GrHDj2gsi+w6NcM7zSpJ+yhCEp+7fvdsjKINg1dGCQs64RiEUaENwVwr+KLYxiAEVYlSoxex6vRboySRt3mFQl1Y4ehD4CBMDA6kzaXyTLoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9TMVAIa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9TMVAIa"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so75457865ad.2;
        Wed, 30 Apr 2025 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746025091; x=1746629891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XysSvGAtMmxjFQL+azYhYASm1rOofXXZwEqUecB0bpk=;
        b=f9TMVAIakOkT0k8RFiCxseiZe4WlEk4eWjPSUWpwAHG5HIZix4pC/UqaspBBvaom3f
         b0iYB9uThpOVJGAxvRvCtqwsODNcmmxF7eUO1fbgjTomH63BYU3d5lupa6Np37aqoyas
         QEwRj16ZnQDUulYOijq9CabTet4I9SbCRqCrnvJivO5gzRgPXxFSUAiEa0/DbBsSdnC5
         ZNDxN9jJp90rvFwx+aj8FZvZ/uZamD7tpd49ToHOAeO4tfezP3JMj71J55+lM3CKOqmb
         +ruBnqhx0HXtTKTKigF+TFNz5BQ5ydTbxPH4c8QcY5//C98O82GYHdO4jZRmkSt22J4D
         /GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025091; x=1746629891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XysSvGAtMmxjFQL+azYhYASm1rOofXXZwEqUecB0bpk=;
        b=GtXBZieg8OCKzlUBuqlEa/iAAj5xtIG6OYtEIfFx9nrfANewTHd5fo2hMtTzuywISd
         sHLRro3233SZylWfQrW0zOlbmjwt6Od17WNaAhFToFX5wgJk4G47ey7+KH6p9w+uhw40
         4C686izejP0AulRBcT0zmvMkqwvPd1WL72ynR/lgC3KFJAbPn6pTUoFlSbgirixPQhYE
         lpN//SHi2m+CxuhYNuedWDdUCfB3DXN5AqOpf+IV5MZGtJRpa4Ga3ukC8uRygyTr/iqu
         ZKLKAgCGqnHKp955UzrWXIj79lZEuJEQVaynwzXqb96nONXSI0oohbKbmQqYweEvlvtq
         Gy7w==
X-Forwarded-Encrypted: i=1; AJvYcCV9z455aCIQHxItrgC7G4kqOYhKXcj3qHfMl5Wlp2VMqoYw2nBGvSysK+TJzTscJCmoI1Td@vger.kernel.org, AJvYcCXRJ7MbgakRbcUcBnG831J29OK0n7yzYSF41Q5nJPA5YHTaOpb+BxShoUoVW077dl40L9Uku4zrOoOSEMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn96QHHCBfaxCO4+pJIQkcT3XDIfC/Of82i7nivD+VkxTFeKM+
	1ZhgMcX825R8tCpd3+EicYnpwgp1SS7LpHoVcQW1zWgbyBY7kOt8o3cJyVE/m7nFErs77CSqr9F
	oZC6H4/eMAShbnpEVnCsSleXJL5g=
X-Gm-Gg: ASbGncuUTjAAgvd+S1IfgPb4A22FVL45ejOjBa1nt3TE5WGbvpLs3w8oTIQ+ggf00xd
	GY0wI0Wr42uLdgaR/GAscvPH7fLxYuf0qNwYD96S3LI+nc+FoA1/y4xeqaysCeluld9hK839xui
	PtdoZyy4FdM0HoSH+u4TNc9mr+n5wX3ePot1PcrQDEGAFd/1kP7EIT28Sb
X-Google-Smtp-Source: AGHT+IHomQH6ewvLhDPTUDHoLx20D1U1tgbcMBoVGtjZciQbAtMjuYsk6nsriUTRweHxz0bR2DSb6fMEX5V5lotgUsc=
X-Received: by 2002:a17:90a:da83:b0:2ff:4bac:6fa2 with SMTP id
 98e67ed59e1d1-30a3330bc51mr5858081a91.16.1746025090569; Wed, 30 Apr 2025
 07:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home> <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
 <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
In-Reply-To: <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 30 Apr 2025 22:57:59 +0800
X-Gm-Features: ATxdqUFu1fEcELVDHJti8TyXdQfer1gVANipbpWsr1PUkrZAE4GFyLTMoRnMjWM
Message-ID: <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
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
> On 4/28/2025 6:59 AM, Z qiang wrote:
> >>
> >> Le Mon, Apr 28, 2025 at 05:54:03PM +0800, Zqiang a =C3=A9crit :
> >>> For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
> >>> disable local bh in rcuc kthreads will not affect preempt_count(),
> >>> this resulted in the following splat:
> >>>
> >>> WARNING: suspicious RCU usage
> >>> kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> >>> stack backtrace:
> >>> CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> >>> Call Trace:
> >>> [    0.407907]  <TASK>
> >>> [    0.407910]  dump_stack_lvl+0xbb/0xd0
> >>> [    0.407917]  dump_stack+0x14/0x20
> >>> [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> >>> [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> >>> [    0.407939]  rcu_core+0x471/0x900
> >>> [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> >>> [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> >>> [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> >>> [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> >>> [    0.407970]  ? trace_preempt_on+0x54/0x120
> >>> [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> >>> [    0.407982]  kthread+0x40e/0x840
> >>> [    0.407990]  ? __pfx_kthread+0x10/0x10
> >>> [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> >>> [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> >>> [    0.408000]  ? __pfx_kthread+0x10/0x10
> >>> [    0.408006]  ? __pfx_kthread+0x10/0x10
> >>> [    0.408011]  ret_from_fork+0x40/0x70
> >>> [    0.408013]  ? __pfx_kthread+0x10/0x10
> >>> [    0.408018]  ret_from_fork_asm+0x1a/0x30
> >>> [    0.408042]  </TASK>
> >>>
> >>> Currently, triggering an rdp offloaded state change need the
> >>> corresponding rdp's CPU goes offline, and at this time the rcuc
> >>> kthreads has already in parking state. this means the corresponding
> >>> rcuc kthreads can safely read offloaded state of rdp while it's
> >>> corresponding cpu is online.
> >>>
> >>> This commit therefore add rdp->rcu_cpu_kthread_task check for
> >>> Preempt-RT kernels.
> >>>
> >>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >>> ---
> >>>  kernel/rcu/tree_plugin.h | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>> index 003e549f6514..fe728eded36e 100644
> >>> --- a/kernel/rcu/tree_plugin.h
> >>> +++ b/kernel/rcu/tree_plugin.h
> >>> @@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *r=
dp)
> >>>                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> >>>                 (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())=
 &&
> >>>                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
> >>> -               rcu_current_is_nocb_kthread(rdp)),
> >>> +               rcu_current_is_nocb_kthread(rdp) ||
> >>> +               (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> >>> +                current =3D=3D rdp->rcu_cpu_kthread_task)),
> >>
> >> Isn't it safe also on !CONFIG_PREEMPT_RT ?
> >
> > For !CONFIG_PREEMPT_RT and  in rcuc kthreads, it's also safe,
> > but the following check will passed :
> >
> > (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> >           rdp =3D=3D this_cpu_ptr(&rcu_data))
>
> I think the fact that it already passes for !PREEMPT_RT does not matter, =
because
> it simplifies the code so drop the PREEMPT_RT check?
>
> Or will softirq_count() not work? It appears to have special casing for
> PREEMPT_RT's local_bh_disable():
>
> (   ( !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_cou=
nt() )
>    && rdp =3D=3D this_cpu_ptr(&rcu_data))  )

Thank you for Joel's reply,  I also willing to accept such
modifications and resend :) .

Thanks
Zqiang
>
> thanks,
>
> - Joel
>
>
>
>
>
