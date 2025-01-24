Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528033C0B;
	Fri, 24 Jan 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730168; cv=none; b=osq4LR84D0+D50whkBGjE5PKRLrCxY+mNztEy4ihitT9PQQjfCOIkEQyCbr4q39R/WdFOWlQr9jpo4wUuc+W4qz7hQB2AhDy6l6AYFFEGpT34/big6aY0ildGLigcRLQGMISKJVxlsUH3U6u3Wn86rAB/DFbCj2SwgYKzZ9O8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730168; c=relaxed/simple;
	bh=qv/T1UPlqlN2gRfcaNhB4pqtvqWzFX0EBJSz+nNFHhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrApiyxJxSWyiyDr+iCRBtLOvY+Oo5pyxrQK0CuEgNWv4GqLTN8hA9R7PMnfCdTIIS7BwiOLGPIlVS4wkgLPEAPvSWNIi1Q/htGhz7ik7do7GAaQEEf14ZsK3rt+UatQl7nd2HV3mFG/c4YHyq1iybObVYjJmwzXXQ+M7WcQIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTTB+jxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTTB+jxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E0C4CED2;
	Fri, 24 Jan 2025 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737730167;
	bh=qv/T1UPlqlN2gRfcaNhB4pqtvqWzFX0EBJSz+nNFHhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTTB+jxremOAq6t9tJvs4bjhHrA/A1VprHBgqOTwGQW6SfoklIvo1jwbyqEm2Kkhz
	 EK41YJSamhNy9ZgeNiSRoJJC5ycMfrWKLVE4DpwBXC/geDZbY5Gt2S2Kbzc5uMV8nC
	 /jsimqX6X3iwO7fIJreHJXO5cdFpRNS8+upq5RaKqMnLy+CcRD6E85SDhYL19je2dV
	 v5zyYRDWGBIT0rZI9wRqQ1AjWaamVjz4cDJNol5yGYT3XTgdkM1zlEKhAhDhCQJ60u
	 WTXCyRGTSMDH4KaR90nMr1Kv/k4DRB9OUqU2yGdfkBI2WLpY1cShVCsj5F58XVnCJl
	 jcDLQw7FjSRQg==
Date: Fri, 24 Jan 2025 15:49:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <Z5OodAwpjRtR4lvv@localhost.localdomain>
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>

Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
> functions use the root rcu_node structure's ->gp_seq field to detect
> the beginnings and ends of grace periods, respectively.  This choice is
> necessary for the poll_state_synchronize_rcu_full() function because
> (give or take counter wrap), the following sequence is guaranteed not
> to trigger:
> 
>         get_state_synchronize_rcu_full(&rgos);
>         synchronize_rcu();
>         WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));
> 
> The RCU callbacks that awaken synchronize_rcu() instances are
> guaranteed not to be invoked before the root rcu_node structure's
> ->gp_seq field is updated to indicate the end of the grace period.
> However, these callbacks might start being invoked immediately
> thereafter, in particular, before rcu_state.gp_seq has been updated.
> Therefore, poll_state_synchronize_rcu_full() must refer to the
> root rcu_node structure's ->gp_seq field.  Because this field is
> updated under this structure's ->lock, any code following a call to
> poll_state_synchronize_rcu_full() will be fully ordered after the
> full grace-period computation, as is required by RCU's memory-ordering
> semantics.
> 
> By symmetry, the get_state_synchronize_rcu_full() function should also
> use this same root rcu_node structure's ->gp_seq field.  But it turns out
> that symmetry is profoundly (though extremely infrequently) destructive
> in this case.  To see this, consider the following sequence of events:
> 
> 1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
>         accordingly.
> 
> 2.      As its first step of grace-period initialization, CPU 0 examines
>         the current CPU hotplug state and decides that it need not wait
>         for CPU 1, which is currently offline.
> 
> 3.      CPU 1 comes online, and updates its state.  But this does not
>         affect the current grace period, but rather the one after that.
>         After all, CPU 1 was offline when the current grace period
>         started, so all pre-existing RCU readers on CPU 1 must have
>         completed or been preempted before it last went offline.
>         The current grace period therefore has nothing it needs to wait
>         for on CPU 1.
> 
> 4.      CPU 1 switches to an rcutorture kthread which is running
>         rcutorture's rcu_torture_reader() function, which starts a new
>         RCU reader.
> 
> 5.      CPU 2 is running rcutorture's rcu_torture_writer() function
>         and collects a new polled grace-period "cookie" using
>         get_state_synchronize_rcu_full().  Because the newly started
>         grace period has not completed initialization, the root rcu_node
>         structure's ->gp_seq field has not yet been updated to indicate
>         that this new grace period has already started.
> 
>         This cookie is therefore set up for the end of the current grace
>         period (rather than the end of the following grace period).
> 
> 6.      CPU 0 finishes grace-period initialization.
> 
> 7.      If CPU 1’s rcutorture reader is preempted, it will be added to
>         the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
>         set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
>         will not be updated.  Thus, this grace period will not wait on
>         it.  Which is only fair, given that the CPU did not come online
>         until after the grace period officially started.
> 
> 8.      CPUs 0 and 2 then detect the new grace period and then report
>         a quiescent state to the RCU core.
> 
> 9.      Because CPU 1 was offline at the start of the current grace
>         period, CPUs 0 and 2 are the only CPUs that this grace period
>         needs to wait on.  So the grace period ends and post-grace-period
>         cleanup starts.  In particular, the root rcu_node structure's
>         ->gp_seq field is updated to indicate that this grace period
>         has now ended.
> 
> 10.     CPU 2 continues running rcu_torture_writer() and sees that,
>         from the viewpoint of the root rcu_node structure consulted by
>         the poll_state_synchronize_rcu_full() function, the grace period
>         has ended.  It therefore updates state accordingly.
> 
> 11.     CPU 1 is still running the same RCU reader, which notices this
>         update and thus complains about the too-short grace period.

