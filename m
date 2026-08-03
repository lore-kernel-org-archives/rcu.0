Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC70306D3F;
	Mon,  3 Aug 2026 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771442; cv=none; b=milewKCsyQMR3Gdf/1P1q6rH3i/SUMmJT6cU97kteh6waSdUqe4p5T8ktHMs5wHee9BOzdiLLC1stS1V8vWgdTzZcK2WogU16UfZhJBiHrAZyITKCFvh6SWy99D8MJH5jMpybnrjr2Kzlahx8jXm4IpYwKRalzIwEPS0uEOLAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771442; c=relaxed/simple;
	bh=+QpMUSWk/GvVGBPqojXOHL0RT3WyBMlsbUpHI4qqqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELHQ/3cQitklBx/jrdAjtaO68O3ViqxClaphznCheVIFWvNNqEIHxq/6k0Dl0tWlzdxFLWLyXX2PEvG/cgc0sFwQGLeYDtZs+6V6deEl4LnIPau3/HSLEoU5dbXp66BhNiSKlZvnHq5GKijCn1f34moOPvX70JFUp0MzSkwb2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1vtDyRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1vtDyRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B44C1F000E9;
	Mon,  3 Aug 2026 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771441;
	bh=EEeHvCK/4qr0udFm9xmmfnLHXKUOj1vvk2w3lbpsW+w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=L1vtDyRurwnCEOZ2LLZLwBHDU7joi5ok/iepNHu2YWDHslKpqlFboRSdyO5xCRhKw
	 T/7amMFjOZPiWnsk8fH0/s51+udxYa0Uew7jo7e3DXUt7oGTUN81ZsOOoZazyaMH/C
	 L4LcHET9THFSgfv8I0Gi5bKwPrPAB3zInEXpk2/rdcq5fImT4FA3Xfk/SOaT3Z17Xw
	 jfw9EHd/faF3s/xRBKDks8m4ZrFxfZcB+wX8u8Ns4kgg4cTQFy1yzbyJI+NERCQKMe
	 JUYb2xIF2H4K2IguY8Ok3P4evxCYlFQ6tJSWH2hNXrfTTiL3lKalkmOPQtXS/xoGkt
	 Yjyt2gidm6DcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6F4BCE19B2; Mon,  3 Aug 2026 08:37:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 08:37:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
Message-ID: <f309e572-8fd9-479f-8ba4-4c9ecaa73bbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
 <d2cd0e92-930f-44e4-96e5-67b751419a1c@paulmck-laptop>
 <c4057657-7246-48ce-80d0-123e351a921b@kernel.org>
 <anCCVU7Y6lMaPmAT@dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anCCVU7Y6lMaPmAT@dev>

On Mon, Aug 03, 2026 at 12:26:55PM +0000, Harry Yoo wrote:
> On Mon, Aug 03, 2026 at 09:59:44AM +0200, Vlastimil Babka (SUSE) wrote:
> > On 7/30/26 22:59, Paul E. McKenney wrote:
> > > On Thu, Jul 30, 2026 at 04:32:46PM +0200, Vlastimil Babka (SUSE) wrote:
> > > Which reminds me...  Are you guys interested in taking the kfree_rcu()
> > > test code from kernel/rcu/rcuscale.c?  See for example the kfree_rcu_test
> > > module parameter.
> > 
> > Hmm, we have a slub kunit test, but I think no such torture/scaling test
> > infra. Maybe once we have that? What do you think, Harry?
> 
> That'd be definitely useful. We have been reviving performance tests
> every time we wondered if it'd affect performance in a surprising way.
> But we've never put that in the mainline ;)
> 
> Probably test_kmalloc_nolock_and_friends*() don't even belong
> slub_kunit.
> 
> Perhaps worth starting small with lib/test_slab.c, and slowly
> move/add torture/scaling tests to there?

That would work for me.

							Thanx, Paul
