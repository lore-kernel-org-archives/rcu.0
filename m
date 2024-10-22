Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5313BC12;
	Tue, 22 Oct 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580806; cv=none; b=i75sf90ciYTNv5BO7GhKavMN4q2o0js4l892/RDpXNr614oDl39hXKTpMqcGS8I9cv4l8QXHqUE8MjUbWBE72oRAu5qIXJI+agFqPV3uamnlYUJKUxKaAdL1f14PLWaoiRTIqaIcgo6uXgpFFWeJbczz3HyYoBMEHFpCfzyjrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580806; c=relaxed/simple;
	bh=mBkuAijAH8AGSV5AEeLPSn13P8LimqLsruv75dmry04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn6P9iuJBYZyeahHarpKoyJaa2LNVKRE2zVbfSwKJIXOSBUCO/p6XlcoA1zg0FYBEYITMIAivYQIchk8J5HZUEcarFRUXp2JEDp5uI8HYM4Hr28wA7XD65zDC52iXhSG8jt0SbhPhmGBYR0vDTxi6TaXI2eKkI6AHB9EK+zQaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HjaTUq2t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HjaTUq2t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8NZzf0dkAidTE6L0e8dyd38yty9xIGChdnnrTGvmqRY=; b=HjaTUq2tMLAirj22BxemtKeiIp
	XXQZH1t+pSWfvhWGoHH3TJhRcO2oP2YLLRmITDm5sqR77ucmBonq8Jju9l5vCh53Snb/WlaS73BLh
	Pl//db0m+1FAfTUHtN1E126Qn6WY+Xt9rSe2NmMpGnVudOT1aICeFXgs4qP5hHLAk7moVapKtSV0m
	+KHH50G7IpCnOpH1dFyQSwYP/LUy/5fRbWFJTrxuyneaLaK2alNNgVxPNCX3+7q3qSqySXo1D3fta
	6HbQj9Wk7QOrtmBjzV1xTY8tJ7uqldgw9j3FU31AOEkA0CNBs+4laowxUFvxS8HLvIeU2XfPbO9U1
	aOZwdiEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t38yS-0000000HTsx-0hMb;
	Tue, 22 Oct 2024 07:06:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4760300B40; Tue, 22 Oct 2024 09:06:35 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:06:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <20241022070635.GY16066@noisy.programming.kicks-ass.net>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxdLfLWWrAEfRiXV@infradead.org>

On Mon, Oct 21, 2024 at 11:51:40PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 21, 2024 at 03:13:05PM -0700, Paul E. McKenney wrote:
> > For almost 20 years, the int return value from srcu_read_lock() has
> > been always either zero or one.  This commit therefore documents the
> > fact that it will be non-negative.
> 
> If it is always zero or one, wouldn't bool the better return value
> type?

What is returned is an array index -- and SRCU is currently built using
an array of size 2. Using larger arrays is conceivable (IIRC some
versions of preemptible RCU used up to 4 or something).

So while the values 0,1 are possible inside bool, that does not reflect
the nature of the numbers, which is an array index. Mapping that onto
bool would be slightly confusing (and limit possible future extention of
using larger arrays for SRCU).