I think I get the race but I must confess I'm not very familiar with how this
all materialize on CPU 2's rcu_torture_writer() and CPU 1's rcu_torture_reader().

Basically this could trigger on CPU 1 with just doing the following, right?

rcu_read_lock()
get_state_synchronize_rcu_full(&rgos);
WARN_ON_ONCE(poll_state_synchronize_rcu_full(&rgos))
rcu_read_unlock()

> 
> The fix is for the get_state_synchronize_rcu_full() function to use
> rcu_state.gp_seq instead of the the root rcu_node structure's ->gp_seq
> field.  With this change in place, if step 5's cookie indicates that the
> grace period has not yet started, then any prior code executed by CPU 2
> must have happened before CPU 1 came online.  This will in turn prevent
> CPU 1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
> thus preventing CPU 1 from being subjected to a too-short grace period.
> 
> This commit therefore makes this change.  Note that there is no change to
> the poll_state_synchronize_rcu_full() function, which as noted above,
> must continue to use the root rcu_node structure's ->gp_seq field.
> This is of course an asymmetry between these two functions, but is an
> asymmetry that is absolutely required for correct operation.  It is a
> common human tendency to greatly value symmetry, and sometimes symmetry
> is a wonderful thing.  Other times, symmetry results in poor performance.
> But in this case, symmetry is just plain wrong.
> 
> Nevertheless, the asymmetry does require an additional adjustment.
> It is possible for get_state_synchronize_rcu_full() to see a given
> grace period as having started, but for an immediately following
> poll_state_synchronize_rcu_full() to see it as having not yet started.
> Given the current rcu_seq_done_exact() implementation, this will
> result in a false-positive indication that the grace period is done
> from poll_state_synchronize_rcu_full().  This is dealt with by making
> rcu_seq_done_exact() reach back three grace periods rather than just
> two of them.
> 
> Although this fixes 91a967fd6934 ("rcu: Add full-sized polling for
> get_completed*() and poll_state*()"), it is not clear that it is worth
> backporting this commit.  First, it took me many weeks to convince
> rcutorture to reproduce this more frequently than once per year.  Second,
> this cannot be reproduced at all without frequent CPU-hotplug operations,
> as in waiting all of 50 milliseconds from the end of the previous
> operation until starting the next one.  Third, the TREE03.boot settings
> cause multi-millisecond delays during RCU grace-period initialization,
> which greatly increase the probability of the above sequence of events.
> (Don't do this in production workloads!)  Fourth, extremely heavy use of
> get_state_synchronize_rcu_full() and/or poll_state_synchronize_rcu_full()
> is required to reproduce this, and as of v6.12, only kfree_rcu() uses it,
> and even then not particularly heavily.

I'm wondering, what prevents us from removing rcu_state.gp_seq and rely only on
the root node for the global state ?

Thanks.
