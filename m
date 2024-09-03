Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46D126BFE
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404640; cv=none; b=syV2p5YFacD/iTFEmN9vkT0jdmF8+76mQUtWhLs9A2rCqF1btc80lNBa1fVgqTcNbuTna0kNmoNmJ0xMPjIsY0xZz6F4/tjKnyQLjaq7T+fWV0+lPZq2Kt74PUtvpCRcW992GXmVwhVflfS2DyU8MQPbzq+WMSF3wvCr41eLq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404640; c=relaxed/simple;
	bh=AzWB2zWBnl2HTa7A0vuRTed9eq6EjywrkCnQ5fWo9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBYiWfK2REqZE9IjwAjeG5GY2jb9d54zvAixzv9ovh7rCyiO0sc3NG8NHK/ZWZFS/BhLh0Tv5KZUMClnodgzkARoCDIXSsfMQzKKixFnIR20UKxu0kMAZLPPmuv3g64iGUwW3grjq3ohVIek8eSXXldJ+OivZHLVGPunbVZu5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PqClv0kK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PqClv0kK"
Date: Tue, 3 Sep 2024 19:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725404636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jAlPcUUI+rbY65LhMY3kDUW+5VZoPR0KoHWBmgbLJkU=;
	b=PqClv0kKJ8hz993FGAZx520xvTkWfKVcJ2JpedEClD7ixZt9p76cxPN4HBY+IJTjipgJ2J
	KbreLClGm/neFVOKXoQMaD6QnDTE87rO9sE0oOMeu5HTuSs0FVIkE9ZqArD14wEFwSej9p
	+ZLv5D5wjVRwyYLiyth2TQw5dqDYFYE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <f4nkwsbqvpaxxqph3iucohfqy5zwn7j7u5uwppp7rp4mnx2eqj@lqxwtgboskik>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
 <gbar5cxixgq4jtxgtzv7xjipabhqqbwdwyrtahkkws3tregdvo@edqb7ku2uhk2>
 <0359b3a4-b6db-45d9-9957-b304b4a85865@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0359b3a4-b6db-45d9-9957-b304b4a85865@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 03:13:40PM GMT, Paul E. McKenney wrote:
> On Tue, Sep 03, 2024 at 05:38:05PM -0400, Kent Overstreet wrote:
> > On Tue, Sep 03, 2024 at 09:32:51AM GMT, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series provides light-weight readers for SRCU.  This lightness
> > > is selected by the caller by using the new srcu_read_lock_lite() and
> > > srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> > > srcu_read_unlock() flavors.  Although this passes significant rcutorture
> > > testing, this should still be considered to be experimental.
> > 
> > This avoids memory barriers, correct?
> 
> Yes, there are no smp_mb() invocations in either srcu_read_lock_lite()
> or srcu_read_unlock_lite().  As usual, nothing comes for free, so the
> overhead is moved to the update side, and amplified, in the guise of
> the at least two calls to synchronize_rcu().
> 
> > > There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> > > on a given srcu_struct structure, then no other flavor may be used on
> > > that srcu_struct structure, before, during, or after.  (2) The _lite()
> > > readers may only be invoked from regions of code where RCU is watching
> > > (as in those regions in which rcu_is_watching() returns true).  (3)
> > > There is no auto-expediting for srcu_struct structures that have
> > > been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> > > srcu_struct structures invoke synchronize_rcu() at least twice, thus
> > > having longer latencies than their non-_lite() counterparts.  (5) Even
> > > with synchronize_srcu_expedited(), the resulting SRCU grace period
> > > will invoke synchronize_rcu() at least twice, as opposed to invoking
> > > the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> > > srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> > > srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> > > from NMI handlers (that is what the _nmisafe() interface are for).
> > > Although one could imagine readers that were both _lite() and _nmisafe(),
> > > one might also imagine that the read-modify-write atomic operations that
> > > are needed by any NMI-safe SRCU read marker would make this unhelpful
> > > from a performance perspective.
> > 
> > So if I'm following, this should work fine for bcachefs, and be a nifty
> > small perforance boost.
> 
> Glad you like it!
> 
> > Can I give you an account for my test cluster? If you'd like, we can
> > convert bcachefs to it and point it at your branch.
> 
> Thank you, but I will pass on more accounts.  I have a fair amount of
> hardware at my disposal.  ;-)

Well - bcachefs might be a good torture test; if you patch bcachefs to
use the new API point me at a branch and I'll point the CI at it
