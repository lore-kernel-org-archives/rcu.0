Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F114BF87
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724041011; cv=none; b=LYj0EghZKW8JnVVuQc7RlHMkUmrRYjmjpTBUNWRMcWDEbCVSNln1cPYCpEYuJPn3m7NnJmDzKQ7fcIKRQ3C+IZzrKXVvk4YPYtwihRp2K3yJP/IWfGLHXofsLMm/O8T/MYpoqxN8QBThjvSl/gtSBzJvyz8u9k+HbwQ/Lixh3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724041011; c=relaxed/simple;
	bh=RZLgo8pidthhCiF7orj04wvumr5EFCTi1cNFbjnTwv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlyl4EgPgXWOK6KuqD8JhEbOWFtV/juGSvosmYfqlCyE3IQ/DOpU6fSfwFdW6xC947fPUlu5BHC/y8BdWk+s31blPYmIccleFK9z0Who/JmOyNQFp9kGcBemoCSugy88r4Z/onfEAxk127rUMDx+c+5x+OXaWKZapfnxKG9xlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLjv3lrY; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLjv3lrY"
Date: Mon, 19 Aug 2024 00:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724041006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFChj6wUPh+Y8LIlL5AlKv/tltS/yr1SpCw9bUb8/G4=;
	b=JLjv3lrYlPnkCYpU1fkuHQ6OBHG/VMMiNVTB07Mas5P6WMcWJccoHSsH5IAFm41w41Vkr0
	H/4TADjHsiwnRhnLA2N3+5f/z2xfwVAPWH1yReBtVG+B04/eQg46j/5l0DKzFmGi6V06Ap
	cCQCEmzkHSJgxEt8t6b5ABMbUW5xUUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
References: <w52nycocowsq7jiay3ybhpsy4h6bl6t6nqew4wk2dolzvn5mql@rv3nffcb7q7q>
 <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 18, 2024 at 08:52:59PM GMT, Paul E. McKenney wrote:
> On Sun, Aug 18, 2024 at 09:19:16PM -0400, Kent Overstreet wrote:
> > On Sun, Aug 18, 2024 at 10:01:42AM GMT, Paul E. McKenney wrote:
> > > But you only need one callback per live outstanding "cookie" returned
> > > from get_state_synchronize_rcu*() or start_poll_synchronize_rcu().
> > > Or am I missing something here?
> > 
> > Maybe I am?
> > 
> > I've been assuming that if rcu callbacks are getting punted off to a
> > kthread that we can't rely on them being completed in any particular
> > timeframe - i.e. the number of grace periods with outstanding callbacks
> > would be unbounded.
> 
> Exactly, and that is why there is a check for expired cookies during the
> addition of a new data element that needs to wait for a grace period.
> The only purpose of that call_rcu() callback is to act as a fallback in
> case there is a long period of time with no newly arriving data elements
> that need to wait for a grace period.
> 
> > You're saying that NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE _does_ include
> > grace periods with outstanding callbacks? Just want to be clear on that.
> 
> No, it does not, but given the algorithm outlined in my previous
> email, it doesn't need to.  The point of the callbacks is *not* to
> unconditionally drive things forward, but instead to provide a fallback
> to do the necessary processing in the case nothing new arrives for an
> extended period of time.

You can't use a fixed number of callback heads if there's going to be an
unbounded number of callback heads outstanding.
