Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23664964E;
	Fri,  9 May 2025 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761547; cv=none; b=EmAM797d3gpNDdIxVB5TMZC9wNSof3o9N+lmrf43r8eF48BQxYSum49WAWNQPjtJ1KhIRCcT7zCXR1mIKsna8NzPC3seQGffQssOK0eJ+YtZKMYTUaHKVqELKALZmX18GntiWlyf1BtjykiABZyKCeb1sZZIG4cUj63FpmJq28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761547; c=relaxed/simple;
	bh=d6w0QC2FkkZmOZZCEXQM8m8PwqeRBreeSkfhxCr/u4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm/OMi0Lk9aDimgQG9DzadTpWb71/cGaZdLEUb/OLj6RScRjfQqKuXePdy40j9imh0m+WENYtB/I0MaEdZclgmAA9xeydRow3xnealr3DiRnA+NPTquytzbJuVO8UYZrecdaLLn0bmXkMG+pKh63GWFay1X3165awy8OaY4oAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp/93uEG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp/93uEG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb3so2049016a91.1;
        Thu, 08 May 2025 20:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746761545; x=1747366345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ya3VczgHFOzFAyCfmPA4Y/mC3C+aSrcJSAyZCyQ9PTE=;
        b=Lp/93uEG7XhmPEaUFgoqkm726yyzsBIlvWj6o89tyAIaQXe+p9qKLYxpaZFBpBY1LL
         kg9bG7aW1cknbFeXyCKyl8Lwbj60QBmlt2FevL9mkUjH0xzy2y4MfdO3+kVjzoq54clv
         sRDKrUX6ngiLCqHNqrcyphoNC7/eVsboJNfXhBLQm8tFbkG2xuuM8TuUrClokGSUawMp
         funHsV23Xw4D40M2T/1QlW07H3Zh4940JNhdU+YEEYR3qG8Hm0ODJJMibxlUBEfwc7qH
         AccK3lgKRC/zdwJQE5ib4phlyy3ivw1dhtSfv1/VVcSSXkBrFpV8EHf48Zg+XTedA5XP
         2wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746761545; x=1747366345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya3VczgHFOzFAyCfmPA4Y/mC3C+aSrcJSAyZCyQ9PTE=;
        b=CmkWKsoOVEkTaw8z5YXAK65sz6huEWBVEIK7d/mmKkxayxN4SgW9gaVI/v98mxnD4f
         +cOsLJGUAoPO9N1Bi5MmZZh1NorJbhxrnPFNuce8QOTax2/pSjMBMAGgQ75gTkOsdOit
         NXfxREjIIIb94Q7FDyBcMePRq85Kl3LOSDaLxPv/5iFyUDowh36wvFFlGHiF0cKusDHb
         4N+/fncKRL5KxzOBAjrwLNpMr2fxgIEzBMOUaIXuEaqbE1jp93o4iojycFZnktld2dRR
         nSjOr57vLZ+Yn0ZcNeGU65tT68nWb8UGayhre+rmPTF84DQkw2KRs0tSiiMLFl/muICp
         a88g==
X-Forwarded-Encrypted: i=1; AJvYcCUJmsCVwEklxtWYuwa1Ky9UtP/I496B0PyxFKVUVJ6E9L8D2Cchnqv6513Y3SNSgF/gqvIXhCxcP/izGNA=@vger.kernel.org, AJvYcCUTjwVhf8hvPxcmGhg1SFzi59wecl80BQ5UsRfUH2gQoaLkThPFPzufLmoN24X2T9fgYT67@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2V4oBntW7gjpMTC0pT2YgOf0DI4MUbd1IkUZ1GFdToHPrkPv
	iQOviv6559CeFqLKmMCoaDCuoqT0BaaK85vePCuy80NREnKuV+If3NQTMOhnSRfpgxHfWE9ACc8
	FhH2hnM+tmnphGndz1F02hZp7dpJDIiJEAKBPuA==
X-Gm-Gg: ASbGncs6OzFdzBBgqmiEKBlVs/HruucHfJq3ywEbkSrLEMQxkYPDEzOt3SCEfi+fTRT
	io1/6Y/XuX/f4d0cuwhExmSzTszejX3h84AWp05PF1bmGuCUcf7sDQk7/TbVnxS9qdMLQJfrC3r
	//FQkVVfhN59IAtYqvcVVWV1o=
