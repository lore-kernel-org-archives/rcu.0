Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F22AD2C
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080450; cv=none; b=MdAXDjCKBX+JJv04hIiNVmpJbMnQvrhH9EH22v4O6uBiUJB7vz/zG6g+7Obgq4+m2l5Bxo6QkMs56RAyg5q6cqTM94FZ6xcTrk/a1LRgXqLFdDzV9Ds6W3HC1kfFHfjPgBwPjzJ7wTV/p5n/bNtDEp/yEKvXQQG0xP3Pqkaup0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080450; c=relaxed/simple;
	bh=sMdr4O6hHprGc6+mL1JhXvL1ad6qa1W8d7NtHKywrik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw1vx+fDTSyr3KlJSkNonbA6raesawI96yspf7dvUAmBqDNNAnyiMMdEF1vK5NBqaL0iZYy8YCwtkekg9cgYse1Uda1qYFcXt34X+veb9xgay+Yq6fcVue9ZO1eozGuBzeIJ13Vj627qxCosxIGnxjin2pWH9mllBYce21mkGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LGcxlxgD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LGcxlxgD"
Date: Mon, 19 Aug 2024 11:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724080446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/ctW0QUQTpTidC62Z1K8GT0M82j2c6ebu1AWnJZ/GA=;
	b=LGcxlxgDnqUi5JnBA5EWgMOsWVwBsPdH5oTDGJe/Qymr9vpEYDKK2CwM7TjqkZ9iPSHEXA
	2AJwcs7FAQQBkJx1eg3BqyD6N+tTaQQbx/moA7Ilpkre4xf0flzBj9hsEtWtz2mS0YOD5O
	YFw4jcfiCDISyZgIfp2q+FYdqt3CJfM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
References: <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 07:03:05AM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 12:46:34AM -0400, Kent Overstreet wrote:
> > On Sun, Aug 18, 2024 at 09:40:27PM GMT, Paul E. McKenney wrote:
> > > On Mon, Aug 19, 2024 at 12:16:42AM -0400, Kent Overstreet wrote:
> > > > You can't use a fixed number of callback heads if there's going to be an
> > > > unbounded number of callback heads outstanding.
> > > 
> > > The number of rcu_head structures is your choice, based on your choice
> > > of data structure.  You can for example link together data elements that
> > > have the same value of get_state_synchronize_rcu() cookie, and use a
> > > single rcu_head structure for that group.  You could then do whatever
> > > you want for the linking.
> > > 
> > > But even if you do choose to have a large number of rcu_head structures,
> > > perhaps one per data element, there is no law saying that each and every
> > > one of them needs to be passed to call_rcu().  For example, kfree_rcu()
> > > requires an rcu_head structure in the objects passed to it, but in the
> > > common (non-OOM) case, those structures go unused in favor of pages
> > > of pointers.
> > > 
> > > So what were you really trying to get across to me here?
> > 
> > Like I said, this needs to run in a fixed amount of memory, so your
> > proposed algorithm doesn't work for having one rcu_head per seq with
> > pending objects.
> 
> Please define "fixed amount of memory" in this context.  Given the
> information you have provided me, you might mean any number of things,
> including the following:
> 
> 1.	An upper bound on the time from the end of a grace period to
> 	the point at which you are notified of the end of that grace
> 	period.
> 
> 2.	An upper bound on the time from the end of a grace period to
> 	the point at which you are notified of the end of that grace
> 	period when there is a "flood" of blocks of memory that start
> 	waiting for their grace period.
> 
> 3.	An upper bound on the memory waiting to be freed as a function
> 	of the maximum duration of any reader, assuming some maximum rate
> 	at which blocks of memory start waiting for their grace period.
> 
> 4.	An upper bound on the memory waiting to be freed as a function
> 	of the maximum duration of any reader, independent of the rate
> 	at which blocks of memory start waiting for their grace period.
> 
> 5.	A guarantee that any block that is not actively in use by some
> 	reader can be freed, albeit at some additional read-side and
> 	update-side expense, and some added read-side complexity.
> 
> 6.	Beyond this point, as far as I know, you would need to be living
> 	in a different universe having rather different laws of physics.
> 
> The definition I was working with is #2 above.

No, none of those - you're overthinking. As I keep saying, it's about
tracking _pending objects for different grace period sequence numbers_.
The number of outstanding grace period sequence numbers is the thing we
need a bound on.

This will be clearer when I post code, probably later today.
