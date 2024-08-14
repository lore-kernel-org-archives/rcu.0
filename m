Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9491AED49;
	Wed, 14 Aug 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637820; cv=none; b=F7fWymONOg4dZiuQnxoHXIDKOrhRBaAtqv3CdwF2uTzm7kkxFV7pmy8nlgEiSGwOmiTq6UO3IvSkDZ31aW5LNzVl2i3ZNnZunJ5jn9kr1yZEEDhvOjNmNRs+yLN1zmoDWWTwsnxCJQfEFEQHFNi04Gtp3O0ijgtvoA36Ix412Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637820; c=relaxed/simple;
	bh=ya3Hqm0nXBf3LYIevNixQhJ5MXPNo3X3y6RgGDWBNi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFGLtbNKUTluR1baGA+8PaXG2AjhcQAOYZGhCI1+0oc/P2PM1ykx1OmCjxzo+fAo96rjrO6yin+RvyJRmEjgk+raiPWzGxk2tlduDYTFBRWPe5r63kNyhw3/8bFgQvbkZ0UExMd6fzzjiqC2Z/VjiQ6MHT81xoWD1ScrSmnZUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtkd/ouG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtkd/ouG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6854EC32786;
	Wed, 14 Aug 2024 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637819;
	bh=ya3Hqm0nXBf3LYIevNixQhJ5MXPNo3X3y6RgGDWBNi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtkd/ouGMJTWnITDdPlFNHBMylqaXtj5pTT7LCl/hpuoCG1RjVSBw+aQK8PNe6aYx
	 eoIpKP4oiUe4mV9vh9kvXRU+duLxi6Ju7CYRhN0zJUZfnLDDsp07SNw+5pk+fG8aD8
	 +XG0LQzYalpySObz/onbfbEnBm0haoIh5++2RbLeRw+kkOshWvFhRaqtScoMFaFiX+
	 heDmDyyf1jZ1jGf9+0yor3Tl1tVcMYWFOKr/KRn6oxF/ob8LEkZ/o6g+m4j+LBcrMm
	 olIFIExMcy5SvHIa96YirERTQAouqn0Lp+ymtn7P7Am2+0OzlYoidqaT3Jw7yBRgRU
	 /lcaZyQj2/LKA==
Date: Wed, 14 Aug 2024 17:46:54 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH rcu 1/6] rcu/tasks: Check processor-ID assumptions
Message-ID: <20240814121654.GA1412801@neeraj.linux>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
 <20240802003426.4134196-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802003426.4134196-1-paulmck@kernel.org>

Hi Paul,

On Thu, Aug 01, 2024 at 05:34:21PM -0700, Paul E. McKenney wrote:
> The current mapping of smp_processor_id() to a CPU processing Tasks-RCU
> callbacks makes some assumptions about layout.  This commit therefore
> adds a WARN_ON() to check these assumptions.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tasks.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b6fcf744af75d..d473846a572aa 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -355,6 +355,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  	rcu_read_lock();
>  	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
>  	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
> +	WARN_ON_ONCE(chosen_cpu >= nr_cpu_ids);

I have changed this s/nr_cpu_ids/rcu_task_cpu_ids/ , as there is a
another commit 	fd70e9f1d85f "rcu-tasks: Fix access non-existent percpu
rtpcp variable in rcu_tasks_need_gpcb()" which is included in the tree
here [1]. Please let me know if something looks incorrect.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next.14.08.24a


- Neeraj

>  	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
>  	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
>  		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
> -- 
> 2.40.1
> 
