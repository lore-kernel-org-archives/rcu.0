Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672526A1A8;
	Thu, 26 Jun 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935250; cv=none; b=a9wjE2MRsXl354B19yn5nBL1xpTXcfkQ0j2vKRmyaEJKLPxXXqrV0Vh4tpgMV6y7CpSCE4IEpxTldVlAoOAZKpS2u5vxFehQqprLeA2Oiz6swgzUNejGOSku8H+NhUunutwEbIiTELyHdgKhRjtBJ4Zx3rh9x04xmTaG3XiyKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935250; c=relaxed/simple;
	bh=2alW063fqcncvoGsWJi8mp6fYnWIf8n8jT9pOQvyy7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQuPgHnybj3E+mKov7QCpUNxEb4dQ3ACiIvB/wuUSUTrYthG1J0jo+4xqFJvT2HvRZwAcdq5mFHZ45u1i/SZ6cLQ8dKjBiCwVhAYg8UuFISdDN/H0m/mi7A5UR9bYs/8c1JNLNzxTTSaNIj6iPYfDKumHMtWpcOgDLaVzC/ArrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kENJSi+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kENJSi+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CCDC4CEEB;
	Thu, 26 Jun 2025 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935249;
	bh=2alW063fqcncvoGsWJi8mp6fYnWIf8n8jT9pOQvyy7M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kENJSi+DyWexL7G/srvmIQIGrzXjmH1qt4UWKh11Cp2TYw5GEVRF9p1Zo1MZ4qhT4
	 9mvnfzkkd9EG68mpZ4SvhAowkGnGezH0OK0ufJrTIdPi5youZ22Belx1ml4W9aD4Tq
	 a3+oHXR2VbK7ZTx4N+RI/wWFOAL4z1ritp5vS9h9RqzM4xkVkJ4QYRLgckZmMNzuRK
	 SoLVvsQolZ+xWmCH/CV+RifkQ6BGT30uwegcF4BZ2o96qvIw9axLSh8+Lav978u8fm
	 2kkWQ57XgfZt4RLSbX3n97xL4TXJgPLgVeXHhHG+uxnAsYfHLPfgMRMzt9wx6MQPx1
	 +BMsMyH5kefPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6DD30CE0B76; Thu, 26 Jun 2025 03:54:06 -0700 (PDT)
Date: Thu, 26 Jun 2025 03:54:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/5] torture: Remove support for SRCU-lite
Message-ID: <167ab1f0-ea85-4a0f-8a19-1d74e2fa7439@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
 <20250624161400.867880-1-paulmck@kernel.org>
 <aFvmG2lT65Ido1fq@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvmG2lT65Ido1fq@infradead.org>

On Wed, Jun 25, 2025 at 05:05:47AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 24, 2025 at 09:13:56AM -0700, Paul E. McKenney wrote:
> > Because SRCU-lite is being replaced by SRCU-fast, this commit removes
> > support for SRCU-lite from refscale.c.
> 
> Please explain how they different and why one is a good enough (or
> even better?) replacement for the other.

Ah, good point, thank you!

How about if I add this to the cover letter?

	Both SRCU-lite and SRCU-fast provide faster readers by dropping
	the smp_mb() call from their lock and unlock primitives.
	The price of this is a pair of added RCU grace periods during
	the SRCU grace period.

	SRCU-fast also adds NMI safety for architectures that have
	NMIs but do not have NMI-safe per-CPU operations.  In addition,
	srcu_read_lock_fast() returns a per-CPU pointer rather than an
	integer, which provides a further speedup compared to SRCU-lite
	by getting rid of array-index calculations.

	There is a trivial mapping from the SRCU-lite API to that
	of SRCU-fast, so we do not expect any transition issues.
	In addition, while SRCU-lite remains in the kernel, checkpatch.pl
	will warn about added SRCU-lite use cases.

	Further read-side speedups are possible, but they amount to only
	about half a nanosecond out of about two nanoseconds (measured on
	my x86 laptop), and they might require some changes to existing
	SRCU code.  These changes are trivial, but we need to see a
	solid need for the additional performance before inconveniencing
	existing users.

							Thanx, Paul
