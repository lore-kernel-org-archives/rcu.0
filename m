Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD93EC2E1;
	Fri, 29 May 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065899; cv=none; b=jrXdJ9QpKUe20M+oNJLj/wG8QzQxAnKYz9fphgsFsi3UnmZiRYBgAkeDMvjQuNQDEMOPR4/cBB21w9IfDCRhiY99xT/DVxhPk9njy7IIcCGvpQLE6Wc258jW2biSGnRKvkivztcryiNVcN1Lzqx9xENMNyFgcrtcO4oJt23nVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065899; c=relaxed/simple;
	bh=1Ivezq50Aih7fP4bRgpPF0bnHD0+q0Ra7z8UIbb8yUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7ABR2NRydD2Zd2lYhPEvj3nQfjuMdOxZmzxP2fMykOMqdO/LztlcdyFiVY0rHTYW/EizKyVC3L7JEKjnXiIitavzpTlXwFw4mC3Ei/O3XgyK9t9Ao/muMoHNv60ihr+HM7UGp9/JmTV0498vzfvx3xYivuLZ4dyqjU2v7JsiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1ZTQRbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1ZTQRbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031CD1F00893;
	Fri, 29 May 2026 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065897;
	bh=FcLLsVIB9S0IaLxt0QV7rD/IXevTVDEuTKketUNGioc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1ZTQRbjusbEkA8mO3sR9TKhsyY0RrsJINdpb3IyMIXXR9I/QIXMj7FZ8uCPsWumU
	 nn0odTm5907pR4/4L99boDo7epvEeEkjK1nvwsgjOHdF3h1v7Jbk1q/g0xD/6mIdgi
	 5kFUaAHPEOOC9BVkKzp+AfUZRXBDxM9S5uVewvxzVQtmPI0cwYzUaPfTg/4q3IHKGd
	 rAQOPxFIRWv1kIoU2zSRQ6nlazSwQEynVHXeB/GsS5ts7PCSdsJS/852yaRcIZsgmU
	 um7hJi9mMu4vUJz4wz8C99KKtTYIx1XFkLd5e7jShOcUNnAFMhoj5Gjhp++V7OSeZx
	 Ak8ZPamUVdcSg==
Date: Fri, 29 May 2026 16:44:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH 08/10] rcu: Detect expedited grace period completion
 in rcu_pending()
Message-ID: <ahmmZglg5tBFgC6i@pavilion.home>
References: <20260417231203.785172-1-puranjay@kernel.org>
 <20260417231203.785172-9-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417231203.785172-9-puranjay@kernel.org>

On Fri, Apr 17, 2026 at 04:11:56PM -0700, Puranjay Mohan wrote:
> rcu_pending() is the gatekeeper that decides whether rcu_core() should
> run on the current CPU's timer tick. Currently it checks if the CPU has
> callbacks ready to invoke or a grace period has completed or started.
> 
> It does not check that an expedited GP has completed. After an expedited
> GP, callbacks remain in RCU_WAIT_TAIL (not yet advanced to
> RCU_DONE_TAIL) and So rcu_core() never runs to advance them.
> 
> Add a check using rcu_segcblist_nextgp() combined with
> poll_state_synchronize_rcu_full() to detect when any pending callbacks'
> grace period has completed.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/tree.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0e43866dc4cd..309273a37b0a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3671,6 +3671,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
>  static int rcu_pending(int user)
>  {
>  	bool gp_in_progress;
> +	struct rcu_gp_oldstate gp_state;
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
>  
> @@ -3701,6 +3702,12 @@ static int rcu_pending(int user)
>  	    rcu_segcblist_ready_cbs(&rdp->cblist))
>  		return 1;
>  
> +	/* Has a GP (normal or expedited) completed for pending callbacks? */
> +	if (!rcu_rdp_is_offloaded(rdp) &&
> +	    rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +	    poll_state_synchronize_rcu_full(&gp_state))
> +		return 1;

Do we need the overhead of at least one and at worst two full memory
barriers on every ticks that have pending callbacks? I think that there can be
a racy check here, some unordered version of poll_state_synchronize_rcu_full()
perhaps, and leave the ordering duty to rcu_core().

Thanks.

> +
>  	/* Has RCU gone idle with this CPU needing another grace period? */
>  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
>  	    !rcu_rdp_is_offloaded(rdp) &&
> -- 
> 2.52.0
> 

-- 
Frederic Weisbecker
SUSE Labs
