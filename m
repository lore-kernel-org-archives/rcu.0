Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53412DD95
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082567; cv=none; b=QpTbcNR3KQ/6kcj4EV53ptaTG9oZEMWTL4yZwQRBaQrIoeGXf3xMJ4+RlANfKLKVWbX4utLZ/O2HJRDBGPy2m0iAWviVi9zK2ooAIYbdoCCbCFtD0fU/U+TQZcnRQiJh7HD6irMZhEZ6W+aabj7iY0fiC1m48veOdrroPwvhNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082567; c=relaxed/simple;
	bh=eyGfAcA+cneWF6bW+nmlpOZia+DAPeCLmo097O8c7tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ+bfVwF/CU4sPnYKu000m6C7nB42rtNcP5m1LOyZmqADURyHLIUQbyV2vzw9P7su2XwJT/NCoIxjFV5p6VdtnLm7pIdB8ZyzyZMuHqn5Io1a0TSFGs27kJTrfJzzfh/nqO8d9AtQkapzMLRaQnorVkFKe/l1iB70Y/DeFvCACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4QRyBb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4QRyBb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96EBC4AF11;
	Mon, 19 Aug 2024 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724082566;
	bh=eyGfAcA+cneWF6bW+nmlpOZia+DAPeCLmo097O8c7tw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Z4QRyBb5KNWej5RsosTpa8Z7NnG9UEzxZuQzmqjz3x0aPWeSz0UhpJZfjyAXHs70H
	 mwdZp9U0p1rHVqQKi98OEzIgoaLw6vpjOU7en9JVsX45iGOCXDaSiQ3oVKz2A5waB8
	 j5Dsu1ceV+ggXr7HzeiOYIwa5NUA4TufhjjkhyJmZlEifURvWtCfTZ2Ugti8X0dq4Z
	 AybnvRTsqDssAxelqkzD9EYoISgNgcB3rzDAH1wi2lGZ+JrNe5C+3Bz/D4JqXa+jwk
	 Qhj7EaknOLmXfXTNYyzB/xbdADnwf75d7WNrEEMJid5VpXs12tOk25gRiS290vXWLE
	 jvMBr0YFI9zVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8B4EECE0A05; Mon, 19 Aug 2024 08:49:26 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:49:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <e86fc94e-0151-40ec-ae6c-dd5991756905@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
 <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
 <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6pqbszwxjby3cu7yfep23zrnfff4f5cnh5f7npxlpim7jhiuq7@4keumf66hfot>

On Mon, Aug 19, 2024 at 11:14:02AM -0400, Kent Overstreet wrote:
> On Mon, Aug 19, 2024 at 07:03:05AM GMT, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2024 at 12:46:34AM -0400, Kent Overstreet wrote:
> > > On Sun, Aug 18, 2024 at 09:40:27PM GMT, Paul E. McKenney wrote:
> > > > On Mon, Aug 19, 2024 at 12:16:42AM -0400, Kent Overstreet wrote:
> > > > > You can't use a fixed number of callback heads if there's going to be an
> > > > > unbounded number of callback heads outstanding.
> > > > 
> > > > The number of rcu_head structures is your choice, based on your choice
> > > > of data structure.  You can for example link together data elements that
> > > > have the same value of get_state_synchronize_rcu() cookie, and use a
> > > > single rcu_head structure for that group.  You could then do whatever
> > > > you want for the linking.
> > > > 
> > > > But even if you do choose to have a large number of rcu_head structures,
> > > > perhaps one per data element, there is no law saying that each and every
> > > > one of them needs to be passed to call_rcu().  For example, kfree_rcu()
> > > > requires an rcu_head structure in the objects passed to it, but in the
> > > > common (non-OOM) case, those structures go unused in favor of pages
> > > > of pointers.
> > > > 
> > > > So what were you really trying to get across to me here?
> > > 
> > > Like I said, this needs to run in a fixed amount of memory, so your
> > > proposed algorithm doesn't work for having one rcu_head per seq with
> > > pending objects.
> > 
> > Please define "fixed amount of memory" in this context.  Given the
> > information you have provided me, you might mean any number of things,
> > including the following:
> > 
> > 1.	An upper bound on the time from the end of a grace period to
> > 	the point at which you are notified of the end of that grace
> > 	period.
> > 
> > 2.	An upper bound on the time from the end of a grace period to
> > 	the point at which you are notified of the end of that grace
> > 	period when there is a "flood" of blocks of memory that start
> > 	waiting for their grace period.
> > 
> > 3.	An upper bound on the memory waiting to be freed as a function
> > 	of the maximum duration of any reader, assuming some maximum rate
> > 	at which blocks of memory start waiting for their grace period.
> > 
> > 4.	An upper bound on the memory waiting to be freed as a function
> > 	of the maximum duration of any reader, independent of the rate
> > 	at which blocks of memory start waiting for their grace period.
> > 
> > 5.	A guarantee that any block that is not actively in use by some
> > 	reader can be freed, albeit at some additional read-side and
> > 	update-side expense, and some added read-side complexity.
> > 
> > 6.	Beyond this point, as far as I know, you would need to be living
> > 	in a different universe having rather different laws of physics.
> > 
> > The definition I was working with is #2 above.
> 
> No, none of those - you're overthinking.

Just in case there is any doubt, I have a somewhat different
interpretation of our interaction.  ;-)

>                                          As I keep saying, it's about
> tracking _pending objects for different grace period sequence numbers_.
> The number of outstanding grace period sequence numbers is the thing we
> need a bound on.

By "number of outstanding grace period sequence numbers" you mean
the number of outstanding grace period sequence numbers that have
memory blocks that have not yet been processed?  If so, how could that
possibly matter more than the total number of memory blocks that have
not been processed, regardless of which grace-period number they are
associated with?  Why would a huge number of memory blocks fail to
cause an OOM simply because they happen to be associated with a single
grace-period number?  Or, to put it another way, suppose that same number
of memory blocks were distributed over a large number of grace-period
sequence numbers?  How could this possibly cause an OOM to be more likely
than if the same nubmer of memory blocks were associated with a single
grace-period number?

> This will be clearer when I post code, probably later today.

Nevertheless, I look forward to seeing what you come up with.

							Thanx, Paul
