Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EB343D85
	for <rcu@vger.kernel.org>; Sat,  1 Aug 2026 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561575; cv=none; b=I6SOoFFdj9jkaq1VjPb/joLZOaAapeqDw7cDpSzgtd9uJVxtDiaTwsyrGBpkEcNcqS4CwgZYDnb61BUuWhFvjkjdMqxxlo5jTMyya5HCHAuufgEVvRKW0hZz/CiDp1DeWALRs46W6nD+wsMj9dcCicTHwKSkPQu6ytFtuAFINus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561575; c=relaxed/simple;
	bh=BfzQGaOP0tuHOb6ue8oxF+k5xIUPZY3fK2LDTc0O+z0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=auA/LdlSBAPJFmRLxW7PJOgtdoFc+cv9fdywhT02CFvRh4WaNM5V4StpWQIT8sKV3sErksu7gmhr3CS8S5dE4rz/Jq5kZ2IFhx2WxJXqtrG4A9CFLs0fdV8awhyQuk49dEUJ4tg1kjSrNG3eci+IQkw3KJKTAjv4NOXO+tu5hGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A5oGCuzH; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A5oGCuzH"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785561568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtVgxrsMN4DU1PUcj/Wk10AemozB39llsKS1/lc7VH4=;
	b=A5oGCuzHatv3aG6mUdHCBUNOyByRwG7remutlrCcnAGA1opBHDa8MvuguH7QWIK6OLLBT4
	UsFaJwfWVbX44QxGLfrc412BrpoGVICbC0yNrYjThPAS0urvfQo8b7wcX0r0JhreXXtaHp
	ZgwbpUhA7+rn1r7WhX5dsgZnKgnMVVA=
Date: Sat, 01 Aug 2026 05:19:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
To: "Breno Leitao" <leitao@debian.org>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <amzfBSSGyVF0vyQ9@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Hello Zqiang,
>=20
>=20On Thu, Jul 09, 2026 at 06:06:02PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> In the cleanup_srcu_struct(), when iterating over per-cpu's srcu_da=
ta,
> >  the timer_delete_sync(&sdp->delay_work) is called to cancel the dela=
y
> >  timer before flush_work(&sdp->work).
> >=20=20
>=20>  However, if the timer_delete_sync() returns 1 means that it succes=
sfully
> >  deleted an pending timer before it had a chance to fire, also means =
that
> >  the sdp->work cannot be queued, the subsequent flush_work(&sdp->work=
)
> >  will returns immediately without waiting for anything, this causes S=
RCU
> >  callbacks to not be processed.
> >=20=20
>=20>  Fix this by checking the return value of timer_delete_sync(), if i=
t
> >  returns 1, explicitly queue sdp->work so that the following flush_wo=
rk()
> >  can correctly wait for the work to complete.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  kernel/rcu/srcutree.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  index 7c2f7cc131f7..02c322b7c6f1 100644
> >  --- a/kernel/rcu/srcutree.c
> >  +++ b/kernel/rcu/srcutree.c
> >  @@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *ss=
p)
> >  for_each_possible_cpu(cpu) {
> >  struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> >=20=20
>=20>  - timer_delete_sync(&sdp->delay_work);
> >  + //In most scenarios, calling srcu_barrier before cleanup
> >  + //will not trigger WARN_ON().
> >  + if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> >  + rcu_cpu_beenfullyonline(sdp->cpu))
> >  + queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> >=20
>=20I started seeing this on my tests, it is not trivial to decode this o=
ne,
> but, I can try harder if _really_ needed.
>

The scenario I can think of is that we missed the call to srcu_barrier()
before cleanup_srcu_struct():

