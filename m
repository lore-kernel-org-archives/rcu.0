Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263A33688B
	for <rcu@vger.kernel.org>; Tue,  4 Aug 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817380; cv=none; b=BewKP+pnKakpi4ubwIoCyuK6YnsqlPX8Sz+XNPFfVIZiQ/PlaEQ8rs0hIVUAgCXGf7+kNENopr7N7PQKK7dGP3C4a4y0Zk4QFIPbkrFFibb7xyBc6X6u2eLx8MzlQ8afXChBlcIlCTmkkhYUQ5RYx48OOLElB2cGpzTetw/nt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817380; c=relaxed/simple;
	bh=aNaPKwydUOsA/YLfI9XhsV1FNwwjl+6Lq2jdNyODsZU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=IwGOGadqlpmvraZHgTcquMPPgYHcTX6mJiv52qhGIE12/3HWP7FxCYtBWReym+ZBbbOJrq0nr6xZEtuNrmOGFtm/mGlwGNeq2jMIl03P50xxGJ1tUMSWbZaBnJWLFnuRGu3SqpzUhfHXyKh45lrVmk7p/GC7i0EAzuJ0x6SWvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G12/2ZZF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G12/2ZZF"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785800417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpsgPSjIUVjEZUf1eeSA8Mkha57e+4YYv5a0TrNZ9Zw=;
	b=G12/2ZZF5WaZDBPAK6r3A2rCb5bc7l5loqiak/HBN/vA+QlYtN6jaR3psEHRjUH+e7plK2
	WQ3EvyG21BKMm/Ahp4W/pHrJijR9QJ/KMhlqHKlPgRHu+BYDG215RgXQ57yJ/4qBPfiX2b
	4R0Leu6PRoDNA6TVpSyFFlx4SdCmWSM=
Date: Mon, 03 Aug 2026 23:40:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <96d6edfce3ac43e153a21b23994251ede0fbd7f4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
To: "Breno Leitao" <leitao@debian.org>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e3738457818909e56c8aa5aef99d8b3e26a328d3@linux.dev>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
 <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
 <anBxXePfyHY2Uz0d@gmail.com>
 <68038c37bd588be7df2892e85ec9bab31d20cd34@linux.dev>
 <e3738457818909e56c8aa5aef99d8b3e26a328d3@linux.dev>
X-Migadu-Flow: FLOW_OUT

>=20
>=20>=20
>=20> On Sat, Aug 01, 2026 at 05:19:25AM +0000, Zqiang wrote:
> >=20=20
>=20>=20=20
>=20>  Hello Zqiang,
> >=20=20
>=20>  On Thu, Jul 09, 2026 at 06:06:02PM +0800, Zqiang wrote:
> >=20=20
>=20>  >=20
>=20>  > In the cleanup_srcu_struct(), when iterating over per-cpu's srcu=
_data,
> >  > the timer_delete_sync(&sdp->delay_work) is called to cancel the de=
lay
> >  > timer before flush_work(&sdp->work).
> >  >=20
>=20>  > However, if the timer_delete_sync() returns 1 means that it succ=
essfully
> >  > deleted an pending timer before it had a chance to fire, also mean=
s that
> >  > the sdp->work cannot be queued, the subsequent flush_work(&sdp->wo=
rk)
> >  > will returns immediately without waiting for anything, this causes=
 SRCU
> >  > callbacks to not be processed.
> >  >=20
>=20>  > Fix this by checking the return value of timer_delete_sync(), if=
 it
