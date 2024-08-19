Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1620166F14
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076186; cv=none; b=nAShgbKW/N9mfhQZM9DKya9Mai5JN8YEAYDrM6fwqGtrfvs8EYLiKdKuoRB69mBnOclWAMqGFoiaoAbg6z1fTM1/Tx4OVzlCn83Nn0ZHAbuW+w2zZ76o+4YS4j1d15cp8kqBvJQb4nAwLoYlsz+dGPz+UDjrrcNq6U0LlqleSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076186; c=relaxed/simple;
	bh=3EUVfm49GAdcHCm4yyZ3zbOR1WMM36FG1wP4il1mBY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADIVLAyd5glKTFP3msIz6kPkRVQZtQcikJeRGL0zbW5e07gNNzQ8Exe30O1kLK4+lI44oHJbsDtHyX4QufBw8bmhbm2fwMleAnr2ShqcNUjJIHhKYjvrgTV9PQVAkPx8cyMw3+QUSDkRcciiaNlKmVr5HEvNZq3qXLIjQvBHbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTrMWzPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTrMWzPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154ECC32782;
	Mon, 19 Aug 2024 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724076186;
	bh=3EUVfm49GAdcHCm4yyZ3zbOR1WMM36FG1wP4il1mBY8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YTrMWzPtWlkZm6Y2ZbGlPVT2V1IAvc7S+vsIomepMh+tPfmtwPMm19j7qc20RMC8d
	 YylvNtUAczYUnulYXa5jfDoJ48+O+pn+M+G51QiYkrHaGGtuTisj3tSgByIzqHF26V
	 0Je3CcqjiM5OZi2inIBUaE4okSclVRC2eUz/D+QyfxrbR/h4S4DuOaBd5OA5ni+TLd
	 NHZmHZgENktTUIqBWYYQ7aYlju8JFewgRvTUCD1IhShC2OMxjpbzkLh9yAagVnis3l
	 CiK1bAWg5CWK1iB5pu1bmCCtE+3g0NkYKIsO2+ynQkJDXq+w1ZZ6fNuIHM/zjLY0Vw
	 YbBvOtTfzA/Og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ABE07CE09E8; Mon, 19 Aug 2024 07:03:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 07:03:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <24c6696e-5669-421e-8288-5b220a6a1e40@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
 <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>

On Mon, Aug 19, 2024 at 12:46:34AM -0400, Kent Overstreet wrote:
> On Sun, Aug 18, 2024 at 09:40:27PM GMT, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2024 at 12:16:42AM -0400, Kent Overstreet wrote:
> > > You can't use a fixed number of callback heads if there's going to be an
> > > unbounded number of callback heads outstanding.
> > 
> > The number of rcu_head structures is your choice, based on your choice
> > of data structure.  You can for example link together data elements that
> > have the same value of get_state_synchronize_rcu() cookie, and use a
> > single rcu_head structure for that group.  You could then do whatever
> > you want for the linking.
> > 
> > But even if you do choose to have a large number of rcu_head structures,
> > perhaps one per data element, there is no law saying that each and every
> > one of them needs to be passed to call_rcu().  For example, kfree_rcu()
> > requires an rcu_head structure in the objects passed to it, but in the
> > common (non-OOM) case, those structures go unused in favor of pages
> > of pointers.
> > 
> > So what were you really trying to get across to me here?
> 
> Like I said, this needs to run in a fixed amount of memory, so your
> proposed algorithm doesn't work for having one rcu_head per seq with
> pending objects.

Please define "fixed amount of memory" in this context.  Given the
information you have provided me, you might mean any number of things,
including the following:

1.	An upper bound on the time from the end of a grace period to
	the point at which you are notified of the end of that grace
	period.

2.	An upper bound on the time from the end of a grace period to
	the point at which you are notified of the end of that grace
	period when there is a "flood" of blocks of memory that start
	waiting for their grace period.

3.	An upper bound on the memory waiting to be freed as a function
	of the maximum duration of any reader, assuming some maximum rate
	at which blocks of memory start waiting for their grace period.

4.	An upper bound on the memory waiting to be freed as a function
	of the maximum duration of any reader, independent of the rate
	at which blocks of memory start waiting for their grace period.

5.	A guarantee that any block that is not actively in use by some
	reader can be freed, albeit at some additional read-side and
	update-side expense, and some added read-side complexity.

6.	Beyond this point, as far as I know, you would need to be living
	in a different universe having rather different laws of physics.

The definition I was working with is #2 above.

#3 requires that your code provide a maximum upper bound for the execution
time of all readers.  Even given such an upper bound, I don't know of
a way of doing #4 without massive read-side memory contention, with the
accompanying lack of performance and scalability.

#5 might (or might not) be addressed by something like hazard pointers.
The read-side computational expense is a full memory barrier in the
counterpart to rcu_dereference(), and also that rcu_dereference() can
say "no", which would require the reader to restart its traversal from
the beginning.  (This happens when a reader races with an updater that
removes the element that the reader was to traverse next.)  There is an
early prototype of hazard pointers under development, but in my opinion,
it is not yet production-ready.

So exactly what are you looking for here?

							Thanx, Paul
