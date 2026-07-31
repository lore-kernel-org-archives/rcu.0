Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826644606A;
	Fri, 31 Jul 2026 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519967; cv=none; b=TaF9Gn8l3JuK+3k2uJ+vQD0rYQ24dZxz/XwQL408LH+v32yh1uXkqPuDGt4KM+XF5PamjwuNr/hlt33RYAi8xNhOSiFpntGUqXCo82UNGqpHcAwte3wktqX+xKBOexY6/U5PUV+Xw89YV0qHm3En6QUVeO3BMsNUUuo8emM0X9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519967; c=relaxed/simple;
	bh=E8GbfTK4jYzSVrrPrktZPc2gGB0GxAKAuonOv+GCqf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdt1cAIK/2JDb9FasqW8WBKRGpBm0D0XAgM+e63xQOTHJYB18MK60jMjz8ZnjR1d69BiJ5MZySvbhl7J9u4Qt9h9I2tAwUX/+l9MJeIuTKeQQUdx5r+OKF5y0Dqyain74/ijqE2anipjXF5gnMsDcsLXNw/IFnqsPB/q2nkj5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qWUNMVQ2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qWUNMVQ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1cyP0g1IYzdHkjLS0GOwgZb8r8AIfzKv5ky9GYAbfhc=; b=qWUNMVQ29GiQV2ldHDgHAbFWMJ
	UVRrlDG88qQmSAA8miF2IYfx0DnUru7wAmG1lv9rv6J+NjlSFFuj9llKdlFgvkHrZg+WT4swffRXW
	/MGpiWYohN8Zn7+UueEUzQjnip9SWdQ+GtWs1D24P81kuyeuhygqHyHwbiutHcYlu6sBVCLu6KnS3
	u9AdYZ79UelseiS260qdZkZOVUZwjXF/U31c5pLBXnpu/4QeyNdVBM2m26xEaJ1WCx0FYP2IwvtLF
	3RIPXRU2EpD1oGLzSMVdmjwRjEXg6e0JdAUvDXT+OiNeTNBbifsfoXP6Flac+gaeUKyRqiszGzhEN
	MmhcbOKQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wprIz-00ACFB-0r;
	Fri, 31 Jul 2026 17:45:57 +0000
Date: Fri, 31 Jul 2026 10:45:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
Message-ID: <amzfBSSGyVF0vyQ9@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100602.821-1-qiang.zhang@linux.dev>
X-Debian-User: leitao

Hello Zqiang,

On Thu, Jul 09, 2026 at 06:06:02PM +0800, Zqiang wrote:
> In the cleanup_srcu_struct(), when iterating over per-cpu's srcu_data,
> the timer_delete_sync(&sdp->delay_work) is called to cancel the delay
> timer before flush_work(&sdp->work).
> 
> However, if the timer_delete_sync() returns 1 means that it successfully
> deleted an pending timer before it had a chance to fire, also means that
> the sdp->work cannot be queued, the subsequent flush_work(&sdp->work)
> will returns immediately without waiting for anything, this causes SRCU
> callbacks to not be processed.
> 
> Fix this by checking the return value of timer_delete_sync(), if it
> returns 1, explicitly queue sdp->work so that the following flush_work()
> can correctly wait for the work to complete.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/rcu/srcutree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7..02c322b7c6f1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		timer_delete_sync(&sdp->delay_work);
> +		//In most scenarios, calling srcu_barrier before cleanup
> +		//will not trigger WARN_ON().
> +		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> +					rcu_cpu_beenfullyonline(sdp->cpu))
> +			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);

I started seeing this on my tests, it is not trivial to decode this one,
but, I can try harder if _really_ needed.

 07:11:44  Invalid logical block size (65535)
           Invalid logical block size (256)
 07:11:45  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x408/0x7e8, CPU#50: stress-ng-loop/1233713  ^[[36m[warn]^[[0m
           Modules linked in: sch_htb(E) cls_u32(E) cls_cgroup(E) cls_basic(E) act_police(E) act_mirred(E) act_bpf(E) sch_fq(E) br_netfilter(E) udp_diag(E) i
           CPU: 50 UID: 0 PID: 1233713 Comm: stress-ng-loop Kdump: loaded Tainted: G            E       7.2.0-rc5-next-20260730upstream-baseline #1 PREEMPT(f
           Tainted: [E]=UNSIGNED_MODULE
           pstate: 03401009 (nzcv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
           pc : cleanup_srcu_struct+0x408/0x7e8
           lr : cleanup_srcu_struct+0x3dc/0x7e8
           sp : ffff800150357b30
           x29: ffff800150357b50 x28: fffffdffbdb51c40 x27: 0000000000000000
           x26: dfff800000000000 x25: 1fffe000202daa5f x24: ffff800083bbb010
           x23: ffff800083f67210 x22: ffff0001016d52f8 x21: 00007dc98b656c40
           x20: 1ffff000107ece42 x19: 0000000000000003 x18: 1fffe006d6db3f20
           x17: 0000000000000000 x16: ffff800083f67000 x15: 0000000000000001
           x14: 1fffe006d6db6388 x13: 0000000000000000 x12: 0000000000000000
           x11: 0000000000000003 x10: fffffdffbdb51e40 x9 : dfff800000000000
           x8 : 0000000100000000 x7 : 0000000000000000 x6 : ffff80008148f060
           x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000010
           x2 : ffff800150357a60 x1 : ffff80008036827c x0 : 0000000000000001
           Call trace:
            cleanup_srcu_struct+0x408/0x7e8 (P)
            blk_mq_free_tag_set+0x4b4/0x5f0
            loop_remove+0x50/0xd8 [loop]
            loop_control_ioctl+0x340/0x438 [loop]
            __arm64_sys_ioctl+0xc04/0x1310
            invoke_syscall+0x74/0x188
            do_el0_svc+0x10c/0x198
            el0_svc+0x64/0x260
            el0t_64_sync_handler+0x84/0x130
            el0t_64_sync+0x198/0x1a0
           irq event stamp: 0
           hardirqs last  enabled at (0): [<0000000000000000>] 0x0
           hardirqs last disabled at (0): [<ffff800080100734>] copy_process+0x109c/0x31e8
           softirqs last  enabled at (0): [<ffff800080100760>] copy_process+0x10c8/0x31e8
           softirqs last disabled at (0): [<0000000000000000>] 0x0
           ---[ end trace 0000000000000000 ]---

