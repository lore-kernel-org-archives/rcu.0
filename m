Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91431C56D;
	Wed, 12 Aug 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525652; cv=none; b=AtgXwYi3OTSUO7QuEmy4ZSCVAM5wpzWnbzLukQcWDyRMsyLfa+n1dnHG2otdJWFBoC7Bn+E4wBlRKNmNOnCzXnyGhNl+4h7FlOuWMDj+1hTEGgkz2j2+Uyv2qhrXkdpBcD4CnbUf8jeS6MNua50Sp8gd7tLttuUsG/TvAY2Lr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525652; c=relaxed/simple;
	bh=hyZBIP8aenZh4RI5mwh7d5XZOCT3HEK5+6qV4tLHQtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btoUDM0T6eO/dh5/UnBoZe/fvs5FP8C9sTdp8Ij1gnDnIAiuz+Vb4dvb3ltZq/D6e95/HY+9yJeRyTtFBBTOXFZYtgiK+As3WmxpSnIsZQn/SmIDFDUzxehc2wYg+mqDpie2B73rgBZimnPjjncV72b7BHl/O4pH+hLAIrc3lHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Q7kE/7m3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Q7kE/7m3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R1sYxG7d9cqK0XkO+yurYvf7+Klsiju5O6ajeYa+f+0=; b=Q7kE/7m30Dw5m5V9YMRP8vbtKA
	Zl3on0f1Z0cwMnY2dTkyYPFGZ8NLexgTqyYF4KFYvYQUPwHB2s0TpLd6Lujgm/fUEePry58OkZhA5
	ZBJoh0qw3mnZ8T1G84A/xfZyYraChdX2gYOEtBC8MbnqgEPjY6NmSGi4uMqaIVS6M7R2N0gDkreBl
	uooGOyaQv/1fiyzYzK7hAJgm9Iu8a6EF1nk1jl7x2ATVdZdjzRm2x0BPDqrxDBVDxbWUOX8/1ENWZ
	L3GFhX0ITU26NiwL3oukEbRqcGxIcgI8XqbjHKcr7vvoi7ZO0ZPTjC1+UeaTjAzqiZK+CggLR//8s
	mYi4gIvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu4ve-004EOF-22;
	Wed, 12 Aug 2026 09:07:18 +0000
Date: Wed, 12 Aug 2026 02:07:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
Message-ID: <anw3uOzb-WXTh6B4@gmail.com>
References: <20260811002951.106631-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811002951.106631-1-qiang.zhang@linux.dev>
X-Debian-User: leitao

On Tue, Aug 11, 2026 at 08:29:51AM +0800, Zqiang wrote:
> The WARN_ON() for timer_delete_sync() means that the caller forgot
> to call srcu_barrier() before cleanup. however, it still can trigger
> even when srcu_barrier() was properly called.
> 
> When a SRCU grace period ends and find that the allocation of srcu_node
> tree has been completed, but the ss_state is still less than SRCU_SIZE_BIG,
> the mask=~0 causes delay_work timer be queued on every CPU which has
> been online regardless of whether it's sdp->srcu_cblist has callbacks.
> the srcu_barrier() only wait srcu_barrier_head's callbacks to complete,
> however, the srcu_barrier_head will not be inserted into an empty
> sdp->srcu_cblist. after that, when cleanup_srcu_struct() finds a pending
> delay_work timer on a CPU with no callbacks, triggering a false positive.
> 
> This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
> warning triggers only when the timer is still pending and there are
> actual outstanding callbacks.
> 
> Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Tested-by: Breno Leitao <leitao@debian.org>
