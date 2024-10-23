Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA658149DF7;
	Wed, 23 Oct 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665651; cv=none; b=Q+NZFRg/Nkz0WJvl98whT4KoBrSFteoz6LOWIG2gjBCzULTOBH58IYGOXm4Mm/pcO1bsSaZeo/SLn+jSlzAEouX8I2WTHhTWHBo63/AIzSeoOAYKZI9QCqoU9uiQgXoYbXSGG7qqKCVNaweT2WyqHtc/QUn11Nn96kvsS5pr6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665651; c=relaxed/simple;
	bh=FV0/yuKKno5RIoxHyPoFk6qEGKEbHv9jVq0gHP2II8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMYs5VdlbO0QppZPUlhW/Zr8HXfLLp8E2V9GTs1uNLufFP9ulj1Qy2pcZ5CMHqGorvQJrOPXFXNEEiX0SuneeiL7j48DupHQbY49voXJvGeFh1emFAO6PU5PV8TvXVptp+B3GzBAkpKGqWA9+KhYB/tLt9gMtWFjaBbQoKMxaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mHyu8GHF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHyu8GHF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rIfcwPiPcYCIDObV4K7eoIB0jafSYb0r08EuGx/wWmc=; b=mHyu8GHFXDq17XTqSed8xF9VBd
	EG2Cd+htJfxT7lba9yJHvLUSyQsyRNdiaQmWBIbkhQIpssMxJywl51LZRAdO3qKh2/LytHg8VmL2i
	asSVWY5RTMaO321eYZPLwpN2nWFIMDIWuRsRWUc/FloW2ddxnbmMxWO1WuhkyeBcos2d6XtoLQcwm
	8jL7EWvE9msuy/O9CADmYFZjLCdETft8pWmaSkDsseTDC0rGuALMCNTlvY2te8K25nx67DiMOi4wr
	a2dmnTLfwpqBYyPH6MFr3oRZXsktpqAXN15Aj3wS3POW9UO5tdAbFsmUR3iyYDKFKPu4WxTO6xBWe
	Fo/6k37w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3V32-0000000DDxA-1Qk6;
	Wed, 23 Oct 2024 06:40:48 +0000
Date: Tue, 22 Oct 2024 23:40:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: paulmck@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <ZxiacAA9LIWv70Xp@infradead.org>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
 <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
 <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbyctiXq8L5MQmCtVqGSN8uawUmNXJMm-X8jDcp8QQ86g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 22, 2024 at 10:29:13AM -0700, Andrii Nakryiko wrote:
> >
> > Would this work?
> >
> > #define SRCU_INVALID_INDEX -1
> >
> 
> But why?

Becaue it very clearly documents what is going on.

>It's a nice property to have an int-returning API where valid
> values are only >= 0, so callers are free to use the entire negative
> range (not just -1) for whatever they need to store in case there is
> no srcu_idx value.

Well, if you have a concrete use case for that we can probably live
with it, but I'd rather have that use case extremely well documented,
as it will be very puzzling to the reader.

