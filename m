Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85343156F2A
	for <rcu@vger.kernel.org>; Tue,  9 Apr 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693439; cv=none; b=cZExLp8LyTY2NQ2zSemsMiecDIIL9iz/lObLOzuf8Chdv8/Occ0a3xqWLkfxMRP0L+68u/JVNx65BO3TFTV4aimfQL+ypAZ6HBWeAJSBCPZZ4NUL/CzlfEyKpAK6r9YdrsGqNlD+f5KQ1Le97VyTkdort1/9SfP7yvlsEWnHDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693439; c=relaxed/simple;
	bh=HLCnPYOHTGDd8k6Wynprq3f/l16A55JYcNPQFCkb9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdtS05+UfLnqGrn1TB6q/dflu0KByRkQKGFc7GmCj6x4KbcnuGNK1WvlhtcZrRD7j2JZiAc+Od8nwjO5YlTh4eS9D2rZ0U7IsaPk2EZnPMu/DzKspKgsJ9Hj/FhP+mYc25mH6MtwpDv3a+i9npRb7iBHLDITh4ZSBmVBKXGLxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3hmNSLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3hmNSLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73ADC433F1;
	Tue,  9 Apr 2024 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712693439;
	bh=HLCnPYOHTGDd8k6Wynprq3f/l16A55JYcNPQFCkb9fE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t3hmNSLukeOSBx83YX7aaZwh9g9Slblo4t+O9/oYxtITC2s/K6kRIgcGVUIaTjG7m
	 OltllFKbErr/YWBskPgvinVsmbThqxCTWJ5Mqc2+zJDoOTILqPmPmXKjROoi7ZHiyF
	 t/0WCmC2Qw+vkmo8rdxcekAbSd+UbpggnC3ZmkYu+FMuUCt0xMmERPsYk4b2iH6/Ma
	 IBfS3uEejDD51Y4eLi8nOoD80AbULxZMyN27JhXobBsOd0NfgYo2n2PQEPsRAL6RK+
	 aKAtBjvXaCcSkAZJYM5IJRq1QIN1pOilgpekU3hm2BUDAOEmkCQGF8DnqyGskJRXTe
	 SeP7mfOafsakw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88743CE2D22; Tue,  9 Apr 2024 13:10:38 -0700 (PDT)
Date: Tue, 9 Apr 2024 13:10:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove unnecessary READ_ONCE in
 rcu_preempt_read_enter/exit
Message-ID: <beffedec-9952-414b-bfe5-bf6e49058107@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240331091932.129617-1-mmpgouride@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331091932.129617-1-mmpgouride@gmail.com>

On Sun, Mar 31, 2024 at 09:19:32AM +0000, Alan Huang wrote:
> The two READ_ONCEs here imply that there might be updater concurrently
> modifies rcu_read_lock_nesting, although it's true there could be
> interrupt handlers enter rcu RSCS, but rcu_read_lock_nesting should
> remain unchanged after they finished. That is, READ_ONCE and then
> WRITE_ONCE the same variable is not a valid pattern, this patch thus
> removes the two READ_ONCEs.

This is true, but I will take the READ_ONCE() calls over the KCSAN
complaints.  So I must avoid taking this one.

Please note that RCU uses strict KCSAN configuration [1].

							Thanx, Paul

[1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing

> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 340bbefe5f65..c90edbb7fa40 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -376,12 +376,12 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>  
>  static void rcu_preempt_read_enter(void)
>  {
> -	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
> +	WRITE_ONCE(current->rcu_read_lock_nesting, current->rcu_read_lock_nesting + 1);
>  }
>  
>  static int rcu_preempt_read_exit(void)
>  {
> -	int ret = READ_ONCE(current->rcu_read_lock_nesting) - 1;
> +	int ret = current->rcu_read_lock_nesting - 1;
>  
>  	WRITE_ONCE(current->rcu_read_lock_nesting, ret);
>  	return ret;
> -- 
> 2.34.1
> 
> 
