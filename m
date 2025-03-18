Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5091A2567;
	Tue, 18 Mar 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318554; cv=none; b=MltsB/TX8I2zQ1qmV1oJw74SAyQspNqxWnb+vlrhB+2JA+Cx3qpVJzaexlZrFOZd6dpVwBjTlGrqC0JYwH1o3TbD+JOirOPF7LzH6bA9RRRYf9LwLYMU4q6KLnomEJ62cJXoI1Gky+rkpgfycKkPN3UAbyZr1bYieu64W7V+W28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318554; c=relaxed/simple;
	bh=ZaOAOTeE5Pd9y4fWllQLlZmX6kLPoyGwRSl44uIFDEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goI+1Uz485eemCowP24sNf0MuqCPUzWk2A4Z5qFSiScQo0msGpALObI3/h24F7UzaNp8ekLNGV4U6YkkxQVvUiYQsLUUQD0xZ1Cy/y5gB3y6pKOWwadMFQ5vH+p6gqCyD2aU2KBUfxPijpQGCNTqw52wIlKVmb1pmk54erfWXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8gsckEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8gsckEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B92C4CEDD;
	Tue, 18 Mar 2025 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318554;
	bh=ZaOAOTeE5Pd9y4fWllQLlZmX6kLPoyGwRSl44uIFDEo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j8gsckEX8mNZQYU0c8XatrJ7MSH+Tu2GlVFZ0LbSaul0TaaXVpFcG3fzrGZQ8vV1R
	 fMXZMzcqr1iLA7Ra6ghPQB7A7EaGNClI0KlBIbyQCTFU2gzs76ezB9C40zkjjuhM/A
	 ZJR23V72u7fHY12UOdqxzBSp1Ox6FXVK96Mc0o896c4a+qgXTZJJxHNIYcQuAjN3VF
	 R1UdPyUojgxh1sm/4cNdwpPl6aQEDtlnrI8QA0epM8hRwDKyym9fHnvh2/XP4bMyTB
	 8wUHixKyhdF+u5eHzzB0skfttijz4E0xN9JF5FAC/O56V6WVdlBLyfTBEQzGPzkUVW
	 cyrNxDvJxr37Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0DD9CE0843; Tue, 18 Mar 2025 10:22:33 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:22:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
Message-ID: <bf7a3b05-4218-42aa-b936-8fc86435db15@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314143642.72554-6-frederic@kernel.org>

On Fri, Mar 14, 2025 at 03:36:42PM +0100, Frederic Weisbecker wrote:
> A CPU within hotplug operations can make the RCU exp kworker lagging if:
> 
> * The dying CPU is running after CPUHP_TEARDOWN_CPU but before
>   rcutree_report_cpu_dead(). It is too late to send an IPI but RCU is
>   still watching the CPU. Therefore the exp kworker can only wait for
>   the target to reach rcutree_report_cpu_dead().
> 
> * The booting CPU is running after rcutree_report_cpu_starting() but
>   before set_cpu_online(). RCU is watching the CPU but it is too early
>   to be able to send an IPI. Therefore the exp kworker can only wait
>   until it observes the CPU as officially online.
> 
> Such a lag is expected to be very short. However #VMEXIT and other
> hazards can stay on the way. Report long delays, 10 jiffies is
> considered a high threshold already.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Same CONFIG_PROVE_RCU question, same conditional:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_exp.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6058a734090c..87a44423927d 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -406,8 +406,18 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  		unsigned long mask = rdp->grpmask;
> +		int nr_retries = 0;
>  
>  retry_ipi:
> +		/*
> +		 * In case of retrying, CPU either is lagging:
> +		 *
> +		 * - between CPUHP_TEARDOWN_CPU and rcutree_report_cpu_dead()
> +		 * or:
> +		 * - between rcutree_report_cpu_starting() and set_cpu_online()
> +		 */
> +		WARN_ON_ONCE(nr_retries++ > 10);
> +
>  		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
>  			mask_ofl_test |= mask;
>  			continue;
> -- 
> 2.48.1
> 
