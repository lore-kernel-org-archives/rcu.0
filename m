Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB233290F
	for <rcu@vger.kernel.org>; Tue,  4 Aug 2026 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817058; cv=none; b=SN/lHeyJp8B6NHyCd9K7ZWRqY2o2pYKkrjTnsfH3eTkqS6qACR/fCk7dAE/6R11pGRDeH5ibOu4LKpC7+8ciT+eh7GsgBCbyVV9STOtzQyICnLH/DvMvBpH5JU9tNWasQ5ZYYhS4uEoXkO2O6Qz/hUmYK0TCF3dL9jKvoCDDWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817058; c=relaxed/simple;
	bh=MqbM9UNlhyzuyJt9Za5N4MiwKePy7Vjzy2sY6hcjzLA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=L0mhutvhNydSNk7th+48u3D7gxs6FV+eFqzdT8M9BLbpx91kjMqbFS/jJI1kYaqvtmUHI9DtbmXtB8PK9yYork/qRD5lXHdDZFb9rJ4e2KQ15UnIYh4U8mYc5EHyJJ4JHPd0CsNyBbsSViUGZcX7O/Jh24BIoaYjjva6J6pc3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAaDrhpj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAaDrhpj"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785766262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+dO6hgAV29jKvRPpJhG1CH8RYm0zwH0ZPkuZg8Qwg4=;
	b=vAaDrhpjKLhj9m3m2jbG9NILUA196dJxR8MJFruFHYXfhowbp1oh+dcDl9ImrRiu3owHtm
	meEZUtyxCmO/gqhyHU1I2CDZtRNHFKnfC/IwR1iLuuTXy0v266Qa160m1x0rpYO0X89UF6
	OuwOt4Ie4mRPCV38JpDVY2zbOAE2E/w=
Date: Mon, 03 Aug 2026 14:11:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <68038c37bd588be7df2892e85ec9bab31d20cd34@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
To: "Breno Leitao" <leitao@debian.org>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <anBxXePfyHY2Uz0d@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
 <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
 <anBxXePfyHY2Uz0d@gmail.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Sat, Aug 01, 2026 at 05:19:25AM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> Hello Zqiang,
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
> >=20
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
> >=20
>=20I tried it, and it does not help -- the WARN still fires at the same =
rate. I think the analysis points at the wrong call site.
>=20
>=20Setup: linux-next-20260731 (arm64), 32 vCPU VM, HZ=3D1000, PROVE_LOCK=
ING
> and DEBUG_OBJECTS_TIMERS enabled, reproducer stress-ng --loop 32
> --timeout 60s.
>=20

Thanks=20for provide testing methods, I will also testing it.

>  baseline 3 x WARN srcutree.c:706 in 60s
>  + your blk-mq patch 4 x WARN srcutree.c:706 in 60s
>=20
>=20 (3 vs 4 is just jitter on a one-jiffy race, not a regression.)
>=20
>=20The reason it cannot help is that the splat comes from
> blk_mq_free_tag_set(), not from the blk_mq_alloc_tag_set() error path
> your patch touches. All four splats in the patched run have the same
> trace:
>=20
>=20 cleanup_srcu_struct+0x274/0x450 (P)
>  blk_mq_free_tag_set+0x1a4/0x1e0
>  loop_remove+0x2c/0x78
>  loop_control_ioctl+0x248/0x2a0
>  __arm64_sys_ioctl+0x9c0/0xb00

This may trigger a new srcu grace period again during the window period b=
etween
srcu-barrier() and cleanup_srcu_struct().

>=20
>=20I also put a pr_warn() at out_cleanup_tags_srcu: to be sure -- it fir=
ed
> zero times over the whole run, so loop_add() never takes that error pat=
h
> in this workload.
>=20
>=20Why do you wangt to have this
> WARN_ON(timer_delete_sync(&sdp->delay_work)) ?
>=20
>=20timer_delete_sync() !=3D 0 "a timer was armed", not "callbacks are
> pending".

There are only two types of return values for timer_delete_sync(),
return 0 or 1,  the timer_delete_sync() !=3D 0 means that this timer
was pending and has been deactivated, right?

Thanks
Zqiang



>
