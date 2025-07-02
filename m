Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF411C32;
	Wed,  2 Jul 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415787; cv=none; b=auRry7TAetkDt+1bXTQvZDBhAPMsD3lNCL9qm7fDEyrAbeLEay/iw6iat+uNamh2UJ2rKR6bbprKzLPwbYo9+CxVM6QtAvBMzECe1B+pB0805V8k1HM1kKd1NND8BmraF4rMR1h/pMBReYAlDkrGnMAf06nrldTHaMGlJfbuBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415787; c=relaxed/simple;
	bh=yojyvkE35IyqeWXBaopmtqHNdC508aa/FvWO3L7mqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Ljbei3rAolbfmb5yurK8QU47B4tOHQtleopqp8B0fGNROgX2qybXj4fKwpXziLseW4Nd7Unv2Z4QAjsoFH4ZAhzoijnySJszAVWyw6sPuFaZBeGIBqXWkK9CMHm6U0jZc327L+LBlFpB3l/n9SOfPSenqmcVAo4loHbzTNGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNBwJEwy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNBwJEwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0246CC4CEEB;
	Wed,  2 Jul 2025 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415787;
	bh=yojyvkE35IyqeWXBaopmtqHNdC508aa/FvWO3L7mqDw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hNBwJEwy40erhcmsUL9sJPWWvwZnR+Ndz0hgps90NRE5icxZ0qE8PvIbV7tdnlNSx
	 xeqTNcAweA7NdrRJOHeXQLizoWkRlaQVwq2G20VwAhMGc/MZs6PQKm/QlSvqvmTUIX
	 c4H7pZFuGCVZcFCYlWjatlbKSVRv1+KSkvVZGgrehEOMHm3n+h5/Yjp/EJYo6q1McD
	 oPUksFD1QsSogsBMdsJVDfezc0mvV0n3iYy7CD1433JhSVJx2s5tN5yXRqS+X7jCen
	 VhPuBOshb6H3Y96jaJJ83yteG9F3LbGRUPFb9usnV9uqwVQp1E5h70ZlL69vydJaDT
	 /KLHlG2Gzb74Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A31FBCE0E63; Tue,  1 Jul 2025 17:23:06 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:23:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/5] Remove SRCU-lite in favor of SRCU-fast
Message-ID: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>

Hello!

This series removes the deprecated SRCU-lite flavor.

Both SRCU-lite and SRCU-fast provide faster readers by dropping the
smp_mb() call from their lock and unlock primitives.  The price of this
is a pair of added RCU grace periods during the SRCU grace period.

SRCU-fast also adds NMI safety for architectures that have NMIs but do
not have NMI-safe per-CPU operations.  In addition, srcu_read_lock_fast()
returns a per-CPU pointer rather than an integer, which provides a further
speedup compared to SRCU-lite by getting rid of array-index calculations.

There is a trivial mapping from the SRCU-lite API to that of SRCU-fast,
so we do not expect any transition issues.  In addition, while SRCU-lite
remains in the kernel, checkpatch.pl will warn about added SRCU-lite
use cases.

Further read-side speedups are possible, but they amount to only about
half a nanosecond out of about two nanoseconds (measured on my x86
laptop), and they might require some changes to existing SRCU code.
These changes are trivial, but we need to see a solid need for the
additional performance before inconveniencing existing users.

1.	Remove support for SRCU-lite.

2.	Remove SRCU-lite scenarios.

3.	Remove support for SRCU-lite.

4.	Remove SRCU-lite implementation.

5.	Remove SRCU-lite deprecation.


Changes since v1:

o	Add short explanation of SRCU-lite and SRCU-fast.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h                                     |    2 
 b/include/linux/srcutiny.h                                 |    3 
 b/include/linux/srcutree.h                                 |   38 ----------
 b/kernel/rcu/rcutorture.c                                  |    7 -
 b/kernel/rcu/refscale.c                                    |   32 --------
 b/scripts/checkpatch.pl                                    |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST    |    1 
 include/linux/srcu.h                                       |   47 -------------
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L      |   10 --
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot |    3 
 10 files changed, 4 insertions(+), 141 deletions(-)
