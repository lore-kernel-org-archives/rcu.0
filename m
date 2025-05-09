Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA11372;
	Fri,  9 May 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762333; cv=none; b=sh58U++8LR/ThS7KVap9LdyBGzlrcHFBE80ASJP0CKCTOee3LBKz2lsu3qDxstQUSsgSGmf2S6d30VLO49wnmGcFQV3MBmPg2h+mzAJ2EkWcJjH0m8TbcGngQhAu97nptXWnRdNgRf9OCyBQRO01p8jF46SiR13yNrdNmjE2+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762333; c=relaxed/simple;
	bh=/4kk68aDZro+woff7rjU8dPy7UepG7EyDgvaFIt4Zxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqfNU4igp6mGKsIFc3OONDYnRFSCpDiiXvsSyNuuaboLZVpJIwmx2owq+drxpg1lRfOrAvIX8s7ev7uKKida+A5hqIbi6YIwKX3fYfazITG4Wr3GpL9c/rQc4otlkAqg4nveIK9t5rbhG7f5B/tWxUBEzOreLg415WxFjnZy/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Ye6Tsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Ye6Tsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F41C4CEE4;
	Fri,  9 May 2025 03:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746762333;
	bh=/4kk68aDZro+woff7rjU8dPy7UepG7EyDgvaFIt4Zxo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C/Ye6TsdmqLnhCfyNEFp0qanKHaJxie+uMAAoH9mu801IC+Zp5DI4/Irg/pZrqY9T
	 vMADV75iOADsKKvk+m/jxIGOe4eYqrpdO1JgbzAqCX/Vv43h+X05YcJSb8WzpwW/zN
	 kDcNdrulhD4qsvUx2QDhZsiWgBOrjxeXs3oclj2kqmF4B2imJnVINc0hCmWW9rfjHu
	 FT1RU983zPL1GpIPuopSPxP9F6rbUKlsjyffov8mstpDIEW7vxYrXYTXUVOjnKDyNz
	 w6ZuChBWaJACl5+5LsUhHOjL2pI97CJ+NEtrpXa+1C+AJj0KDibaAPArGKQ4WkfkBf
	 8QdIDNxisllPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CE942CE11A4; Thu,  8 May 2025 20:45:32 -0700 (PDT)
Date: Thu, 8 May 2025 20:45:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
Message-ID: <625640fd-80bf-4357-8734-5ee87540fea8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com>
 <b23a7caa-a548-4691-badc-4122907ea688@paulmck-laptop>
 <CALm+0cU8ndBcXsR_F1_XPcnb7+yvNoOynD7ucuZ6FfxAygDwqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cU8ndBcXsR_F1_XPcnb7+yvNoOynD7ucuZ6FfxAygDwqA@mail.gmail.com>

On Fri, May 09, 2025 at 11:32:13AM +0800, Z qiang wrote:
> >
> > On Wed, May 07, 2025 at 07:26:05PM +0800, Zqiang wrote:
> > > In the preparation stage of CPU online, if the corresponding
> > > the rdp's->nocb_cb_kthread does not exist, will be created,
> > > there is a situation where the rdp's rcuop kthreads creation fails,
> > > and then de-offload this CPU's rdp, does not assign this CPU's
> > > rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> > > rdp's->rdp_gp->nocb_gp_kthread is still valid.
> > >
> > > This will cause the subsequent re-offload operation of this offline
> > > CPU, which will pass the conditional check and the kthread_unpark()
> > > will access invalid rdp's->nocb_cb_kthread pointer.
> > >
> > > This commit therefore use rdp's->nocb_gp_kthread instead of
> > > rdp_gp's->nocb_gp_kthread for safety check.
> >
> > Let's see...
> >
> > The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions invoke
> > cpus_read_lock(), and thus exclude all the CPU-hotplug notifiers,
> > including the one that invokes rcutree_prepare_cpu().  There is also
> > rcu_spawn_gp_kthread(), but that is an early_initcall() that happens
> > before CPU hotplug can happen, at least for non-boot CPUs.
> >
> > So rcu_spawn_cpu_nocb_kthread() cannot run concurrently with either
> > rcu_nocb_cpu_offload() or rcu_nocb_cpu_deoffload(), correct?
> 
> Yes, the rcutree_prepare_cpu() is invoked under the cpus_write_lock()
> protection.

Very good!

> > It appears that all CPUs (try to) create their rcuoc and rcuog kthreads
> > when they come online, regardless of the nohz_full and rcu_nocbs kernel
> > boot parameters, some old tree_nocb.h comments notwithstanding.  ;-) The
> > rcu_organize_nocb_kthreads() function looks to cover all CPUs as well,
> > so ->nocb_gp_rdp will always be set after very early boot (give or take
> > alloc_bootmem_cpumask_var() failure in rcu_nocb_setup() and checked for
> > by the cpumask_available() in rcu_organize_nocb_kthreads()).
> >
> > The rcu_spawn_cpu_nocb_kthread() can fail to spawn the GP kthread,
> > in which case both ->nocb_cb_kthread and ->nocb_gp_kthread remain
> > NULL.
> 
> This is a low probability event, but it is possible, if this happens,
> and we test it with rcutorture configured with parameters
> nocbs_toggle and onoff_interval, it will trigger a null ptr access.

Understood, and that might be another patch if you would like to
persue it.

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> > If so, LGTM.
> >
> >                                                         Thanx, Paul
> >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 1596812f7f12..6679140bb0b5 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
> > >  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> > >  {
> > >       int wake_gp;
> > > -     struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> > >
> > >       WARN_ON_ONCE(cpu_online(rdp->cpu));
> > >       /*
> > > @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> > >       if (!rdp->nocb_gp_rdp)
> > >               return -EINVAL;
> > >
> > > -     if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> > > +     if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
> > >               return -EINVAL;
> > >
> > >       pr_info("Offloading %d\n", rdp->cpu);
> > > @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> > >
> > >       wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
> > >       if (wake_gp)
> > > -             wake_up_process(rdp_gp->nocb_gp_kthread);
> > > +             wake_up_process(rdp->nocb_gp_kthread);
> > >
> > >       swait_event_exclusive(rdp->nocb_state_wq,
> > >                             rcu_nocb_rdp_offload_wait_cond(rdp));
> > > --
> > > 2.17.1
> > >
