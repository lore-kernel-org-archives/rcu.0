Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3538F49
	for <rcu@vger.kernel.org>; Sun, 25 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708840295; cv=none; b=kxsxdCFn5El5lR5/IjYqujhFDboHYoT2yCkmTw8CfIRcHGNmtEfTcsMYNo6efwHU19wSjLhHrz7aCgjB39Mxab7yTGx+YODv7eCuIRKpi+UjbbfLQb1zsvkw+RaChFBww/dTjUjHbkCdCgIfG0FjCNuOPTxCxUYXAS4KwEtRTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708840295; c=relaxed/simple;
	bh=kOcPJP7HmKte6IzOK94doH3AAanK9Mu1jw8WbI8Dx6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZYMaumIYwcyun5vRHfsptQZgcYPIO/qKe4K/30m5jVDs69VKRUzaVVEjsy+wcPFCdQlr+p+UvyI8MA71nPuTG7xfXkylBYn3wYuG55rxsNRW4lRoXorfJ8eLz8SK5M8nj08ZEsPVhMEle4d0Mk4Kfk+LjvIdm1ViDtzznyIq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iI/ja1D9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iI/ja1D9"
Date: Sun, 25 Feb 2024 00:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708840291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+gOsAge3PE5P+r0j0YPahgmyjokIkbHG2RX+N12yBs=;
	b=iI/ja1D9rkXm8/vVy/c21mbVr2w8iKfXX0vF2Y7pPRmqaxwR+e+Q3JtDOP5m4SPMjDNdEW
	62eyjzZAZx2RInOOwZb2FiJVW8JgKStz3oh9oTSIVhRJGBlVi7aKLGQTJFTB/K00duhpgm
	B7rclZm5oCmQcq+OfGMdm5IMMxkNJG0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Laight <David.Laight@aculab.com>, 
	'Herbert Xu' <herbert@gondor.apana.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Graf <tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <5p5sypt3y643rr7kp66lhmgksgtuvdgijrryh53mqiiqkrgyty@d4zcnya22owg>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <ZdrJn0lkFeYGuYIC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdrJn0lkFeYGuYIC@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 05:01:19AM +0000, Matthew Wilcox wrote:
> On Sat, Feb 24, 2024 at 10:18:31PM -0500, Kent Overstreet wrote:
> > On Sat, Feb 24, 2024 at 10:10:27PM +0000, David Laight wrote:
> > > I remember playing around with the elf symbol table for a browser
> > > and all its shared libraries.
> > > While the hash function is pretty trivial, it really didn't matter
> > > whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
> > > chains were always long.
> > 
> > that's a pretty bad hash, even golden ratio hash would be better, but
> > still bad; you really should be using at least jhash.
> 
> There's a "fun" effect; essentially the "biased observer" effect which
> leads students to erroneously conclude that the majority of classes are
> oversubscribed.  As somebody observed in this thread, for some usecases
> you only look up hashes which actually exist.
> 
> Task a trivial example where you have four entries unevenly distributed
> between two buckets, three in one bucket and one in the other.  Now 3/4
> of your lookups hit in one bucket and 1/4 in the other bucket.
> Obviously it's not as pronounced if you have 1000 buckets with 1000
> entries randomly distributed between the buckets.  But that distribution
> is not nearly as even as you might expect:
> 
> $ ./distrib
> 0: 362
> 1: 371
> 2: 193
> 3: 57
> 4: 13
> 5: 4
> 
> That's using lrand48() to decide which bucket to use, so not even a
> "quality of hash" problem, just a "your mathematical intuition may not
> be right here".

well, golden ratio hash - hash_32(i, 32)
0: 368
1: 264
2: 368
3: 0

but your distribution actually is accurate in general, golden ratio hash
is relly nice for sequential integers. the actual problem with your test
is that you're testing 100% occupancy - no one does that.

75% occupancy, siphash:
0: 933
1: 60
2: 6
3: 1
4: 0

that looks about right to me.
