Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1F1E49B
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628334; cv=none; b=K2WRZW+5NkazTy5qEETBtEoOEOROCRW1UEPus6LczvwwGn8xLsIJdOfvqPezJ4sYGQTufdF9PZtBcIdY1R8ZLZYwJdmelL9xPg7pfd7vXAGEiMN2qWbjT8hynVftaQjlnmG2TTZip/iov3uJ1tv9GjrEq/YPCZjJbRb6qV8uYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628334; c=relaxed/simple;
	bh=dMTYHJdyPsxpheTnHqPvIWuYxEJDGeV/dKrbPye8TS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qESnEl6fVWqEMMVriM3jPf2Ab1Nj5bFJiSz9Arwvb3/brG71oZgeWtL5TXhg8xvk4AHGgN2CnmnP4tWN4O5LqEfRQwopyZiqLgSBpYmU1TOzGfhTuTGuN+5u6dmaSCrjqHVZ+roM9PCV717Mnr+KjGvz7hL2Bi803aVHN/gxsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlSMXD21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlSMXD21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987B2C4CEC4;
	Fri,  6 Sep 2024 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725628333;
	bh=dMTYHJdyPsxpheTnHqPvIWuYxEJDGeV/dKrbPye8TS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlSMXD21xDndDXeYzoGJv14weEr9+NP2bXOKOM6eh4rSqDtf4hBKHJv4IJS0deD4U
	 ZvLMdodWv5MB3OXnmlIAPk0+Zww8ZeqDdMbpRez8k7Fp2yecPAXSYKTJKPGOwsJQW2
	 p+xEJh0aL8TfDm4BlJCLhAHuHHlfAJq0OQgM2CwlH9AXbVsGgjJsHdF6tnkMthJ0KS
	 8BNRUDXHVke81X448lNff2NQOqvPhzwuq02hd1CynLWkNJnorjX/0Z+94KEUR+hmUF
	 0g30idxhflZ0yaakBy0dssIx2IrSmq7bD3O/BI/j/uUoCph/RTDbBDEbSWnYQloaAn
	 ZsxdDAVGX3hYQ==
Date: Fri, 6 Sep 2024 15:12:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <Ztr_q9dJIYdmc3q_@pavilion.home>
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>

Le Thu, Sep 05, 2024 at 11:04:22PM -0700, Paul E. McKenney a écrit :
> On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > > embarassing issue while I'm going through it again).
> > > > 
> > > > Very good, thank you!
> > > 
> > > So my proposal for a replacement patch is this (to replace the patch
> > > of the same name in Neeraj tree):
> > 
> > FYI, the diffstat against the previous version of the same patch is as follows.
> > The rationale being:
> > 
> > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> > 
> > 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
> >    after the barrier's completion.
> > 
> > 3) This fixes another issue: rcuoc must be parked _before_
> >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
> >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
> >    leaving the nocb locked forever.
> 
> Thank you!!!
> 
> Just to make sure that I understand, I apply this patch on top of
> Neeraj's current set of branches to get the fix, correct?

Exactly!

Thanks.
