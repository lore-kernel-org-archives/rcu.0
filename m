Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF783A4513;
	Wed, 18 Mar 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831866; cv=none; b=e4YYDFd9aXuiZFkx7GwbQGnEHfMEE+zdESMM6fDGkjHnD0EHF/x8KApBAA6aGLenFKvec9gS49RkdeMzdoG7GOg6xRYMu9GcUD03os0KY9zxHOe/fXCft+J1o24Qh/yEkNPgAuty6AY+RlRsfNAZMY79/iqDr8rLyTOqB1kZIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831866; c=relaxed/simple;
	bh=Q7yYQ9uTUJsiwzhXBcD4JAag81xV4uhk/MNZfN6Luj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZx84j1vNnk5+4mWSIEFUXReDqQ5ZWxAltksT+Xaq4eX4Sj/b1fdxc/MztvzhyZGKRtsKRPjZp8oq57u1zzDt1sa5gLvGia8WcYW08+t9N4BXShceuX/ccLZvcIUjfMdmYaYKwWx9H3eONXq0FvDnQkHl5IP175HnPG0KSVoUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4BZsyro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4BZsyro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED526C19421;
	Wed, 18 Mar 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831866;
	bh=Q7yYQ9uTUJsiwzhXBcD4JAag81xV4uhk/MNZfN6Luj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4BZsyrop82tv1RVGdlfCx0kU5IxnNF220nWzRb9eEgXDwARKBP0FN+K4V+CbYkca
	 hE+AlF4dMilTbPeC/+LF1r56L6zBuRkIHruO3J5Qlwp2jhzqL3cxrLw9yO877q4N0A
	 REVFxWHE4S/+x8nRRfz65C6hfoLgclMHtU5HZXD6yq80KFnohWfT/Hg8MoQf/su0i/
	 VAzrmxhdn+t+Ql01ejJKgvYgs2h/SbFwWP+v4FSzLrpl2tieDaJrJqvNSZBM5Q5xpw
	 E02UwwHUJ3r9BA/j/02/V9A3I+P4mRTNbEcC19LZC7i1j7+RiKN2NDjZDYYrhAhAV2
	 CC1q+Gs/5CbpA==
Date: Wed, 18 Mar 2026 12:04:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, rcu@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v1 10/16] rcu-tasks: Document that RCU Tasks Trace
 grace periods now imply RCU grace periods
Message-ID: <abqGt2CQCfM4PeqK@localhost.localdomain>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
 <20260317212217.1527644-11-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317212217.1527644-11-joelagnelf@nvidia.com>

Le Tue, Mar 17, 2026 at 05:22:11PM -0400, Joel Fernandes a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Now that RCU Tasks Trace is implemented in terms of SRCU-fast, the fact
> that each SRCU-fast grace period implies at least two RCU grace periods

two or one?

AFAIU srcu_readers_active_idx_check() it's only one?

> in turn means that each RCU Tasks Trace grace period implies at least
> two grace periods.  This commit therefore updates the documentation
> accordingly.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  Documentation/RCU/Design/Requirements/Requirements.rst | 7 +++++++
>  include/linux/rcupdate.h                               | 9 +++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index b5cdbba3ec2e..4d886e7c7a95 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2787,6 +2787,13 @@ which avoids the read-side memory barriers, at least for architectures
>  that apply noinstr to kernel entry/exit code (or that build with
>  ``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
>  
> +Now that the implementation is based on SRCU-fast, a call
> +to synchronize_rcu_tasks_trace() implies at least one call to
> +synchronize_rcu(), that is, every Tasks Trace RCU grace period contains
> +at least one plain vanilla RCU grace period.  Should there ever
> +be a synchronize_rcu_tasks_trace_expedited(), this guarantee would
> +*not* necessarily apply to this hypothetical API member.
> +
>  The tasks-trace-RCU API is also reasonably compact,
>  consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
>  rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 04f3f86a4145..18a85c30fd4f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -208,12 +208,9 @@ static inline void exit_tasks_rcu_finish(void) { }
>  /**
>   * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
>   *
> - * As an accident of implementation, an RCU Tasks Trace grace period also
> - * acts as an RCU grace period.  However, this could change at any time.
> - * Code relying on this accident must call this function to verify that
> - * this accident is still happening.
> - *
> - * You have been warned!
> + * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
> + * call to synchronize_rcu_tasks_trace() is guaranteed to imply at least
> + * one call to synchronize_rcu().
>   */
>  static inline bool rcu_trace_implies_rcu_gp(void) { return true; }

I guess the plan is to remote that function?

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  
> -- 
> 2.34.1
> 

-- 
Frederic Weisbecker
SUSE Labs
