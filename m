Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112172877DA;
	Mon, 12 Jan 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227890; cv=none; b=n+u6XjT5ZA8YIgAhilBWNKIHYE7CCHcdLCb4vOt+1bxmPcTuAXWi4c4ycNCWGgBXelEj+Me6YHKBEOp6oXif88bu0zWGtOEFUHwvm6yLODvqpCg1r8f93hSjluS2cCh44+zmNeBZxF8e71KUmoP+spHVLWO1g8shRBMPYD2nFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227890; c=relaxed/simple;
	bh=nKwISBLQbXPRFbbtij4NMF8qRE2KpVlrmeJniXMy3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ/KL7rR4q71B+fh0hfrJPN4jZnxefUeF7UPGDZr92ytK6hiE+SNBybtQGK0juMDlKiogWczdUm45rmE+w3Vr5PnD4CTcLMt4eSLK9tWo+MZ1OgnCbfMN39IS1MhHdOBDp2aNKwHEnfSow0zKlcTCqXer3QTDLUmzNZnlbt2rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sdnPQjM3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdnPQjM3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=x09LXl6Wi+RiDD5vGf5aEWGgjFQp0fh8zIuLdsf/OnU=; b=sdnPQjM3Qb3mOYJOGzDE0CMXrc
	Ld1/PSlM91gECsnXDpUMEDvyK53dahpTAlHtFcUfX2rgbJ2RvvLUWqshxzorIqfCRFaMdwD74cza/
	COwInS17GEdSwSFIBZ7rVZlO3+9QQ+/QFCrnL4R0dzOegnIHqn5dDQfywXupLl7Cm7GFIvPIZo7vE
	otGGO+KRy2W/0lZU+pCTcC+q3fwV+ozzfS2Es+41uJ0JbNjO1nsdkK1Ep4P1frLXBFJ+CU2Sl7b8p
	/n0/NM5m7KmmKkCEvh6MjLTji2qMtP4jv5Ma1Ez5qhNewE46MEyXinsT7hAJqv3BGInaRikZV1uIs
	/zzXjP4A==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIqW-00000003KlW-2mjj;
	Mon, 12 Jan 2026 14:24:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48BEE302D3E; Mon, 12 Jan 2026 15:24:40 +0100 (CET)
Date: Mon, 12 Jan 2026 15:24:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
	sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <20260112142440.GN830755@noisy.programming.kicks-ass.net>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112094332.66006-2-vishalc@linux.ibm.com>

On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> Bulk CPU hotplug operations—such as switching SMT modes across all
> cores—require hotplugging multiple CPUs in rapid succession. On large
> systems, this process takes significant time, increasing as the number
> of CPUs grows, leading to substantial delays on high-core-count
> machines. Analysis [1] reveals that the majority of this time is spent
> waiting for synchronize_rcu().
> 
> Expedite synchronize_rcu() during the hotplug path to accelerate the
> operation. Since CPU hotplug is a user-initiated administrative task,
> it should complete as quickly as possible.
> 
> Performance data on a PPC64 system with 400 CPUs:
> 
> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> Before: real 1m14.792s
> After:  real 0m03.205s  # ~23x improvement
> 
> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> Before: real 2m27.695s
> After:  real 0m02.510s  # ~58x improvement
> 

But who cares? Its not like you'd *ever* do this, right?


