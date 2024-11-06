Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80E204944;
	Wed,  6 Nov 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924308; cv=none; b=PAwSYycwFLWbEGU85FhJAFgmG1KH7zwXjskavaa7LwnyOwJTl0ZWPkc3rYCpRQSBYU6WQqceyN7uN0Q/VMQlttRvZZPMFk3FkO+NdisbDXOz8loC6q/YizrSPaP12ZUINqO7nj7tCrk5VxnGJ75cQ26SbE3PQzQAfek/qaizLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924308; c=relaxed/simple;
	bh=QsLrCND2FcA2NmDLIeBmkTo+vrdrgqm9mjExCkISpuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQOfMktt6b+E6BNppnbrkMi5IIUA2HeRhFV93/RNNLYQv/PAreU9w95bLYGQgYgSlG4mCymUWkv8i64/ECKeyFJTnpoW7WEyJ9DgM80Zk3OhQUztCDP6Py+DS+a7w0RHItFCMnCxab98zqmaQYmyGhZfshJH0+0gxHP1T7GJcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ZPiP4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ZPiP4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFA6C4CEC6;
	Wed,  6 Nov 2024 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730924305;
	bh=QsLrCND2FcA2NmDLIeBmkTo+vrdrgqm9mjExCkISpuU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=M6ZPiP4p09olpLK2/Sas2zI6tv/jySRPbJyrIXAtdxFqALsT/LXAcZlxf5Z7kbdt/
	 V2kujZ+gkGS0i8repnTBlIkoJipF/qyBxba2mHfZZj4MluE47xfv8D0kuEz0SiyWHh
	 mQ1qqi+gbRt88PTtW0IinJzkO16Nw9BkK+k1ZSx+aJWOUgJ/ViNmhFBWABq4q7kEmE
	 N4CQ13RsQyVMWVbzi7Y8w8LBZ7LUJh5EJVzuBqVRmwYK6EhlAlJbPCU7wRCP3Ll6TW
	 ZSoiRFwXE6gxUosCwPcgbEkkaVfr7hlpFSGnMn6lNamReXKPTobbRzXjcJ9rhrx9xb
	 tQ5WqOjZz3v6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1CAC8CE09DB; Wed,  6 Nov 2024 12:18:25 -0800 (PST)
Date: Wed, 6 Nov 2024 12:18:25 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zilin Guan <zilinguan811@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Use READ_ONCE() for rdp->gpwrap access in
 __note_gp_changes()
Message-ID: <65bfe6b1-3bfa-469d-aada-8e79d1101d5d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241104151230.3107133-1-zilinguan811@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104151230.3107133-1-zilinguan811@gmail.com>

On Mon, Nov 04, 2024 at 03:12:30PM +0000, Zilin Guan wrote:
> In function __note_gp_changes(), rdp->gpwrap is read using READ_ONCE()
> in line 1307:
> 
> 1307    if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
> 1308            WRITE_ONCE(rdp->last_sched_clock, jiffies);
> 
> while read directly in line 1305:
> 
> 1305    if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) ||
> 	    rdp->gpwrap)
> 1306            WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
> 
> In the same environment, reads in two places should have the same
> protection.
> 
> Signed-off-by: Zilin Guan <zilinguan811@gmail.com>

Good eyes!!!

But did you find this with KCSAN, or by visual inspection?

The reason that I ask is that the __note_gp_changes() should be
invoked with the leaf rnp->lock held, which should exclude writes to
the rdp->gpwrap fields for all CPUs corresponding to that leaf rcu_node
structure.

Note the raw_lockdep_assert_held_rcu_node(rnp) call at the beginning of
this function.

So I believe that the proper fix is to *remove* READ_ONCE() from accesses
to rdp->gpwrap in this function.

Or am I missing something here?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1f883fcd918..d3e2b420dce5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1302,7 +1302,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
>  		zero_cpu_stall_ticks(rdp);
>  	}
>  	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
> -	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
> +	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || READ_ONCE(rdp->gpwrap))
>  		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
>  	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
>  		WRITE_ONCE(rdp->last_sched_clock, jiffies);
> -- 
> 2.34.1
> 