X-Google-Smtp-Source: AGHT+IGkXZFfrhbbd9BDItKA19ojDn/Iq3UrEv99hYGe8s2qyWB7NaatQnPLlDrpk1mRSaGA7fwLYogJ7Oi+heTJ6rE=
X-Received: by 2002:a17:90b:1c04:b0:309:f53c:b0a0 with SMTP id
 98e67ed59e1d1-30c3d63c365mr3229519a91.24.1746761544735; Thu, 08 May 2025
 20:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com> <b23a7caa-a548-4691-badc-4122907ea688@paulmck-laptop>
In-Reply-To: <b23a7caa-a548-4691-badc-4122907ea688@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 9 May 2025 11:32:13 +0800
X-Gm-Features: ATxdqUEaHndYcsUJJ2F87_gkE4VhxDkaNZ05UxRfazcxVWKhdmGnLLq18puEOUM
Message-ID: <CALm+0cU8ndBcXsR_F1_XPcnb7+yvNoOynD7ucuZ6FfxAygDwqA@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, May 07, 2025 at 07:26:05PM +0800, Zqiang wrote:
> > In the preparation stage of CPU online, if the corresponding
> > the rdp's->nocb_cb_kthread does not exist, will be created,
> > there is a situation where the rdp's rcuop kthreads creation fails,
> > and then de-offload this CPU's rdp, does not assign this CPU's
> > rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> > rdp's->rdp_gp->nocb_gp_kthread is still valid.
> >
> > This will cause the subsequent re-offload operation of this offline
> > CPU, which will pass the conditional check and the kthread_unpark()
> > will access invalid rdp's->nocb_cb_kthread pointer.
> >
> > This commit therefore use rdp's->nocb_gp_kthread instead of
> > rdp_gp's->nocb_gp_kthread for safety check.
>
> Let's see...
>
> The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions invoke
> cpus_read_lock(), and thus exclude all the CPU-hotplug notifiers,
> including the one that invokes rcutree_prepare_cpu().  There is also
> rcu_spawn_gp_kthread(), but that is an early_initcall() that happens
> before CPU hotplug can happen, at least for non-boot CPUs.
>
> So rcu_spawn_cpu_nocb_kthread() cannot run concurrently with either
> rcu_nocb_cpu_offload() or rcu_nocb_cpu_deoffload(), correct?

Yes, the rcutree_prepare_cpu() is invoked under the cpus_write_lock()
protection.

>
> It appears that all CPUs (try to) create their rcuoc and rcuog kthreads
> when they come online, regardless of the nohz_full and rcu_nocbs kernel
> boot parameters, some old tree_nocb.h comments notwithstanding.  ;-) The
> rcu_organize_nocb_kthreads() function looks to cover all CPUs as well,
> so ->nocb_gp_rdp will always be set after very early boot (give or take
> alloc_bootmem_cpumask_var() failure in rcu_nocb_setup() and checked for
> by the cpumask_available() in rcu_organize_nocb_kthreads()).
>
> The rcu_spawn_cpu_nocb_kthread() can fail to spawn the GP kthread,
> in which case both ->nocb_cb_kthread and ->nocb_gp_kthread remain
> NULL.

This is a low probability event, but it is possible, if this happens,
and we test it with rcutorture configured with parameters
nocbs_toggle and onoff_interval, it will trigger a null ptr access.

Thanks
Zqiang


>
> If so, LGTM.
>
>                                                         Thanx, Paul
>
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 1596812f7f12..6679140bb0b5 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
> >  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> >  {
> >       int wake_gp;
> > -     struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> >
> >       WARN_ON_ONCE(cpu_online(rdp->cpu));
> >       /*
> > @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> >       if (!rdp->nocb_gp_rdp)
> >               return -EINVAL;
> >
> > -     if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> > +     if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
> >               return -EINVAL;
> >
> >       pr_info("Offloading %d\n", rdp->cpu);
> > @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> >
> >       wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
> >       if (wake_gp)
> > -             wake_up_process(rdp_gp->nocb_gp_kthread);
> > +             wake_up_process(rdp->nocb_gp_kthread);
> >
> >       swait_event_exclusive(rdp->nocb_state_wq,
> >                             rcu_nocb_rdp_offload_wait_cond(rdp));
> > --
> > 2.17.1
> >
