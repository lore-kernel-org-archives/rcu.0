Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748618A93E;
	Fri, 24 Jan 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759023; cv=none; b=GYt4c5n9Mf4/BoeLQk0OS5RaPbnSRlRGiO+rpawr85nQp+i4QRicqZDYZiOMOlnyWbrTN6Mo8FVEImnrxEe/KXuL5kahw0pcXDsDIAvb4MMRGb/Xy2nNakuCzuBB9fUDWNMpeEtPwoAgex3N8DgVxLLgn9iD6rKOMy2RVl/Izh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759023; c=relaxed/simple;
	bh=h2EuH2czpoPPXO5B+4dIwHkRsdrKx2PCo110QKZ55vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yofl1ZRbu0gcT4NFzmgZlyrUc8UzVhX/ujLhh7KhzOn5jBFT/kr40KwA7iMAT70zwK+sPSA8G5zr1PGf9WQUWL0vQN8ncLDZchFjSuIQbkaFypTGOB4T/rY9eK5MqphCIa26dZtexYzO/meTeBb2XytSc4QcKBS6zKNxU5vOMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXGzhUgn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXGzhUgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A085C4CED2;
	Fri, 24 Jan 2025 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737759022;
	bh=h2EuH2czpoPPXO5B+4dIwHkRsdrKx2PCo110QKZ55vM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jXGzhUgnLTx/QZNwAemzE+5nji122Mq4lE/SxnK7+G9vxvwUlmXaSFhFQ671wxJs/
	 kqcs8/jQ8MlqvaFxvb3n+88McdMEjCG2FntmoigZ/tWr5oomCmSbSK/j9gB9q0dypV
	 9pOgg7EEatuyFbmXZ8yJCLDSgLTdtXR91FGay0BPzgKz4W+UFXAqh+9D8ogRrJc+OW
	 lej2hWvMhrwYll9GBLIeMHaOwbYnI164jjX30dLaxo0DSLBLbmvyqYBWKC3D94wX0y
	 TvqddFMgHPDOPxLRgekyCQA8pUgC2gD7IfKYgD1AvuTW/hE0a7leVlkusIRT/61FzI
	 paIi2pulR8JEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0BD9DCE13C2; Fri, 24 Jan 2025 14:50:22 -0800 (PST)
Date: Fri, 24 Jan 2025 14:50:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <5bfcc3ac-1638-4ce3-bc14-1a08c9aa7075@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5OodAwpjRtR4lvv@localhost.localdomain>
 <19388b60-5e71-463d-ba68-9064d0caa224@paulmck-laptop>
 <Z5PC9Rs1C2NIBR8k@localhost.localdomain>
 <c58693df-24dc-4c2a-b04a-d96637235e09@paulmck-laptop>
 <Z5QTPWMUzqEE-h6A@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5QTPWMUzqEE-h6A@pavilion.home>

On Fri, Jan 24, 2025 at 11:25:01PM +0100, Frederic Weisbecker wrote:
> Le Fri, Jan 24, 2025 at 11:40:54AM -0800, Paul E. McKenney a écrit :
> > > > > I'm wondering, what prevents us from removing rcu_state.gp_seq and rely only on
> > > > > the root node for the global state ?
> > > > 
> > > > One scenario comes to mind immediately.  There may be others.
> > > > 
> > > > Suppose we were running with default configuration on a system with
> > > > "only" eight CPUs.  Then there is only the one rcu_node structure,
> > > > which is both root and leaf.  Without rcu_state.gp_seq, there
> > > > would be no way to communicate the beginning of the grace period to
> > > > get_state_synchronize_rcu_full() without also allowing quiescent states
> > > > to be reported.  There would thus be no time in which to check for newly
> > > > onlined/offlined CPUs.
> > > 
> > > Heh, that makes sense! Though perhaps that qsmaskinit[next] handling part
> > > could be done before rcu_seq_start()?
> > 
> > If we do that, aren't we vulnerable to a CPU coming online just after
> > we handled qsmaskinit{,next} and just before we do rcu_seq_start()?
> 
> But then that CPU is guaranteed to see the pre-GP accesses because
> rcutree_report_cpu_starting() holds the rnp lock.
> 
> Hmm but it won't see the starting gp_seq and it might therefore be one GP
> too early while accelerating its own callbacks (mis-attributing them the
> current GP in progress instead of a subsequent one) even though other CPUs
> may have reported their own QS already.
> 
> Because I only now realize this necessary order while starting a grace period:
> 
> 1) rcu_seq_start(rcu_state.gp_seq)
> 2) go through ->qsmaskinit[next] _while holding leaf rnp locks_
> 3) go through the whole tree breadth first to reflect rcu_state.gp_seq to
>    rnp->gp_seq. CPUs may start reporting QS concurrently once the first leaf
>    node is reached
> 
> And the step 2) with its fully ordered locking on leaves which release the write
> to rcu_state.gp_seq is what makes sure that if any CPU from step 3) has already
> reported a QS, it is guaranteed that any call to rcu_seq_snap() under any other
> leaf rnp locking will return the sequence of the subsequent GP number and not the
> current one in progress.

Very good!!!

> This is what makes RCU an entertaining companion. You (think you) understand
> it in the evening and then you forget it all over again in the next morning.
> (And in lunch time you stare at things...).

That sums up many of my entertaining experiences with RCU over the past
three decades.  ;-)

							Thanx, Paul
