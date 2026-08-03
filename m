Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEB23507C;
	Mon,  3 Aug 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754157; cv=none; b=QzAB1yEt7qcXrLIngydcLDlF+dAqdfZxE+Dk7zOpq17Wg1tKoF0eZlaoGPzDftbmZNI+iW+kuNMaHvwNRyLUoSCNf7JP1CSrxGBFsuzcOEo/6+H4IlRpG4FXStUoWEvt9Re3b7tx2UiaH4LkgirLnhKROJv76FtyOd747x7JpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754157; c=relaxed/simple;
	bh=hmimg8xsXd/QtfVfDzlsQ4CRosOLGiYScanXA7n4JCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSCuMWCTgwZwwyVXSXloO1wf+6wp5nCrxKXgrvY2SVfi3AGuq7afg3VFAIul5sIVUn/jspUCZaOEQN+oP0AYGuPIqztWlvsEmbQ8o2LNF/WKdJSXdzFmXWaWUdBFmIyeUbB5F7oGUQOpjuVHU922FgO0wE0t/J5Xd0TFcY5B17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KBwXItvE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KBwXItvE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g9WqnLNMdjye3DLyKYpvfuKL17Wp3Um/0jVBX3vTGCU=; b=KBwXItvEvU3uGJMeVWFCutLjd6
	AXcV+2XVbx65d4kSkhQ+XI4s6ntXawn3iYAB/wJqKSfzOIkQIwgzY2lKaU8OBAJh7g366CAEZ/WJO
	07y4e0/8ALicJey9dVrHPxgBR0M4M2fMo29VJT+4l3xpSRbeg45SkTDyaYOgWwFUYvJrnEulet/bU
	4+CDmyzbMAwmcQpb9AI/iFSs1U9+KKt/s1Ce6+WYcfp9MOPC24RmR6iUsamHgj+HgCc9Ompj1z9xV
	UA9De6gcYB38P/nrXx4YPrDlnJaSprnYwUNVRaZbQ4UFBtXLr5r3NcDbKmbZaprNfqkQPjIVo++Ge
	wwpeFKSw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqqEG-00CJ5G-1V;
	Mon, 03 Aug 2026 10:49:08 +0000
Date: Mon, 3 Aug 2026 03:49:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
Message-ID: <anBxXePfyHY2Uz0d@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
 <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
X-Debian-User: leitao

On Sat, Aug 01, 2026 at 05:19:25AM +0000, Zqiang wrote:
> > 
> > Hello Zqiang,
> > 
> > On Thu, Jul 09, 2026 at 06:06:02PM +0800, Zqiang wrote:
> > 
> > > 
> > > In the cleanup_srcu_struct(), when iterating over per-cpu's srcu_data,
> > >  the timer_delete_sync(&sdp->delay_work) is called to cancel the delay
> > >  timer before flush_work(&sdp->work).
> > >  
> > >  However, if the timer_delete_sync() returns 1 means that it successfully
> > >  deleted an pending timer before it had a chance to fire, also means that
> > >  the sdp->work cannot be queued, the subsequent flush_work(&sdp->work)
> > >  will returns immediately without waiting for anything, this causes SRCU
> > >  callbacks to not be processed.
> > >  
> > >  Fix this by checking the return value of timer_delete_sync(), if it
> > >  returns 1, explicitly queue sdp->work so that the following flush_work()
> > >  can correctly wait for the work to complete.
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > >  ---
> > >  kernel/rcu/srcutree.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >  
> > >  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >  index 7c2f7cc131f7..02c322b7c6f1 100644
> > >  --- a/kernel/rcu/srcutree.c
> > >  +++ b/kernel/rcu/srcutree.c
> > >  @@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> > >  for_each_possible_cpu(cpu) {
> > >  struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > >  
> > >  - timer_delete_sync(&sdp->delay_work);
> > >  + //In most scenarios, calling srcu_barrier before cleanup
> > >  + //will not trigger WARN_ON().
> > >  + if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> > >  + rcu_cpu_beenfullyonline(sdp->cpu))
> > >  + queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > > 
> > I started seeing this on my tests, it is not trivial to decode this one,
> > but, I can try harder if _really_ needed.
> >
> 
> The scenario I can think of is that we missed the call to srcu_barrier()
> before cleanup_srcu_struct():
> 
> loop_add()
> ->blk_mq_alloc_tag_set
>     init_srcu_struct(&set->tags_srcu)
> 
>     blk_mq_alloc_set_map_and_rqs() {
>      ->__blk_mq_alloc_rq_maps()
>        ->__blk_mq_alloc_map_and_rqs() return error
>          goto out_unwind: __blk_mq_free_map_and_rqs()
>                           ->blk_mq_free_rq_map()
>                             ->blk_mq_free_tags()
>                               ->call_srcu(&set->tags_srcu, &tags->rcu_head, blk_mq_free_tags_callback);
>     } return error 
>      
>     goto out_free_mq_map:
>          ....
>          cleanup_srcu_struct(&set->tags_srcu)
>          -> trigger WARN_ON(timer_delete_sync(&sdp->delay_work)
> 
> Can you try the following patch?

I tried it, and it does not help -- the WARN still fires at the same rate. I think the analysis points at the wrong call site.

Setup: linux-next-20260731 (arm64), 32 vCPU VM, HZ=1000, PROVE_LOCKING
and DEBUG_OBJECTS_TIMERS enabled, reproducer stress-ng --loop 32
--timeout 60s.

    baseline               3 x WARN srcutree.c:706 in 60s
    + your blk-mq patch    4 x WARN srcutree.c:706 in 60s

  (3 vs 4 is just jitter on a one-jiffy race, not a regression.)

The reason it cannot help is that the splat comes from
blk_mq_free_tag_set(), not from the blk_mq_alloc_tag_set() error path
your patch touches. All four splats in the patched run have the same
trace:

    cleanup_srcu_struct+0x274/0x450 (P)
    blk_mq_free_tag_set+0x1a4/0x1e0
    loop_remove+0x2c/0x78
    loop_control_ioctl+0x248/0x2a0
    __arm64_sys_ioctl+0x9c0/0xb00

I also put a pr_warn() at out_cleanup_tags_srcu: to be sure -- it fired
zero times over the whole run, so loop_add() never takes that error path
in this workload.

Why do you wangt to have this
WARN_ON(timer_delete_sync(&sdp->delay_work)) ?

timer_delete_sync() != 0 means "a timer was armed", not "callbacks are
pending".
