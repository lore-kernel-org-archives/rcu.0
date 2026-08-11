Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9A449EB8;
	Tue, 11 Aug 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460067; cv=none; b=DmD1p5Zq9CexyLCGovN+qHo+JX6lFlx1XxJZydjfIRj1JMO20X/0pBCg3Um58lxqIgvi1Syq2LMhSLkO4JYgITLufXi7rYpE/hw8xsTVnGe6U4c729sifo221a0pZKrXHbIvTUmcq5WLWydGGhZxhf0MTw0vKt0WkEBZhEzRebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460067; c=relaxed/simple;
	bh=gvb15IKQi8FLHh6N4hkS6bcKTVHOjawpkTo1rSXlzyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUiBjF/HSGW+bc2TjJEyr1/QmZ71fEhTmYwRfQzqwBV2ul7SX4TU+QNB9x2jnQLTDH1/eQML+tSvnSIENXSoBGQ5mtHjnOFgQMlL6AtPZUFY0rD7JYai5pn9qYkRXgZXRhRDnpW4vZTuhSeB2C9u/C5tVNIUyZPYmlP8FcOo2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFayfkVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFayfkVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1EA1F000E9;
	Tue, 11 Aug 2026 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786460063;
	bh=8CI7NreQLlieNlESuqIjYEf8GKEjXP73gcEt4aU//I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UFayfkVNChQ37HtqgXCM93ZvPggLjBYxJJLd7pzXjmCchrcqnr9Ht3muBQTIbF9qy
	 sLudj666M/gP6YKwVnNnt4b5BluL2vO/bhIOjv6oCLgXh6bd6N2QgVMkMmAOazQf59
	 trk2H7EdAexshR42HT6q04tJ66hvjPX8bpONHXYqcMfFAY1ecOdUBTAFiCBA5mZl8W
	 loWl4JiXeu0TxeJKaaWDAu5BSGB1Z9RADMB+/o5WunB34mtVsfoG94s2jdlwtZNflj
	 G/zqhxnomQxYWZuHLblXbJnCCv9iu1MBRnEoImBfZ+Tgfc7svGVXwsJrWHFtOYdlRr
	 fPmE2ypINFv+g==
Date: Tue, 11 Aug 2026 16:54:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun@kernel.org, urezki@gmail.com, leitao@debian.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
Message-ID: <ans3nJDeaO6ujzbl@localhost.localdomain>
References: <20260811002951.106631-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811002951.106631-1-qiang.zhang@linux.dev>

Le Tue, Aug 11, 2026 at 08:29:51AM +0800, Zqiang a écrit :
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
