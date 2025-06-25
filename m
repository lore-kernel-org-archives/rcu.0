Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFE442C;
	Wed, 25 Jun 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853149; cv=none; b=r99iHM2XnfHIVcOIiXj+z5mBmqHAH1tRVYa4eYHT6h8Nb/dAfjr6DLP+QxbJCj5Md1KoyrpHupz1TNa6/7gYWSMt7j6cYx6By+5HrWNNP7BZ2LiPcxAVLBtxoT/V9trGJppiRdTJjqz9agYhHGDNV1YiN7TB719FyicYIoBPzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853149; c=relaxed/simple;
	bh=hGLqg7wgeHPjG5St0LnbdvupYqmGIqCb1WqHD0LGn08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMYkqEQ7se0uGzsfw9M84IQufYZfzFSGDZ7VOCCRzIFVjcUIxILhDGAXkajGMdt4c5PVG6LI033uF9/KNA53vDGJUEKT8DV7Jaui3vTU25HdW7y3IMCd0Rei8NgEmDfBd/50F5HRPFWhzJPQs3s/yLll1AknJAzvKFlDBYMdCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOqResxJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOqResxJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGLqg7wgeHPjG5St0LnbdvupYqmGIqCb1WqHD0LGn08=; b=pOqResxJKM1HpLIeGjatspWenP
	HXWrOLN4yUFPhWi0XKJlGbzu/3odDvdgMy1B5KlhdSpbmi9Enz6Y9DKNuScm5+ij9iC6Ei/XdSn8E
	Yijxsa+zhpTJxsdbq1HoC0wh5wLLzhl7qemuWSXPP1FXmv2TIwRHAmq4bAbjmcILjCC5bt353aBYx
	s8+Z2Vph9eOIvlbnM1NI6wsuK2/3BVkZEvDTYq6I9Mmf8Q3XZtRy4ZvjVYpixKAoLw/OB8geVXZab
	dyc7qvJ+TjG/2A4zDT5ccbiL42906ydCyKjQaYWqPfHqGEbwE+mfdxD3QqGXhrEJWYEOGb0O99UA/
	+VyJbd9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOst-00000008ZsT-4AAa;
	Wed, 25 Jun 2025 12:05:47 +0000
Date: Wed, 25 Jun 2025 05:05:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/5] torture: Remove support for SRCU-lite
Message-ID: <aFvmG2lT65Ido1fq@infradead.org>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
 <20250624161400.867880-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624161400.867880-1-paulmck@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 09:13:56AM -0700, Paul E. McKenney wrote:
> Because SRCU-lite is being replaced by SRCU-fast, this commit removes
> support for SRCU-lite from refscale.c.

Please explain how they different and why one is a good enough (or
even better?) replacement for the other.

