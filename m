Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF87345D;
	Wed,  5 Jun 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612731; cv=none; b=Np9Uw+Pr30mwz9S5F7oGZESiy7S+881S9EkEPskszHj2UJdTvFc0YnY0eFDs2NrVJiWsEj4vWE5Xv2vIGOQOuK5gcbLh7e/Q3i9lCHFryIEF31DsCjPQfL6EO6xVARri7pIBuOMxcDvmdKsOj3B4zLz462i0+tg8DEKOQBcMoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612731; c=relaxed/simple;
	bh=rJZv5S1T81gAQR2GyAwP+apEECmT/s44XmdQwBJ6HAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/UWCZKW2c6IMOCXW9yE57T0QnmXaVx5mzjX2/OKuLA+Hzw7qKFPs0rgJHjk88D0+TsBGbBM3wCep68Nc8DXa7pvDRkdoOQLoFPO2s1b9AQfGXhou0hMh5O5Yiu10PVyQkJRNGppcBLMXERE03WI7THh3r64eXdi9aH9NpAt3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTn9fSEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTn9fSEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B60C2BD11;
	Wed,  5 Jun 2024 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612730;
	bh=rJZv5S1T81gAQR2GyAwP+apEECmT/s44XmdQwBJ6HAQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lTn9fSEhDboHizyyo0aTNVR+Rw1sp0gFplDnsg5DX6zWCEhPwaoctK0t1sMgCvtR/
	 Dh8SCFvDkKmzrCIoX7qqnj15SOsZ3zLWALjT2sc8nV5ug7uTSgxnx9S6z4yvtFUxKL
	 I6utdc5An8Kj847U0mOgCzDiyT4vS8GZz+eJfemqFcZbvJSHto8gDv6c32yuCaKM+8
	 9BRs03mlRFjk/JZCSYdvAfTbwKqrhA0OY81s2G0Ix3/786mpFD/utBlCWciBUuoG0h
	 C1688xCDXPnFloKQjy3s+H5Bjb1BgQDg/VL6IAwWQeWG9U7NJ8jhQhr43QHY3nTeiR
	 gtL4JSL5dixog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88A1BCE0A73; Wed,  5 Jun 2024 11:38:50 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:38:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all
 wait heads are in use
Message-ID: <c7d07e5d-34a0-4874-8e7e-1c576c14c8e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-2-paulmck@kernel.org>
 <ZmBVfpyEZeTIAHJn@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmBVfpyEZeTIAHJn@localhost.localdomain>

On Wed, Jun 05, 2024 at 02:09:34PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:23:48PM -0700, Paul E. McKenney a écrit :
> > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > When all wait heads are in use, which can happen when
> > rcu_sr_normal_gp_cleanup_work()'s callback processing
> > is slow, any new synchronize_rcu() user's rcu_synchronize
> > node's processing is deferred to future GP periods. This
> > can result in long list of synchronize_rcu() invocations
> > waiting for full grace period processing, which can delay
> > freeing of memory. Mitigate this problem by using first
> > node in the list as wait tail when all wait heads are in use.
> > While methods to speed up callback processing would be needed
> > to recover from this situation, allowing new nodes to complete
> > their grace period can help prevent delays due to a fixed
> > number of wait head nodes.
> > 
> > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> IIRC we agreed that this patch could be a step too far that
> made an already not so simple state machine even less simple,
> breaking the wait_head based flow.

True, which is why we agreed not to submit it into the v6.10 merge window.

And I don't recall us saying what merge window to send it to.

> Should we postpone this change until it is observed that a workqueue
> not being scheduled for 5 grace periods is a real issue?

Neeraj, thoughts?  Or, better yet, test results?  ;-)

							Thanx, Paul
