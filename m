Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8841DD384
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109024; cv=none; b=c4rnYipU3/Pe/wfd7ONngGq6EsJEo6E6MDHEcXfhm7yksFarv/srbjUJoXaQsuxkv6WG/ukaw8f8KIVHYvGA4BtSSHO47n10tM9Uv6wS1q7OdLZbVmjjWfNtee1hF43qTUi6zFOSY0cBVQCFUX8ZuUo423YxVw3CzF5LMznuCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109024; c=relaxed/simple;
	bh=WjlEPKbC005jyucaafi40/1Vzje4cxeeh2FXLpRi5kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YupWANAtudFK/GYUNviw5WMCcyH5HveEzEGKdC4SddeDd8rav0T1atv4zqt3hbI5bDj/2WNttigRnFg8AdMF0SG8L4xpuMYW49JLjS7wMkSkUVxohfo7r98+fDaWEwzDA3tmoGDAK5m3RgRiPvJjJDau/RJD5aBitxTWnvTQ3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLulrpr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLulrpr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6982C32782;
	Mon, 19 Aug 2024 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724109023;
	bh=WjlEPKbC005jyucaafi40/1Vzje4cxeeh2FXLpRi5kk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mLulrpr1iM5Agn5sjrracLNDO+UTl+DvGqBdANKL/IqDlq5DP6bjb8aIusRT13vI1
	 y3jqJLsx5aoHOzW1nBqUVsP8gMEM5MAxv/cOE9X+KqvgNBMRS9Hs24p2PUA+chH7O1
	 yTd/PurhzyzwYP5J59UUMWohoptcs9/GxUi+7CamGwWe5yuw1FoutY/wtg8Mh7w3BT
	 RpxpHABlXXTaqGU6hQuTSPcSsDOmvE2s1CbKij0hYH+VDwEnbIC6hhBXw3k6byAMMq
	 R58HgZROWZ9RIadTp4E4tW8QE1x8Oo0Z/DsX9BboeuVIwk70+CifMp0UV+kGJ794/I
	 TPezmiHn0JnMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7AD12CE0A01; Mon, 19 Aug 2024 16:10:23 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:10:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <6c35998c-a35d-451b-b698-f1613bd8a2a2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
 <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
 <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
 <bkqpx3rbhbz2jw52ugubyjyr4eyn2pkkpzsiczz5emtokviie7@hh5yrqjysacw>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkqpx3rbhbz2jw52ugubyjyr4eyn2pkkpzsiczz5emtokviie7@hh5yrqjysacw>

On Mon, Aug 19, 2024 at 01:09:09PM -0400, Kent Overstreet wrote:
> On Mon, Aug 19, 2024 at 08:49:26AM GMT, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2024 at 11:14:02AM -0400, Kent Overstreet wrote:
> > By "number of outstanding grace period sequence numbers" you mean
> > the number of outstanding grace period sequence numbers that have
> > memory blocks that have not yet been processed?  If so, how could that
> > possibly matter more than the total number of memory blocks that have
> > not been processed, regardless of which grace-period number they are
> > associated with?  Why would a huge number of memory blocks fail to
> > cause an OOM simply because they happen to be associated with a single
> > grace-period number?  Or, to put it another way, suppose that same number
> > of memory blocks were distributed over a large number of grace-period
> > sequence numbers?  How could this possibly cause an OOM to be more likely
> > than if the same nubmer of memory blocks were associated with a single
> > grace-period number?
> 
> We just want a callback every time one of those grace periods expire, so
> the pending objects can be freed as soon as they're ready.
> 
> This isn't _fatal_ for the kvfree_rcu() backend, since we have memory
> reclaim to fall back on, but it would still definitely be preferable for
> rcu_pending to be getting the notification from core RCU and avoid the
> more expensive memory reclaim path.
> 
> It is more critical if we want to use this for a faster call_rcu()
> backend.

I am still missing why the call to process_finished_items() from
__rcu_pending_enqueue() cannot cover this.  Given the way that RCU works,
that has the potential to notify you *before* RCU's grace-period kthread
would get around to doing so.

							Thanx, Paul
