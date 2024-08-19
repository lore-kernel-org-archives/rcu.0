Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044318B04
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030366; cv=none; b=UBM9sm0fw/hsbcqS4j36gPVDtJvHfmJ7b/DUuilGuo1bxgylPiIkDHKe+AfqkIHL66zv/E7yX5XdOWl3+QWzKWQE2XVIXwsOa16g+Gs3FT49Wqn6Ytu81DzYrp2Ubh3FmiR98+7DKbG/pcSZgMrOrlZbxLDe+vtGDxFJh+MnzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030366; c=relaxed/simple;
	bh=yRtgzhW9f7brC9fd+R7tw/vB3EdsLOvareBAoRuyM38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjOR14Vu9sxWbAXXXkhv16mDgHELSFAgEls5QTWEcCpmq1kcvFXhgm/+QGB8UFigutzvLHI/8s6fRnKjCF7pGu4XnoAeiBF9/EzLM+u9Z0mXoOe9P6u3RVVKIf8ydwg9ZduBDCZkbTW6zL267ClhOEQBMvdxyUg8bPp9Ye+flMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBV1DdQ+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBV1DdQ+"
Date: Sun, 18 Aug 2024 21:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724030361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93V9lMnzGvfcNMSmk5p1gJMVRDEuqdf6QVqQ0ZwHnTg=;
	b=qBV1DdQ+9eJsDHkw7sNJvoLgMaro70CflF3qLg8rPnjY+p56zm6WWn8T5bg64juzOM3yTx
	6+oeKug414GK9J6oAUtXtwgoSD0BXUUgTC7dxzAutGaSbYIqANr4i4Y8Ekjz/xCwTH4G2x
	VkmDtV3Xk03O5CIGgrsGPmpw2qdZ07k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
References: <cqs6e6daupkzbjphltpbo5ljwut2lteji2ips3rpihlak5yjbp@im5ksmjjsrh6>
 <w52nycocowsq7jiay3ybhpsy4h6bl6t6nqew4wk2dolzvn5mql@rv3nffcb7q7q>
 <7da0d749-e482-402e-9241-6c7d5f29e39a@paulmck-laptop>
 <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 18, 2024 at 10:01:42AM GMT, Paul E. McKenney wrote:
> But you only need one callback per live outstanding "cookie" returned
> from get_state_synchronize_rcu*() or start_poll_synchronize_rcu().
> Or am I missing something here?

Maybe I am?

I've been assuming that if rcu callbacks are getting punted off to a
kthread that we can't rely on them being completed in any particular
timeframe - i.e. the number of grace periods with outstanding callbacks
would be unbounded.

You're saying that NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE _does_ include
grace periods with outstanding callbacks? Just want to be clear on that.

> If so, create a structure that as an rcu_head structure and a
> cookies.  Create an array of this structure (possibly on a per-CPU,
> per-shard, or whatever basis), sized by NUM_ACTIVE_RCU_POLL_OLDSTATE or
> NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE, depending on which set of APIs you
> are using.  Have a lock that guards the full array.
> 
> You also need some sort of structure tracking whatever data elements
> for which the grace periods are intended, but I will not speculate
> on what that might be.
> 
> Then when you have a data element that needs to wait for a grace period:
> 
> 1.	Get a cookie from get_state_synchronize_rcu() or similar.
> 
> 2.	Acquire the lock.
> 
> 3.	If this cookie is already in the array, release the lock and
> 	you are done.  (Give or take associating the cookie with the
> 	data element, however you choose to do this.)
> 
> 4.	If this cookie has already expired (it can happen!), set the new
> 	data element up to be processed (or maybe process it immediately,
> 	as the case may be).  Proceed to the next step only for unexpired
> 	new cookies, otherwise, release the lock.

There's another race, though - we're associating sequence numbers from
get_state_synchrize_rcu() with call_rcu() callbacks, and that's racy -
they can end up with different grace periods...

I think solving that would require a call_rcu_for_gp() API that takes
the sequence number we previously got from get_state_synchronize_rcu().

I think we can avoid your race in #4 entirely by simply waiting until we
have irqs disabled to call get_state_synchronize_rcu() (at least for the
normal RCU variant, the SRCU variant will naturally need a
srcu_read_lock() if we want to handle it that way).

That might be beneficial because then call_rcu_for_gp() can never race
with the grace period expiring.
