Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3312FB2E;
	Tue, 22 Oct 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581026; cv=none; b=nOyvLnYm9s2suMksiQB9p0IgOJQCPSWBoJTPjg35NiIXE1RQbsSvboKgtg029yh0ezUiPqinB4bwY2r4uWQesQFTGOfQbGnyr2cECJ2caZUy2mSzeCw1X6yrxZu+jhVDE4P/zhioXROvr74JERehUjZYnMKIaRMMDhT0pLdEpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581026; c=relaxed/simple;
	bh=UTrsrry55vXmeLXdbE/uhPn4J9b2+2kF+kRkBYWDaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhKEPUu1wnTn0APOXDPwq9SRGdwl4oHZt3UQjFAdg8y3pPl96iz3gm+omxbuhr7gUon+oNb1lAoSXQZOWMzqLbLL70oDBXpvxCryoLM6icPJCxIbIfGTUtcl4Yudbbt7oY+Zfi/xpKWdrWVP30kUOiI1nhiTxn9JKf5TTWcnGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PffNRQqb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PffNRQqb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6J107HGG5kQrEOx5Jyqy2aYaDpUUAG/q37cL1lVgF/Y=; b=PffNRQqbeMdKkugGQaWRnf7/BN
	civnlmlQSoH9uItiK8q9GcuBEUxi3Cf9eexfTcQTWnQ/6ip0ATcKKjLx5hEY6qUA8CBlsubpxQHhb
	6yQ9B8bJqhb/rXKhKsZXZbLrWJrKhMSiYIldXkA3xlZ0AOtlqPav45kObMytSj/eeQD0F0H8uLAkn
	6RcSWSwPSXLb6F9W9wbysejKotOZ4jc5cYJNq2SCI8gHiDGlhwbIzTWlEexDzZpFrTFTqChRO2/SB
	tq13iZerVG9vvDgHIIW1c9aVsDe70PbYSzUPrb9iRytQOUqFruT7irZZNxlBtkSyIKoIY2dZhHfOU
	je2PhCgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3923-0000000892r-0K9J;
	Tue, 22 Oct 2024 07:10:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3019F30073F; Tue, 22 Oct 2024 09:10:18 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:10:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <20241022071018.GA16066@noisy.programming.kicks-ass.net>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxdPN6wT1LMyLaNL@infradead.org>

On Tue, Oct 22, 2024 at 12:07:35AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 09:06:35AM +0200, Peter Zijlstra wrote:
> > What is returned is an array index -- and SRCU is currently built using
> > an array of size 2. Using larger arrays is conceivable (IIRC some
> > versions of preemptible RCU used up to 4 or something).
> > 
> > So while the values 0,1 are possible inside bool, that does not reflect
> > the nature of the numbers, which is an array index. Mapping that onto
> > bool would be slightly confusing (and limit possible future extention of
> > using larger arrays for SRCU).
> 
> Ok, make sense.  Maybe add this to the comment if we're updating іt.
> But using an unsigned return value might still be useful.

Ah, well, the thing that got us here is that we (Andrii and me) wanted
to use -1 as an 'invalid' value to indicate SRCU is not currently in
use.

So it all being int is really rather convenient :-)
