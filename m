Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17071DB363;
	Fri, 24 Jan 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757504; cv=none; b=rxI77GylGAnGBY6skWtN/PniqgP5sxS7c4yYnUjmYMl6+GYwyGuTiwc+6QPEUT8xTtJjNMGkT18pYpz8t4Qxk5ftzezoZ+snklFjVLIYVoCGgVSK0FYQoENhfZipTa6ayiKz4vN0MAqY5U6biZxeoLTuoYyrcY4QO3opivJV9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757504; c=relaxed/simple;
	bh=E91BsmT4uBq66nO5ltIAvemXBAp7PUSz3w4HGPFzw1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT/Cls6suxUsOUNPoHSDfm2HwhqIrSKl+WMizF7SHAil5EdrGZJ5MbvzR/382V9aI1uBEA5nRqeUikyN3h7BpYWMaq2lAxpgge1uNfuNSOCf6//ZIcOfavU5OG9Zu5hgZ5RlBS11m1TeIcmn0Ui4GTODovEegZPV66ILgwXc1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsbeTSDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsbeTSDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA744C4CED2;
	Fri, 24 Jan 2025 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737757504;
	bh=E91BsmT4uBq66nO5ltIAvemXBAp7PUSz3w4HGPFzw1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsbeTSDCMiqc7cho4Nr/p1tirbs0FgfSFQL9hwwahfRGpoOO5lgMRkzXswZdbGaun
	 5qkzFb2RVVk3LwPeOV3mkRTAP8DDI/CmTEGiVxqKlIVqLn024lelHNMTlGil3Dn5nA
	 EhAECYoA44c1q1ejt83MnCFPXYhfu1fj2b7EU4JF9d3UcNUSptaBQ50b0uvbf+0Czm
	 IBrYTTwwPzhHq2aWsbt3MLmA+3n8femkZ8iI+kaRwy0mEwKnlzCF9ngftPnB3fUU9n
	 a9O2MiNTc0HjxZDzYMna5V9pBg6FqfB6UUSGuKBMQyp/Bhy+TgEhg7U+qdapfP8+9T
	 eptMiaKMItyAg==
Date: Fri, 24 Jan 2025 23:25:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <Z5QTPWMUzqEE-h6A@pavilion.home>
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5OodAwpjRtR4lvv@localhost.localdomain>
 <19388b60-5e71-463d-ba68-9064d0caa224@paulmck-laptop>
 <Z5PC9Rs1C2NIBR8k@localhost.localdomain>
 <c58693df-24dc-4c2a-b04a-d96637235e09@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c58693df-24dc-4c2a-b04a-d96637235e09@paulmck-laptop>

Le Fri, Jan 24, 2025 at 11:40:54AM -0800, Paul E. McKenney a écrit :
> > > > I'm wondering, what prevents us from removing rcu_state.gp_seq and rely only on
> > > > the root node for the global state ?
> > > 
> > > One scenario comes to mind immediately.  There may be others.
> > > 
> > > Suppose we were running with default configuration on a system with
> > > "only" eight CPUs.  Then there is only the one rcu_node structure,
> > > which is both root and leaf.  Without rcu_state.gp_seq, there
> > > would be no way to communicate the beginning of the grace period to
> > > get_state_synchronize_rcu_full() without also allowing quiescent states
> > > to be reported.  There would thus be no time in which to check for newly
> > > onlined/offlined CPUs.
> > 
> > Heh, that makes sense! Though perhaps that qsmaskinit[next] handling part
> > could be done before rcu_seq_start()?
> 
> If we do that, aren't we vulnerable to a CPU coming online just after
> we handled qsmaskinit{,next} and just before we do rcu_seq_start()?

But then that CPU is guaranteed to see the pre-GP accesses because
rcutree_report_cpu_starting() holds the rnp lock.

Hmm but it won't see the starting gp_seq and it might therefore be one GP
too early while accelerating its own callbacks (mis-attributing them the
current GP in progress instead of a subsequent one) even though other CPUs
may have reported their own QS already.

Because I only now realize this necessary order while starting a grace period:

1) rcu_seq_start(rcu_state.gp_seq)
2) go through ->qsmaskinit[next] _while holding leaf rnp locks_
3) go through the whole tree breadth first to reflect rcu_state.gp_seq to
   rnp->gp_seq. CPUs may start reporting QS concurrently once the first leaf
   node is reached

And the step 2) with its fully ordered locking on leaves which release the write
to rcu_state.gp_seq is what makes sure that if any CPU from step 3) has already
reported a QS, it is guaranteed that any call to rcu_seq_snap() under any other
leaf rnp locking will return the sequence of the subsequent GP number and not the
current one in progress.

This is what makes RCU an entertaining companion. You (think you) understand
it in the evening and then you forget it all over again in the next morning.
(And in lunch time you stare at things...).

Thanks.
