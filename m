Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246513D539;
	Wed,  7 Jan 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797384; cv=none; b=EOc7zidWeSSODQ1vsFhCxGU7TfwYXKumI82HNaOPXQf227u2qdn+ypKfxm666P+brYiqeOxJH9As5iBIPDLFjDWc9X92CazHuR1VrUAWO4YOaWIMw5Eos5iXZNNFj9TKKjiFy5cd6xeCf3GXRrlfg6zzA4qFODuKNew3t4Q4BzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797384; c=relaxed/simple;
	bh=YI7mXRwYQgsZul98x1G9XIaZHQiOYlQEaaq+SdM5Ado=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8l52kYfb6Ec9K5a+kbo4Pchg+dNTmj1xvskjOLtbEl9G+cewXSsIt7iz04nDbh3VYoZ6xT9xppTg2N3/NT5CNWzxL4DbrHi0WJQZN3oDrCuP15kYdb6nV5dmMYq6VCq1nVVcHCAyCiBNl35jZHfpLgSJzTzOAinq50G81mgpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XmDC6RSj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XmDC6RSj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=l9zPldPO0gnPG9wqrGk15pRMXLG4lDUH1uQahecjpaw=; b=XmDC6RSjQjF/FBL9NZNvteRWSJ
	XfSf2hlRECEq0ebGyg5PpKJwJCMOSfzAKwNiq943mtTwN562XqVg6CXBQSWlSMPkQvBjMDvcHMIaq
	VbMaChEVW2NJrWYX+WTkUc4q69Qc5hAruLFHgmNhAYSWJ1vsrga7eXrkK796N4NMiipuPKZTZaOyY
	rFR/5UDT6V5KElXh5mZSYB1MBSII5ql1opBUYPQgnNho0fHqTuxPNBDc2lGvJn8XWN6B5G7rhA+bL
	5Nr/2YPyuCjvtoxt9xu77oRYLe5AYcNt5uU3ZpPNrjBz5lS//E3QOZJVBGISdvCI/NU5j64SAazKq
	NN8VbQ0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUqx-0000000DVit-44jG;
	Wed, 07 Jan 2026 14:49:40 +0000
Date: Wed, 7 Jan 2026 14:49:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org, x86@kernel.org, paulmck@kernel.org,
	tglx@linutronix.de, peterz@infradead.org, akpm@linux-foundation.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [BUG] rcu: stall detected in sys_mmap with PREEMPT(full)
 involving timer softirq and DRM vblank disable
Message-ID: <aV5ygyPM7J7VdmgL@casper.infradead.org>
References: <6b7e2fac.a60e.19b97034116.Coremail.23009200614@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b7e2fac.a60e.19b97034116.Coremail.23009200614@stu.xidian.edu.cn>

On Wed, Jan 07, 2026 at 01:52:11PM +0800, 王志 wrote:
> Hello,
> 
> I am reporting an RCU stall detected during syzkaller-style fuzz testing.
> The stall is reported while executing sys_mmap(), with the
> rcu_preempt grace-period kthread starved for over 10 seconds. The
> observed stacks involve memory fault handling, timer softirq processing,
> and DRM vblank disable paths. With PREEMPT(full) enabled, the RCU grace
> period fails to complete.

Get your changes into syzkaller upstream, don't spam us with "i'm doing
syzbot's job".
