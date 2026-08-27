Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6A41D122;
	Thu, 27 Aug 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851733; cv=none; b=LmUrRWB7OWWCkednXAdXojdXEm1TRkSOwfkSr/SxTLk94a1c8e5jVEEguFNcpAgZvyz06I82UW4jKM81RHlBnd+0Xvhec9eGCGlMFMyjSEHFmNtav622HcAkHNGWbx+2xRuaJ27mzRjrFW438VnkdhEwa9ihMQUSXLBbzX8QeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851733; c=relaxed/simple;
	bh=kEaeMBtKRYCJIium+MMtRFAOe84q4Dq/2fzjY6XGbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFYB+cwfz4EWs6KGk15AZjzxxqfvC9GZ7NFp5JoxNm6w+xfcvyM7xIpEaPl2pUQAWu3kEQi5MSNa2y9K3okKRjYzxgO0uLxOdIccye28WmILLrRC9uoFBovaEZAM3lmJ/ZwjQQ8MsCCGlCC/ZVh88GoUGrAGpYotsMr+mpM2aIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk5QWiBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk5QWiBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6051F000E9;
	Thu, 27 Aug 2026 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851732;
	bh=euCgkWBOkD2gT9ro5YBlCAGTrtwjyOTM/By1pUN+16M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Dk5QWiBwfMymp87vHKrJLeGDwirdT1rU8rBKLn/ESdMVRy80o19RGxBIAOzVjHHrD
	 kdPtBQVlkegv44j/3v5ZBYIo1TcGR0seRq1bOSUY9HKPr4m60dTr7IBSwXYZ+qbzxG
	 /KE0aJ9KDo9pw0YIxLsXwRKDg4DVFxt1NgbqG//K/Zpp1yZovF+WKpqiqg/0nFoXsh
	 qIvNyQNQhBi7p/SSI5ew8JtLIKA2XiKaHolK8n6/0u+aHhys5pDpJuu3+YOd5bgfOh
	 47rTsQ6L/vpFCBR16cj+O41BBEvh0w4ZBmvAbqgeFkYqV302VvU+Gs46au/IHCVkkr
	 s67JVcIAxqQwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BBB2ACE1496; Thu, 27 Aug 2026 10:28:51 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:28:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Synchronously wait for all rcu_torture_irq()
 callbacks to complete
Message-ID: <2c1dde18-2e5c-4d20-b464-e16196c9efe7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260824092427.31303-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824092427.31303-1-qiang.zhang@linux.dev>

On Mon, Aug 24, 2026 at 05:24:27PM +0800, Zqiang wrote:
> The rcu_torture_reader() drives RCU readers from interrupt context via
> smp_call_function_single(cpu, rcu_torture_irq, NULL, 0) with wait=0, to
> runs rcu_torture_irq() on a remote CPU. this is async, nothing waits for
> the remote handler to run.
> 
> On shutdown, torture_stop_kthread() only waits for each reader kthread to
> return, and the reader's timer_delete_sync() only drains its timer. Neither
> waits for a rcu_torture_irq() which still pending or executing on a remote
> CPU, so it can run after all readers have exited and rcu_torture_cleanup()
> has already advanced.
> 
> 1. rcu_torture_irq() may issue cur_ops->call(rhp, rcu_torture_timer_cb)
>    after cur_ops->cb_barrier() has been waiting for all outstanding
>    callbacks complete. once the module is unloaded, fires into freed
>    module text, a use-after-free happen.
> 
> 2. rcu_torture_irq() may still be inside rcu_torture_one_read(), holding
>    a read-side critical section, when cur_ops->cleanup() tears the flavor
>    down (e.g. cleanup_srcu_struct()), triggering an active-reader warning
>    or use-after-free of the torn-down structure.
> 
> This commit therefore issue a kick_all_cpus_sync() after all readers
> kthread have returned and before cur_ops->cb_barrier(), synchronous IPI
> round trip to every CPU guarantees that every rcu_torture_irq() which
> previously issued by any reader has completed.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good catch!  Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 4b4d9c70e827..f177ba9cb604 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -4476,6 +4476,8 @@ rcu_torture_cleanup(void)
>  		for (i = 0; i < nrealreaders; i++)
>  			torture_stop_kthread(rcu_torture_reader,
>  					     reader_tasks[i]);
> +		if (irqreader && cur_ops->irq_capable)
> +			kick_all_cpus_sync();
>  		kfree(reader_tasks);
>  		reader_tasks = NULL;
>  	}
> -- 
> 2.17.1
> 
