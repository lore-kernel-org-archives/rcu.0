Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695DECF;
	Tue, 22 Oct 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579903; cv=none; b=WtYejk5L3vZYMi1/1D+kmKttxfXYyK8fUoq6a6lKEBF8rpmhWXIA9ob3QloOCJ7JZUZkPOvB/58fA257BxGg2/qOdc9v5O5cIPBZNH1px+zBQuGpTtF2yTBjRKfpZD3dSHl+hOyVGgsr7VIRy0LOf6SzVISzNdHLgVx9AE+INYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579903; c=relaxed/simple;
	bh=Dwf3CQUzGRO1dwDLDjJ5gQfp+jycSPUft3XJMwWGqPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js1c4/iAG8KxAjB4+Yap0tQxbYHnaYOyHEiyywnZJDGQ4inAA+IuwkX/URlQMH3xwNz26MR8p4ppTE7CQAqtfWql+dBhH1kcdIF5CbCiujBOdiGYIf4rbGPvetNxeECyxP2w04d09jwCHJQVXOLpSnA8e4E6NoOsxz1NMI+6CFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=05OMEdwV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="05OMEdwV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pa1LRF+kWOr7ZeE24+JLhWiWsCv0iLxb5TlrnHIMQbA=; b=05OMEdwVFXcRxWw8A1yXovRkbU
	71XgM6GdKc3RwXRzW74OCDTDI6+c23SsQOLwrEa4rsLtFAZXKC89bLaeE9ER6PbDPrVLfrCK9QACh
	LBZpF4AFjaU+Xm70hX9LNd3LQphg1EvneN9NWELz8uUOGXVMsqhS2ur/HaS0atrSGDwo70xbRD9dB
	0Dzg5rxK1puplM7t4K1/qUGu2Sw9N6YD+2/uayoB0BBowNwMxrESujgkn50AMo6tGyNqOFRxh0D7g
	k5GdqWO1rEhx38wWOIv7GmNLKFtd97+6D8F2WH2TozDs6Fci30fz1JS17okGEs+xMdyZtgmfqCpXu
	GxM7NB6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t38k0-00000009snl-4Bpk;
	Tue, 22 Oct 2024 06:51:41 +0000
Date: Mon, 21 Oct 2024 23:51:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <ZxdLfLWWrAEfRiXV@infradead.org>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 21, 2024 at 03:13:05PM -0700, Paul E. McKenney wrote:
> For almost 20 years, the int return value from srcu_read_lock() has
> been always either zero or one.  This commit therefore documents the
> fact that it will be non-negative.

If it is always zero or one, wouldn't bool the better return value
type?

