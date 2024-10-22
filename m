Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9D13AD0;
	Tue, 22 Oct 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581194; cv=none; b=kDeUmjDHi3wwzWalTrSddbeXnGt664CaA/6HJx0UOWIcnf6eUbbONNtttWPIqRiE7LlZike6lUfabFmvePjeN/gDhzHT/2r5QShXrIzUrHmXvL+xs+QI+a6RAe2bQFw+hjn3bnmhRqpcnZJ8Hth7fbtCu2lNN2IVXP/qpD1xxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581194; c=relaxed/simple;
	bh=6xptQLYqN4yU1anUHt6MFPSBKHN6i27l1HSyRbo9iAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2u3TTJGuFve8iL1lNTOxjboPIf0OV/AP7H9s8bhOXaZafoGoj30e9kYx4DZPZP+XsoPEYBZAC6TmxiaVlEHzI/UluN484+IGbfo/BuickuEoKS3fAgloRWfxMNKp3n51q42VBgUb02xEEB8xs14gSHxA3KZPHev57aLaoTJegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DRFpXdoE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRFpXdoE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oC4rtjVBCOVV9130aa4PzjxDIh3/mqXk0GlZnkk3v8Q=; b=DRFpXdoEPPPAnmhpCHV6G9R5iE
	WdCYA4FgOg6YF0Whfwq0YeeKW5UNscMMkhMRuL+EgMkHLIvYYbhKli502MjLzYgt2mbeMEeoYkkQc
	6noW/Ia5kF7jdZtj92V6Bxco+mmT6ivJhWf1HKo00FBjlCHNKGPfH0kxkJtDRcTK07bifMIDuqlvP
	Pq/QscU86h5yqGjRxHl++RBE04U8y7FXUT2FD1GznT6Fgn7a2G/pQbrK8HKnY8KnVeLdaQT7omc4p
	HyUYMsvkJpiJEEx78BhWg2sjh50xn3RTX4Oak/LwS5lRx99ZN+EXCQ0Rx4SAGY9offp+ADa7S8fAL
	IRDm+X/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t394q-00000009vz2-1TA5;
	Tue, 22 Oct 2024 07:13:12 +0000
Date: Tue, 22 Oct 2024 00:13:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <ZxdQiLhn16FtkOys@infradead.org>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022071018.GA16066@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
> Ah, well, the thing that got us here is that we (Andrii and me) wanted
> to use -1 as an 'invalid' value to indicate SRCU is not currently in
> use.
> 
> So it all being int is really rather convenient :-)

Then please document that use.  Maybe even with a symolic name for
-1 that clearly describes these uses.

