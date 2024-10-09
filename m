Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212073BBEB;
	Wed,  9 Oct 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484638; cv=none; b=YsL1Ux+dS9RVEeM7/KJcpThXf0djfyUVsLvaXxqkOcETmgLbb0bzAVs9OPyqt3zGhN8Hk9IP4xe7Y2Wj2huEBWeD2w/SfJ+Dl+hPHDKAlwigYOIcSzX2qLeqSh7TjYy038Ij98JEce9h9AVi56o2jA29XHgbxSSjp/w+VQPC0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484638; c=relaxed/simple;
	bh=6fyn3wX+UwlDxoFQS10FOggWv6S8FSIec9HdLXYbHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuxVlqAHi9CipjUxt5g1I/BmCl6g2GnAnqgUvReG1HLZ2/dThfyNKnvvGjDAPh2flTdvZuW+ZBwwfWIJnpr+hgv3XUcBIJSSwAJafnR5IrsJSOmjA0AMez+vnaviCp++/eU1hYAXlus/4uUOnQDFECfpbsKtRnd79xkoZIU2ZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+S4h6Vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+S4h6Vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC1DC4CEC3;
	Wed,  9 Oct 2024 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728484637;
	bh=6fyn3wX+UwlDxoFQS10FOggWv6S8FSIec9HdLXYbHxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+S4h6VoePLaSWMBaEZrbTs5ASdKkvAOjlKthj0fp8joS4AmF1JcBHYOMPZxYw6Sz
	 V32pMsyP+OiL4TR74WdnAd+qUtDHYr7x3LDOPbaF35FzS/GNz3r2POVKD6yJtyAmqD
	 L2AsDc9Phr0IU/yz9J1BrhxDxaIh8xeFy4kfukTzhyhpFsm/N4yKnlnXwxrFMF8YXc
	 zjPH1Y7/Bck8QrzjXZ+LMViawL39SsmnUFmnetI5zNG/mR6M3IzVr55b61X66V03LB
	 J/ysOtMPvwHT7mOLPaAOdBrvNLtH0fP8Fl9LWQd8trT4/qDN9ujZ9Agio0s6pF2sJj
	 u8nCmY2NhHbaw==
Date: Wed, 9 Oct 2024 16:37:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joel@joelfernandes.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	peterz@infradead.org, neeraj.upadhyay@amd.com
Subject: Re: [PATCH v2 07/10] rcu/tasks: Check RCU watching state for holdout
 idle injection tasks
Message-ID: <ZwaVGnwu_Mgdbjfa@localhost.localdomain>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
 <20241009125127.18902-8-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009125127.18902-8-neeraj.upadhyay@kernel.org>

Le Wed, Oct 09, 2024 at 06:21:24PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> Use RCU watching state of a CPU to check whether RCU-tasks GP
> need to wait for idle injection task on that CPU. Idle injection
> tasks which are in deep-idle states where RCU is not watching or
> which have transitioned to/from deep-idle state do not block
> RCU-tasks grace period.
> 
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

For now this should work because there is a single user that is
a per-cpu kthread, therefore no RCU-watching writer can race
against another (real idle VS idle injection or idle_injection VS
idle injection) without going first through a voluntary context
switch. But who knows about the future? If an idle injection kthread
is preempted by another idle injection right after clearing PF_IDLE,
there could be some spurious QS accounted for the preempted
kthread.

So perhaps we can consider idle injection as any normal task and
wait for it to voluntary schedule?

Well I see DEFAULT_DURATION_JIFFIES = 6, which is 60 ms on HZ=100.

Yeah that's a lot...so perhaps this patch is needed after all...

> ---
>  kernel/rcu/tasks.h | 63 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index d8506d2e6f54..1947f9b6346d 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -38,6 +38,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>   * @rtpp: Pointer to the rcu_tasks structure.
>   * @rcu_watching_snap: Per-GP RCU-watching snapshot for idle tasks.
>   * @rcu_watching_snap_rec: RCU-watching snapshot recorded for idle task.
> + * @rcu_watching_idle_inj_snap: Per-GP RCU-watching snapshot for idle inject task.
> + * @rcu_watching_idle_inj_rec: RCU-watching snapshot recorded for idle inject task.
>   */
>  struct rcu_tasks_percpu {
>  	struct rcu_segcblist cblist;
> @@ -56,6 +58,8 @@ struct rcu_tasks_percpu {
>  	struct rcu_tasks *rtpp;
>  	int rcu_watching_snap;
>  	bool rcu_watching_snap_rec;
> +	int rcu_watching_idle_inj_snap;
> +	bool rcu_watching_idle_inj_rec;

So how about:

struct rcu_watching_task {
    int snap;
    bool rec;
}
...
struct rcu_tasks_percpu {
       ...
       struct rcu_watching_task idle_task;
       struct rcu_watching_task idle_inject;
}

Thanks.
