Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5F35976;
	Fri, 24 Jan 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747655; cv=none; b=pIoD6IuSXozKDIvCt50N3BqfZ1rMJ7yFrtIru6i7liZz7Tk69jlyBC5138BWDqelhpaEahGC3LdBh+Z9UxjQwGtDa3t41oSNrHFghT16akTwsVX+ZiVFt6CNSWWriTS4H9zqzMrpvK0ElKOyLH3GzwP+AWvlxBSatvfa7E6+/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747655; c=relaxed/simple;
	bh=lE1EkZWIrBztI7OVcDQv/fAW14WfDobf5o2gaozfA0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOGpzq6Ww7+jySx3sa87LmQXOF4uz3mXi6QhkDzwDVmgpDII/0+WA+nb9MaZojo56lHDLuV0fy8cPUOCcTvrPJ3eOTW5HbxVX79j3AYWC/2CskhU+4o+QJzpK8sU+vCSbtX0DoYc4P0FR5N27YFNZEbX6XfS+uL76gztxcyJ0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH9U6pu2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH9U6pu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C79EC4CED2;
	Fri, 24 Jan 2025 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737747654;
	bh=lE1EkZWIrBztI7OVcDQv/fAW14WfDobf5o2gaozfA0E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZH9U6pu2cmiBPVcG64XA+OwlHwxX6bj/wPW9Vh5dM5rcFxzbKzVT52+QRCWLnIuLK
	 zZIQvGwkqwSlP6IeO4HNPtYp8GmhwMmPjZSC/7BIuORCOd4xSAIiKuzRRlWQgtZjD3
	 DtI4owhP7G7S/XqyMzacs+QtJ6Xf6rqHg3HV+kTT6WnF3aFB+68NCWYY/AhCgB1day
	 R0XRE6e32diOldKdsZuPP0Vsb+NOZUjPsBT4NmpzBalLEhSYL5AT7VrOg72BYKCqQE
	 IApbYN1Gler935PWoAaVjfRF/YEk/DH1zLaZ9qtVXtweS+AKEItXDIO+MfIV2vQUrE
	 1IrXfXN7s3PEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 435FACE1311; Fri, 24 Jan 2025 11:40:54 -0800 (PST)
Date: Fri, 24 Jan 2025 11:40:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <c58693df-24dc-4c2a-b04a-d96637235e09@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5OodAwpjRtR4lvv@localhost.localdomain>
 <19388b60-5e71-463d-ba68-9064d0caa224@paulmck-laptop>
 <Z5PC9Rs1C2NIBR8k@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5PC9Rs1C2NIBR8k@localhost.localdomain>

