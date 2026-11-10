Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269283;
	b=v1Mm7hxkYIhQ7S8N+qWSj1CQwt0KtfcN563PSCbkF1tEsxpcAbRk7Y+ibtpHKO4ANLXv
	 p6vHrZE44gAYpz2ZyX8h1E1/CXieit8SinndKA4h9VidsNhoY6EmQSNylnWnJ0GbyajQd
	 bhokjFjWeuLt/595TiZ0vikfH9x/udpI8TsUBxjXwXqf5VXNTZOR6GrI6YDy30dvqldMH
	 EtF2lBX81JCPOZjbTCElhlQzexBAZQ6z3O0wFnrhSM5suTeTv8n0pBouTFc94PWj7UdK1
	 rxW1kwOiIHiBX4SkWlXJ8B4FgOBVqZNUtFVVZEjBte8tb8AuIY3fI8s/sJlVIVPXleg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269283;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+p+YiJukHGesQfS1qVRcmGpAI2BJYIJwn755denoFYo=;
	b=3Z0mCxezMPEZCNJbz9uXF6HbxjuO2uOF2Q2Ns9Oq3U9PApdQt3GLs4an8CXX4LHdIn5s
	 4eL/+hxVdYRLcqqPC1liyEL9+RvOtnEKIaV+Iu6lGHbd0QGQ7YgDDRi6pJqYzzCaRwbNO
	 SfdBYKA2yP4AOIO8CsIEFj0CBucD1//eC39zO8lNvGgwhpiFD2mBCnZgZLO3L4QRY9UT+
	 X7+SNIP0xol6rn9Yd88e8hN79nT59bhss3r/E3OJ4t9FtkMb4ILi0GBDqNEcxwyeUkPBl
	 uD5pvDL9NVpiNbXxO085OdN+/P7SRVcahv6lJ1ksVMX18zrTZcHQ6FLCp9mrS2YuhZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ORaHNL/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8E606A31C;
	Tue, 10 Nov 2026 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORaHNL/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3021F0089F;
	Tue, 10 Nov 2026 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269283;
	bh=+p+YiJukHGesQfS1qVRcmGpAI2BJYIJwn755denoFYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ORaHNL/RYrbFyI5l51ptdYXE3BnU+m4nkVuQOO5rg3PRINSFVOyUB8/3gyHchhtgb
	 J8jNjS8iyZ0Gr4FaPXO2eqoDfLZgMaKwztIRXKrhIhH0+Y73X1iCsJQW+gltaJb3pd
	 jtzFfu8rXYP5PPYhSdnw50riainqDgYDVr6nF00gpEs82E7xaYLlrkk7wHOjximjXH
	 EzDHBp4p1ulvMrwByFHPkmP0010ByESf4nzdrkgrTmb90TUOTZbJNhhewj5gsTnZ5i
	 Q0zFqWn2KMHCQcMsMP+h74QB7zMMU+p816L+Au9RYgdR2JMpZtueAWT/gzykdqRbQe
	 9qmHnXPt3Lgyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18639CE0DDC; Mon,  9 Nov 2026 16:08:03 -0800 (PST)
Date: Mon, 9 Nov 2026 16:08:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2 2/5] scftorture: Reject empty workloads before
 starting helpers
Message-ID: <190db18f-9342-448f-a38f-db09aa143f4f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
 <20261109000243.3936824-3-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109000243.3936824-3-joelagnelf@nvidia.com>

On Sun, Nov 08, 2026 at 07:02:38PM -0500, Joel Fernandes wrote:
> A module loaded with nthreads=0 starts its statistics task, but cleanup
> skips stopping that task. Unloading the module then leaves it executing
> freed module text. Reject a zero thread count before starting helpers;
> negative counts still select the online CPU count.
> 
> Also, when built as a module with reschedule-only, this leaves the
> selector empty because resched_cpu() is unavailable to modules. It warns
> while selecting an operation, invokes no callbacks, and can nevertheless
> report SUCCESS.  Reject an empty effective selector after filtering
> unsupported operations.
> 
> Both failures were reproduced in a guest without the patches.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

If you wish, you could split this into two commits, but your call.

							Thanx, Paul

> ---
>  kernel/scftorture.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 603b2dba1536..ff9a8271a464 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -588,6 +588,12 @@ static int __init scf_torture_init(void)
>  
>  	scftorture_print_module_parms("Start of test");
>  
> +	if (!nthreads) {
> +		SCFTORTOUT_ERRSTRING("nthreads must be nonzero");
> +		firsterr = -EINVAL;
> +		goto unwind;
> +	}
> +
>  	if (weight_resched <= 0 &&
>  	    weight_single <= 0 && weight_single_rpc <= 0 && weight_single_wait <= 0 &&
>  	    weight_many <= 0 && weight_many_wait <= 0 &&
> @@ -636,6 +642,11 @@ static int __init scf_torture_init(void)
>  	scf_sel_add(weight_many_wait1, SCF_PRIM_MANY, true);
>  	scf_sel_add(weight_all1, SCF_PRIM_ALL, false);
>  	scf_sel_add(weight_all_wait1, SCF_PRIM_ALL, true);
> +	if (!scf_sel_array_len) {
> +		SCFTORTOUT_ERRSTRING("no supported operations selected");
> +		firsterr = -EINVAL;
> +		goto unwind;
> +	}
>  	scf_sel_dump();
>  
>  	if (onoff_interval > 0) {
> -- 
> 2.54.0
> 
