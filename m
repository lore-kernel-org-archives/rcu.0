Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CE28B7CD;
	Wed,  7 May 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635486; cv=none; b=rcf0YOb2waemIdIHHYo1VHetF2LLmKldMTVq0dvLPfD6IJf2y4mgDYEK6k6r4xE3iqfmFvbm7F2G0FEK7SaGxV2ygXqLPUl3JII/EhYRUSTfSIRWeXkTd+aiQat+8qltdxL1wk4cyEJ5NksjWqM99+dNSbJfdENrshWiRO+m648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635486; c=relaxed/simple;
	bh=TlSIndUGwwBydlnSwSdtYNA0hIlK9V8Mv94OepnzT4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih/Olz5B749c9yHLdPfcEbUR/kPTkIDtqIFNX2qEc9hALMB6xLw4IdihC1PJfRz0pBfH3KDlvh/vfANrN88ElF63Mgnz2EOkROUDAZ+LwwwN+IakhyZxQ29NkXQbpAokTXP9mM545B9+YLFB8AohenBpKZ9oVmmfSC45d/3C6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpi0Hlbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpi0Hlbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C5EC4CEE2;
	Wed,  7 May 2025 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746635486;
	bh=TlSIndUGwwBydlnSwSdtYNA0hIlK9V8Mv94OepnzT4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lpi0HlbkI5FAe47DHdgMIifQpEKjewdjKr16jROVTBsCh93c3pYDTq2aHielItXXy
	 FlwPPfNAd3yqmd6cho17HyeJJ7e3KM0B+IJzsIBI9O51Fp4/9PVTJBnWmanPr4XKb9
	 Owjh63RGAX12S2tDHmbxt2HJPYL/lYP5xkpPk5zhcJOzbaqeFHtwaJ6TX8RseDHpJs
	 btw0C5U0ZT27sEVSDMw1Bp7Xuj7F6zOHgGE67ZYxTkYvwzdzFC43V7ot99KDpILxs1
	 Uy1f9PZI4fLOOV1sQ4KXhu9nbvqVYNPExGZhceTU/2nZuJEcx7bgq4QJtXkTDgEEvL
	 IhneeKJszWYIA==
Date: Wed, 7 May 2025 18:31:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
Message-ID: <aBuK29q6nuhTgHIq@localhost.localdomain>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
 <b242ab38-c488-450c-9735-11e1b666106c@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b242ab38-c488-450c-9735-11e1b666106c@nvidia.com>

Le Wed, May 07, 2025 at 12:06:29PM -0400, Joel Fernandes a écrit :
> 
> 
> On 5/7/2025 7:26 AM, Zqiang wrote:
> > For built with CONFIG_PROVE_RCU=y and CONFIG_PREEMPT_RT=y kernels,
> > Disable BH does not change the SOFTIRQ corresponding bits in
> > preempt_count(), but change current->softirq_disable_cnt, this
> > resulted in the following splat:
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
> > This commit therefore add softirq_count() check for
> > Preempt-RT kernels.
> > 
> > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 003e549f6514..a91b2322a0cd 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> >  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> >  		  lockdep_is_held(&rdp->nocb_lock) ||
> >  		  lockdep_is_held(&rcu_state.nocb_mutex) ||
> > -		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
> > +		  ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count()) &&
> >  		   rdp == this_cpu_ptr(&rcu_data)) ||
> This looks good to me. Frederic told me he'll further review and give final
> green signal. Then I'll pull this particular one.
> 
> One thing I was wondering -- it would be really nice if preemptible() itself
> checked for softirq_count() by default. Or adding something like a
> really_preemptible() which checks for both CONFIG_PREEMPT_COUNT and
> softirq_count() along with preemptible().  I feel like this always comes back to
> bite us in different ways, and not knowing atomicity complicates various code paths.
> 
> Maybe a summer holidays project? ;)

I thought about that too but I think this is semantically incorrect.
In PREEMPT_RT, softirqs are actually preemptible.

Thanks.

> 
>  - Joel
> 

-- 
Frederic Weisbecker
SUSE Labs