On Fri, Jan 24, 2025 at 05:42:29PM +0100, Frederic Weisbecker wrote:
> Le Fri, Jan 24, 2025 at 07:58:20AM -0800, Paul E. McKenney a écrit :
> > On Fri, Jan 24, 2025 at 03:49:24PM +0100, Frederic Weisbecker wrote:
> > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> > > > The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
> > > > functions use the root rcu_node structure's ->gp_seq field to detect
> > > > the beginnings and ends of grace periods, respectively.  This choice is
> > > > necessary for the poll_state_synchronize_rcu_full() function because
> > > > (give or take counter wrap), the following sequence is guaranteed not
> > > > to trigger:
> > > > 
> > > >         get_state_synchronize_rcu_full(&rgos);
> > > >         synchronize_rcu();
> > > >         WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));
> > > > 
> > > > The RCU callbacks that awaken synchronize_rcu() instances are
> > > > guaranteed not to be invoked before the root rcu_node structure's
> > > > ->gp_seq field is updated to indicate the end of the grace period.
> > > > However, these callbacks might start being invoked immediately
> > > > thereafter, in particular, before rcu_state.gp_seq has been updated.
> > > > Therefore, poll_state_synchronize_rcu_full() must refer to the
> > > > root rcu_node structure's ->gp_seq field.  Because this field is
> > > > updated under this structure's ->lock, any code following a call to
> > > > poll_state_synchronize_rcu_full() will be fully ordered after the
> > > > full grace-period computation, as is required by RCU's memory-ordering
> > > > semantics.
> > > > 
> > > > By symmetry, the get_state_synchronize_rcu_full() function should also
> > > > use this same root rcu_node structure's ->gp_seq field.  But it turns out
> > > > that symmetry is profoundly (though extremely infrequently) destructive
> > > > in this case.  To see this, consider the following sequence of events:
> > > > 
> > > > 1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
> > > >         accordingly.
> > > > 
> > > > 2.      As its first step of grace-period initialization, CPU 0 examines
> > > >         the current CPU hotplug state and decides that it need not wait
> > > >         for CPU 1, which is currently offline.
> > > > 
> > > > 3.      CPU 1 comes online, and updates its state.  But this does not
> > > >         affect the current grace period, but rather the one after that.
> > > >         After all, CPU 1 was offline when the current grace period
> > > >         started, so all pre-existing RCU readers on CPU 1 must have
> > > >         completed or been preempted before it last went offline.
> > > >         The current grace period therefore has nothing it needs to wait
> > > >         for on CPU 1.
> > > > 
> > > > 4.      CPU 1 switches to an rcutorture kthread which is running
> > > >         rcutorture's rcu_torture_reader() function, which starts a new
> > > >         RCU reader.
> > > > 
> > > > 5.      CPU 2 is running rcutorture's rcu_torture_writer() function
> > > >         and collects a new polled grace-period "cookie" using
> > > >         get_state_synchronize_rcu_full().  Because the newly started
> > > >         grace period has not completed initialization, the root rcu_node
> > > >         structure's ->gp_seq field has not yet been updated to indicate
> > > >         that this new grace period has already started.
> > > > 
> > > >         This cookie is therefore set up for the end of the current grace
> > > >         period (rather than the end of the following grace period).
> > > > 
> > > > 6.      CPU 0 finishes grace-period initialization.
> > > > 
> > > > 7.      If CPU 1’s rcutorture reader is preempted, it will be added to
> > > >         the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
> > > >         set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
> > > >         will not be updated.  Thus, this grace period will not wait on
> > > >         it.  Which is only fair, given that the CPU did not come online
> > > >         until after the grace period officially started.
> > > > 
> > > > 8.      CPUs 0 and 2 then detect the new grace period and then report
> > > >         a quiescent state to the RCU core.
> > > > 
> > > > 9.      Because CPU 1 was offline at the start of the current grace
> > > >         period, CPUs 0 and 2 are the only CPUs that this grace period
> > > >         needs to wait on.  So the grace period ends and post-grace-period
> > > >         cleanup starts.  In particular, the root rcu_node structure's
> > > >         ->gp_seq field is updated to indicate that this grace period
> > > >         has now ended.
> > > > 
> > > > 10.     CPU 2 continues running rcu_torture_writer() and sees that,
> > > >         from the viewpoint of the root rcu_node structure consulted by
> > > >         the poll_state_synchronize_rcu_full() function, the grace period
> > > >         has ended.  It therefore updates state accordingly.
> > > > 
> > > > 11.     CPU 1 is still running the same RCU reader, which notices this
> > > >         update and thus complains about the too-short grace period.
> > > 
> > > I think I get the race but I must confess I'm not very familiar with how this
> > > all materialize on CPU 2's rcu_torture_writer() and CPU 1's rcu_torture_reader().
> > > 
> > > Basically this could trigger on CPU 1 with just doing the following, right?
> > > 
> > > rcu_read_lock()
> > > get_state_synchronize_rcu_full(&rgos);
> > > WARN_ON_ONCE(poll_state_synchronize_rcu_full(&rgos))
> > > rcu_read_unlock()
> > 
> > CPU 1 would do rcu_read_lock()/checks/rcu_read_unlock() as the
> > reader, and CPU 2 would do get_state_synchronize_rcu_full(), later
> > poll_state_synchronize_rcu_full(), which would (erroneously) indicate
> > a completed grace period, so it would update the state, triggering CPU
> > 1's checks.
> 
> I see, so if I generalize the problem beyond rcutorture, this looks like this,
> right?
> 
> CPU 0                                    CPU 1                       CPU 2
> -----                                    ------                      -----
> 
> rcu_seq_start(rcu_state.gp_seq)
>                                          // CPU boots
>                                          rcu_read_lock()
>                                          r0 = rcu_dereference(*X)
>                                                                      r1 = *X
>                                                                      *X = NULL
>                                                                      // relies on rnp->gp_seq and not rcu_state.gp_seq
>                                                                      get_state_synchronize_rcu_full(&gros)
> WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> rcu_report_qs_rdp()
>                                                                       rcu_report_qs_rdp()
>                                                                       rcu_report_qs_rnp()
>                                                                       rcu_report_qs_rsp()
>                                                                       if (poll_state_synchronize_rcu_full(&rgos))
>                                                                           kfree(r1)
>                                           // play with r0 and crash

That would do it!

> > > I'm wondering, what prevents us from removing rcu_state.gp_seq and rely only on
> > > the root node for the global state ?
> > 
> > One scenario comes to mind immediately.  There may be others.
> > 
> > Suppose we were running with default configuration on a system with
> > "only" eight CPUs.  Then there is only the one rcu_node structure,
> > which is both root and leaf.  Without rcu_state.gp_seq, there
> > would be no way to communicate the beginning of the grace period to
> > get_state_synchronize_rcu_full() without also allowing quiescent states
> > to be reported.  There would thus be no time in which to check for newly
> > onlined/offlined CPUs.
> 
> Heh, that makes sense! Though perhaps that qsmaskinit[next] handling part
> could be done before rcu_seq_start()?

If we do that, aren't we vulnerable to a CPU coming online just after
we handled qsmaskinit{,next} and just before we do rcu_seq_start()?

							Thanx, Paul
