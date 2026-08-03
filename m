Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2143403B1B;
	Mon,  3 Aug 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760018; cv=none; b=iDl0EVDhJ+R0CcZhqqu55oE1mZ+W2VNCJFMr28PAZi0PG3+AcxPcTmhWdVabHw6vCz9QNV/km319DPK+PuInrjZVHyar7RS0HNqiqIa3XiHs81rGcSohEgyNxfyvSqu88LIzE9DqF5LPcgVFcwsl0ib2O599VoZoEIdXQYuiouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760018; c=relaxed/simple;
	bh=GNqKvjPJHNXY4flEJgpam2fDAonX7XCQx+nbWE2GA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IalJ1wPfxSgQQwuf0s+A+4QPqnJ+q59V/iftExreSZk3oYZiLiH4ZfTIq7Gx858ZQ9FvQg2L4KPB1IxWreiXzvxs7EQ6GBpECn/IMxGp7JBXb0IF3SwcpPKxRkJxpswv564jJUZ+bPtKHTtdEYgzmUP1WruaWvY2jPhQmKun88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWteguSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWteguSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276EC1F000E9;
	Mon,  3 Aug 2026 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785760017;
	bh=xN9P22vbVMJceR28tbLqScWHW/CS/fqh19s3c2LZmvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWteguSBNDf2N2WtMJCVXbbeG6ArWQ1dKYNjCkbvP1YEFEELcNmOlYA1ZQTUShnSD
	 2E8WsyGkkJ51XhKasVhJStI9snDN7kIdexgnRJIbi7/tKqPfUftKK+7CHYAr+ciWOX
	 CU6I4xU3q6nolZ4poCda9bLihmDRNxJI7KKZoY/+UhNjguI/xou7vYnqlR5BxqMOhd
	 wxUi3MlBJt8NDHW24TXf/hc6mVUFnHT1m2+ej7Z5M1OIdGImE759XivwynmL3prw4z
	 WORP39Y6GVr06VX/V0GgmLDpFcj+5Aa6TDTCR4Y+9XReqrUwEsR77Bxa7llaMrLn/Z
	 r9FuqkbkgLVdg==
Date: Mon, 3 Aug 2026 12:26:55 +0000
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
Message-ID: <anCCVU7Y6lMaPmAT@dev>
References: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
 <d2cd0e92-930f-44e4-96e5-67b751419a1c@paulmck-laptop>
 <c4057657-7246-48ce-80d0-123e351a921b@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4057657-7246-48ce-80d0-123e351a921b@kernel.org>

On Mon, Aug 03, 2026 at 09:59:44AM +0200, Vlastimil Babka (SUSE) wrote:
> On 7/30/26 22:59, Paul E. McKenney wrote:
> > On Thu, Jul 30, 2026 at 04:32:46PM +0200, Vlastimil Babka (SUSE) wrote:
> > Which reminds me...  Are you guys interested in taking the kfree_rcu()
> > test code from kernel/rcu/rcuscale.c?  See for example the kfree_rcu_test
> > module parameter.
> 
> Hmm, we have a slub kunit test, but I think no such torture/scaling test
> infra. Maybe once we have that? What do you think, Harry?

That'd be definitely useful. We have been reviving performance tests
every time we wondered if it'd affect performance in a surprising way.
But we've never put that in the mainline ;)

Probably test_kmalloc_nolock_and_friends*() don't even belong
slub_kunit.

Perhaps worth starting small with lib/test_slab.c, and slowly
move/add torture/scaling tests to there?

-- 
Cheers,
Harry / Hyeonggon