loop_add()
->blk_mq_alloc_tag_set
    init_srcu_struct(&set->tags_srcu)

    blk_mq_alloc_set_map_and_rqs() {
     ->__blk_mq_alloc_rq_maps()
       ->__blk_mq_alloc_map_and_rqs() return error
         goto out_unwind: __blk_mq_free_map_and_rqs()
                          ->blk_mq_free_rq_map()
                            ->blk_mq_free_tags()
                              ->call_srcu(&set->tags_srcu, &tags->rcu_hea=
d, blk_mq_free_tags_callback);
    } return error=20
=20=20=20=20=20
=20   goto out_free_mq_map:
         ....
         cleanup_srcu_struct(&set->tags_srcu)
         -> trigger WARN_ON(timer_delete_sync(&sdp->delay_work)

Can you try the following patch?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c850330a32b..6eaea75d0363 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4925,6 +4925,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set=
)
        kfree(set->tags);
        set->tags =3D NULL;
 out_cleanup_tags_srcu:
+       srcu_barrier(&set->tags_srcu);
        cleanup_srcu_struct(&set->tags_srcu);
 out_cleanup_srcu:
        if (set->flags & BLK_MQ_F_BLOCKING)



Thanks
Zqiang


>=20
>=20 07:11:44 Invalid logical block size (65535)
>  Invalid logical block size (256)
>  07:11:45 WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x4=
08/0x7e8, CPU#50: stress-ng-loop/1233713 ^[[36m[warn]^[[0m
>  Modules linked in: sch_htb(E) cls_u32(E) cls_cgroup(E) cls_basic(E) ac=
t_police(E) act_mirred(E) act_bpf(E) sch_fq(E) br_netfilter(E) udp_diag(E=
) i
>  CPU: 50 UID: 0 PID: 1233713 Comm: stress-ng-loop Kdump: loaded Tainted=
: G E 7.2.0-rc5-next-20260730upstream-baseline #1 PREEMPT(f
>  Tainted: [E]=3DUNSIGNED_MODULE
>  pstate: 03401009 (nzcv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=3D--)
>  pc : cleanup_srcu_struct+0x408/0x7e8
>  lr : cleanup_srcu_struct+0x3dc/0x7e8
>  sp : ffff800150357b30
>  x29: ffff800150357b50 x28: fffffdffbdb51c40 x27: 0000000000000000
>  x26: dfff800000000000 x25: 1fffe000202daa5f x24: ffff800083bbb010
>  x23: ffff800083f67210 x22: ffff0001016d52f8 x21: 00007dc98b656c40
>  x20: 1ffff000107ece42 x19: 0000000000000003 x18: 1fffe006d6db3f20
>  x17: 0000000000000000 x16: ffff800083f67000 x15: 0000000000000001
>  x14: 1fffe006d6db6388 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000003 x10: fffffdffbdb51e40 x9 : dfff800000000000
>  x8 : 0000000100000000 x7 : 0000000000000000 x6 : ffff80008148f060
>  x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000010
>  x2 : ffff800150357a60 x1 : ffff80008036827c x0 : 0000000000000001
>  Call trace:
>  cleanup_srcu_struct+0x408/0x7e8 (P)
>  blk_mq_free_tag_set+0x4b4/0x5f0
>  loop_remove+0x50/0xd8 [loop]
>  loop_control_ioctl+0x340/0x438 [loop]
>  __arm64_sys_ioctl+0xc04/0x1310
>  invoke_syscall+0x74/0x188
>  do_el0_svc+0x10c/0x198
>  el0_svc+0x64/0x260
>  el0t_64_sync_handler+0x84/0x130
>  el0t_64_sync+0x198/0x1a0
>  irq event stamp: 0
>  hardirqs last enabled at (0): [<0000000000000000>] 0x0
>  hardirqs last disabled at (0): [<ffff800080100734>] copy_process+0x109=
c/0x31e8
>  softirqs last enabled at (0): [<ffff800080100760>] copy_process+0x10c8=
/0x31e8
>  softirqs last disabled at (0): [<0000000000000000>] 0x0
>  ---[ end trace 0000000000000000 ]---
>
