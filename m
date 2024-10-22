Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9111ECF;
	Tue, 22 Oct 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580858; cv=none; b=j6MCDHrdln55rlfhO0VvPSE+nJbVIbLWu5DILtC93b/nu4bAQXgHwyctp+eLBjQbf/2k/0Y18oeSTKhTKKMT/0hmtnVGpIALqRc0kG/GBMa7D/VLfaVZBHWluskD4jLp2zLMO9+YvyynZA21bBK1googu1ggmYi/adWv/HZS2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580858; c=relaxed/simple;
	bh=Kk1YciZF09tq7xNaxahKwADaD7NUXpuvym6RbtBq7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6eYkcCm7MxDfi6ngmdc4055H3FCRbWgKz9JkYm2CTu5tci+Z7KsIQxp2T0RVtW6t3fHQaZo5k4pepjIT1GPuMXNFGSc53rDl1stp7Fb4YBuza+ezp3fFQXZKPQe0qWMWVvSwVm+JY14JE+PCW8gTZgaeDfLId6wFhDIM+PS2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=geMSE5AB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="geMSE5AB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UpzvoS0Xh4m9t9TB4OzJvJ4dYgpiN76I80CVhiDUOQg=; b=geMSE5ABZLP0lHndxlh8N/jn83
	9W0HQAUBkceDFGHVcrgFrnXfk/RCDlYIFE20zomRZ5P8AnUFCLOl+1XwHEw7Uf2fOqNcy4IbMV+l9
	jeyBGUOQjBX1sv4HThtu9bvegfidHa9/MLvtgXTt68G7mx1WR3o/nMZtxQptlpdf9aZLjZITaWRN+
	pHACRapY+a3wM9MXeCzJZLubzfxbJrV2HZ5hgIExbQQt74yGQJS8jbHw1hN1usYHAHU5V0u6A+Xpr
	nl+tdkFX8XbMBvSyjii1/YEXGDI1IJfRpAmjQcUSBawoWshLgAcz7cGm8Y6YDu3X/JA7aHBVxWkWP
	9kCgEjZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t38zP-00000009v6m-3Tmz;
	Tue, 22 Oct 2024 07:07:36 +0000
Date: Tue, 22 Oct 2024 00:07:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <ZxdPN6wT1LMyLaNL@infradead.org>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022070635.GY16066@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 22, 2024 at 09:06:35AM +0200, Peter Zijlstra wrote:
> What is returned is an array index -- and SRCU is currently built using
> an array of size 2. Using larger arrays is conceivable (IIRC some
> versions of preemptible RCU used up to 4 or something).
> 
> So while the values 0,1 are possible inside bool, that does not reflect
> the nature of the numbers, which is an array index. Mapping that onto
> bool would be slightly confusing (and limit possible future extention of
> using larger arrays for SRCU).

Ok, make sense.  Maybe add this to the comment if we're updating іt.
But using an unsigned return value might still be useful.
