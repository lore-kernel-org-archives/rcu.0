Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B32512FC;
	Wed, 19 Mar 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374736; cv=none; b=My1DsUX9kq28JzQtb/ntunvEGSPqDbM/R29seGVbZfyp1bMDaDQxGEycW/TUEIxVhr8pcSm+dGfgSuUfx1wGjPWaIpBw6oVfXlXgbs8XvEP7x2+BYAGeqtB1uMY0RtEHr565ZRPtqnU+m4aEVTFDOjxaN97wYRx4FCigbtJ+CY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374736; c=relaxed/simple;
	bh=WsVVOaBwyU1bbEcuFrpSdVBF7zi0aCyJ+vDqTFm9QTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvxGoLHn7tyg1JLn4qtz41pSTPFwCqbWAYXV2YkM7IOmwOhwWam4ISTM2RlwxhbdNBmmFVtU3pbWLdl++N9ChF2bIF61GoCX2sHcOS6DxcSzKY01d1IPuXoXopFP9DlNR1y8PrT+DNF/8R1IRm+RzTTcdILFthS+1sAnV/FeCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXge8hE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXge8hE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B2AC4CEE9;
	Wed, 19 Mar 2025 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742374736;
	bh=WsVVOaBwyU1bbEcuFrpSdVBF7zi0aCyJ+vDqTFm9QTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXge8hE4alABdrccZp3ALjHZDj0mVJLXmo/aZfpw6iXAIPISxoF+9Z2PY2hVQP7m7
	 6ThEAALVsCCVLM/CrXqYVk2e7U1RL35LsJgmAKEfCFdWy24SUc8t9wSZXnOAAn5bof
	 3T7VkX72wiEYMz6GJ3J/SztzlfW0PXEvbZTEvPpczrc1z5JlJ0MjRe9PeYIDUDO4PD
	 qYL/wREJ1m4gA2h320t6pzfNJU1D1hvQVlFpLKhFw7/NwoUC69p1mJnxksFUU8HcML
	 Rzl7AWgoultjKBK8mRvj9/6eDhjNTouzKL9JDv3yvgKcWbz7O2fgzCg9ScSYTgC+Xl
	 6bfYlV92JyHYQ==
Date: Wed, 19 Mar 2025 09:58:51 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
Message-ID: <Z9qHS-X1kSNzSkAi@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
 <2f9c13de-1e32-4cfb-8cfa-badb26a15bb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f9c13de-1e32-4cfb-8cfa-badb26a15bb6@paulmck-laptop>

Le Tue, Mar 18, 2025 at 10:17:16AM -0700, Paul E. McKenney a écrit :
> On Fri, Mar 14, 2025 at 03:36:38PM +0100, Frederic Weisbecker wrote:
> > When a grace period is started, the ->expmask of each node is set up
> > from sync_exp_reset_tree(). Then later on each leaf node also initialize
> > its ->exp_tasks pointer.
> > 
> > This means that the initialization of the quiescent state of a node and
> > the initialization of its blocking tasks happen with an unlocked node
> > gap in-between.
> > 
> > It happens to be fine because nothing is expected to report an exp
> > quiescent state within this gap, since no IPI have been issued yet and
> > every rdp's ->cpu_no_qs.b.exp should be false.
> > 
> > However if it were to happen by accident, the quiescent state could be
> > reported and propagated while ignoring tasks that blocked _before_ the
> > start of the grace period.
> > 
> > Prevent such trouble to happen in the future and initialize both the
> > quiescent states mask to report and the blocked tasks head from the same
> > node locked block.
> > 
> > If a task blocks within an RCU read side critical section before
> > sync_exp_reset_tree() is called and is then unblocked between
> > sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), the QS
> > won't be reported because no RCU exp IPI had been issued to request it
> > through the setting of srdp->cpu_no_qs.b.exp.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> OK, and because ->expmaskinit has all bits set for all CPUs that have
> ever been online, the ends of any corresponding readers will give up at
> the beginning of the first pass of the loop in __rcu_report_exp_rnp().
> This is because the ->expmask is guaranteed to be non-zero.  (Which is
> kind of what you are saying in the last paragraph of your commit log,
> just digging down another layer.)

Exactly!

Thanks.