> >  > returns 1, explicitly queue sdp->work so that the following flush_=
work()
> >  > can correctly wait for the work to complete.
> >  >=20
>=20>  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  > ---
> >  > kernel/rcu/srcutree.c | 6 +++++-
> >  > 1 file changed, 5 insertions(+), 1 deletion(-)
> >  >=20
>=20>  > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  > index 7c2f7cc131f7..02c322b7c6f1 100644
> >  > --- a/kernel/rcu/srcutree.c
> >  > +++ b/kernel/rcu/srcutree.c
> >  > @@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *=
ssp)
> >  > for_each_possible_cpu(cpu) {
> >  > struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> >  >=20
>=20>  > - timer_delete_sync(&sdp->delay_work);
> >  > + //In most scenarios, calling srcu_barrier before cleanup
> >  > + //will not trigger WARN_ON().
> >  > + if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> >  > + rcu_cpu_beenfullyonline(sdp->cpu))
> >  > + queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> >  >=20
>=20>  I started seeing this on my tests, it is not trivial to decode thi=
s one,
> >  but, I can try harder if _really_ needed.
> >=20=20
>=20>=20=20
>=20>  The scenario I can think of is that we missed the call to srcu_bar=
rier()
> >  before cleanup_srcu_struct():
> >=20=20
>=20>  loop_add()
> >  ->blk_mq_alloc_tag_set
> >  init_srcu_struct(&set->tags_srcu)
> >=20=20
>=20>  blk_mq_alloc_set_map_and_rqs() {
> >  ->__blk_mq_alloc_rq_maps()
> >  ->__blk_mq_alloc_map_and_rqs() return error
> >  goto out_unwind: __blk_mq_free_map_and_rqs()
> >  ->blk_mq_free_rq_map()
> >  ->blk_mq_free_tags()
> >  ->call_srcu(&set->tags_srcu, &tags->rcu_head, blk_mq_free_tags_callb=
ack);
> >  } return error=20
>=20>=20=20
>=20>  goto out_free_mq_map:
> >  ....
> >  cleanup_srcu_struct(&set->tags_srcu)
> >  -> trigger WARN_ON(timer_delete_sync(&sdp->delay_work)
> >=20=20
>=20>  Can you try the following patch?
> >=20=20
>=20>  I tried it, and it does not help -- the WARN still fires at the sa=
me rate. I think the analysis points at the wrong call site.
> >=20=20
>=20>  Setup: linux-next-20260731 (arm64), 32 vCPU VM, HZ=3D1000, PROVE_L=
OCKING
> >  and DEBUG_OBJECTS_TIMERS enabled, reproducer stress-ng --loop 32
> >  --timeout 60s.
> >=20=20
>=20>  Thanks for provide testing methods, I will also testing it.
> >=20=20
>=20>=20=20
>=20>  baseline 3 x WARN srcutree.c:706 in 60s
> >  + your blk-mq patch 4 x WARN srcutree.c:706 in 60s
> >=20=20
>=20>  (3 vs 4 is just jitter on a one-jiffy race, not a regression.)
> >=20=20
>=20>  The reason it cannot help is that the splat comes from
> >  blk_mq_free_tag_set(), not from the blk_mq_alloc_tag_set() error pat=
h
> >  your patch touches. All four splats in the patched run have the same
> >  trace:
> >=20=20
>=20>  cleanup_srcu_struct+0x274/0x450 (P)
> >  blk_mq_free_tag_set+0x1a4/0x1e0
> >  loop_remove+0x2c/0x78
> >  loop_control_ioctl+0x248/0x2a0
> >  __arm64_sys_ioctl+0x9c0/0xb00
> >=20=20
>=20>  This may trigger a new srcu grace period again during the window p=
eriod between
> >  srcu-barrier() and cleanup_srcu_struct().
> >=20=20
>=20>=20=20
>=20>  I also put a pr_warn() at out_cleanup_tags_srcu: to be sure -- it =
fired
> >  zero times over the whole run, so loop_add() never takes that error =
path
> >  in this workload.
> >=20=20
>=20>  Why do you wangt to have this
> >  WARN_ON(timer_delete_sync(&sdp->delay_work)) ?
> >=20=20
>=20>  timer_delete_sync() !=3D 0 "a timer was armed", not "callbacks are
> >  pending".
> >=20=20
>=20>  There are only two types of return values for timer_delete_sync(),
> >  return 0 or 1, the timer_delete_sync() !=3D 0 means that this timer
> >  was pending and has been deactivated, right?
> >=20
>=20How about this?
>=20
>=20diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index b9fe57ff9100..62da31ec2bd0 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -751,7 +751,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>=20
>=20 // Call srcu_barrier() before this cleanup_srcu_struct()
>  // to avoid triggering this WARN_ON().
> - if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> + if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist) &&
> + timer_delete_sync(&sdp->delay_work)) &&
>  rcu_cpu_beenfullyonline(sdp->cpu))
>  queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>  flush_work(&sdp->work);

Please ignore this change, this is my mistake.

There is a scenario where the 'rcu_segcblist_n_cbs(&sdp->srcu_cblist) =3D=
=3D 0'
srcu_barrier() cannot intercept.=20
however,=20for sup->srcu_size_state being  between SRCU_SIZE_WAIT_BARRIER=
 and
SRCU_SIZE_BIG, we will queue sdp->delay_work for all CPUs belonging to th=
e
leaf SRCU node, regardless of whether there is a callback on the current
CPU's sdp->srcu_cblist in srcu_gp_end().=20

so=20the timer_delete_sync(&sdp->delay_work) should be called uncondition=
ally.
to ensure that the timer callback has ended or the timer which in pending
status has been successfully deleted.

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b9fe57ff9100..d13c12f61150 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -751,8 +751,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)

                // Call srcu_barrier() before this cleanup_srcu_struct()
                // to avoid triggering this WARN_ON().
-               if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
-                                       rcu_cpu_beenfullyonline(sdp->cpu)=
)
+               if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
+                       rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+                               rcu_cpu_beenfullyonline(sdp->cpu))
                        queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
                flush_work(&sdp->work);
                if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))



Thanks
Zqiang






>=20
>=20Thanks
> Zqiang
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >
>
