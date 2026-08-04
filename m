Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A94A21;
	Tue,  4 Aug 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815167; cv=none; b=PRAMo/TjLmTsRABjrvRAOo2OXiDNl7fzTOZWnSMG50Qi7tivQUytwm+KEWSSGKV5WNZkOJKbcX5VbQjp9cnsZuSLJiStecL4Gh3sKBI6NMf868pv0ky4HzPK9/5npXcK0+QiC9afPX/XnYSbjG3zXLeRjBEwpreF7pVixCQwUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815167; c=relaxed/simple;
	bh=SWD1g4Q5IyeVpi5UdTskQ1jDqEOJsmHH8XbZ9CUuO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt8+10tr7IwwuSIdx7n1WA+0LbMFW8okRh2lxJK8EhSkJbx7evpV7vT0pE4a+1a41zdobJ09GXcZi/IeraHdl/vLu3rDFoAbw998GI3qliSfvuWixoPJc8IUZADBRoQ33MrU3eyjMd8fVZ+u3FH9kA5cBv51xyuj8gSjrZcLXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6C5DhlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6C5DhlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED451F000E9;
	Tue,  4 Aug 2026 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815166;
	bh=QXixXGTmi22QgHh+IyytZ8hLXnKvhMWmfbMTro9Sce4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=l6C5DhlOFXdQfuXaDc8mKHloaVLLgr2WTrro/QGLckOXLT/v/CYOL0iSWtfeDIXTI
	 azcFnAG8U1f3+5tSdnE/bnAz/MSxOw7yeuCkNtrIi4lcE1QHSCEN3Wc67UfU+V4LXS
	 /cFZ1k44xiiwG0zlgrGkRGsMb3juRekClPKG2nuuFndfIKNgb9kUdlaC5BFnqLQOuU
	 9LMqHPqt8CoZVZhPGFnJ2rrvTkAHOHoz/hPgyukxjtjbLvmfncOxBL2ptQkpBzvd04
	 snCV+hfByUC6FcAGr5TDvfl07mS0oE1DmCI/aFq9hSu45MnRUxUMpjkZXIj/UVLnv9
	 sNd7ZXU7seWmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C81FCE086B; Mon,  3 Aug 2026 20:46:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 20:46:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in
 do_pending kthread
Message-ID: <089b21e8-4bd6-4517-b36b-d18452260302@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260804000340.4812-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804000340.4812-1-include@grrlz.net>

On Tue, Aug 04, 2026 at 12:03:39AM +0000, Bradley Morgan wrote:
> The do_pending kthread never sleeps. Its supposed to.
> kthread_do_pending_ms sets the gap between cleanups, and the docs
> say so too. But the sleep sits behind torture_must_stop(), and thats
> false while the test runs. So the kthread never sleeps. It just loops.
> It drains the pending lists over and over, no pause, and burns a full
> CPU for the whole test.
> 
> Flip the check. With !torture_must_stop() it sleeps for
> kthread_do_pending_ms between passes. When the test stops it does one
> last cleanup and exits. Nothing left to do, so no sleep needed then.
> 
> Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred hazard pointers")
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Good catch, applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/hazptrtorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 72aeb50668e9..7c8b5899fb01 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
>  			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>  			hazptr_torture_do_one_pending(cpu, &rand);
>  		}
> -		if (torture_must_stop())
> +		if (!torture_must_stop())
>  			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>  		// Omit stutter_wait() because this function needs to do cleanup.
>  	} while (!torture_must_stop());
> -- 
> 2.47.3
> 
