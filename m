Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C73D76;
	Thu, 16 Jan 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061349; cv=none; b=i8AW13wtuzx5drEG3Cfw1fFjKZwQOe2h5YQsN/9ON9U8Gi6i3qBcm4rObjVsACBnlWHHGugmGEjuNAuTfz63VRhEtPAP76HSiRynnQPSjON98jUiYnJ56cs3l1Lrp65L7+UNhX85IRl09udbOp4hpG1sK9QlFxRqWiIQ22D8uFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061349; c=relaxed/simple;
	bh=M5AXe7WdSqr1YmPNEHAF0GmhANfg1x1FfR+ZbTY+0+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLyuyVxkHcu4z/bRFp6XA5R2Fq+8NxhqYkzDvy4cz0PxD09HOhaDujBVHYcGfd16qhP1A/5y9phZ2wCBdpISIuNj9II5f1iIC7T414yduZgkQzelpay0hu91bF1f5PRMi7DfZ7hda4AJReDnV86uuwc5Qp8u2JDUzcYIMZmpvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tvqOETaC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvqOETaC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dd9xxzIaOtJal9dw9NyPkkoGl9lhLKiFJQR75pHe4EU=; b=tvqOETaC4o9wOERmS/KLEcYl4e
	c/ZBX+FZMN16SmbILLXA2zis7bL/b4tr7EOnTp6/fMs97waexgUTICXOMr2KOfKN0wT9B5MEHyuE6
	LfHUdBfaCsgkg2GsmRwa5o2DZiWS5pfob7BACUobd3hVqEaiy0VDhQryUlo01JMsaNBbeYQwRRKZk
	LRdyzSvE4UncVW6EppPVWRmKPlTYZXkeWITtjNTLD2ldtoH1joZJr+H7D6GNWq5HI0uGo3eTNCmb+
	3ckWDItG6I/nNMFG9Wfu48hVCxhv6X8ANdWb2s0H3ewfqPe/OxklaPelFoBdqFa/190vTSz0lsVmJ
	rHu1Pi4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYX0K-00000002Syo-2QeW;
	Thu, 16 Jan 2025 21:02:16 +0000
Date: Thu, 16 Jan 2025 21:02:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH rcu 2/7] docs: Improve discussion of this_cpu_ptr(), add
 raw_cpu_ptr()
Message-ID: <Z4lz2CC7SLgSp90y@casper.infradead.org>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
 <20250116200239.3782374-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116200239.3782374-2-paulmck@kernel.org>

On Thu, Jan 16, 2025 at 12:02:34PM -0800, Paul E. McKenney wrote:
> +The special cases where it makes sense do obtain a per-CPU pointer in

s/do/to/

> +preemptible code are addressed by raw_cpu_ptr(), but please note that such

s/please note that //

> +use cases need to handle cases where two different CPUs are accessing
> +the same per cpu variable, which might well be that of a third CPU.
> +These use cases are typically performance optimizations.  For example,
> +SRCU implements a pair of counters as a pair of per-CPU variables,
> +and rcu_read_lock_nmisafe() uses raw_cpu_ptr() to get a pointer to some
> +CPU's counter, and uses atomic_inc_long() to handle migration between
> +the raw_cpu_ptr() and the atomic_inc_long().
