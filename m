Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB03E1732;
	Sun, 13 Sep 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341411; cv=none; b=EjAc3YzB+o4Xzv6+rhyzqGdyoXagb6iKiZBePmAylwVv8wT1U39Ft7Qu61X92lh9FIvWtYAh3Ofinlbp1CuH2Lamfv7WjSeBib5Ysd8Lmximz7iwoxAUtZu9KlonCY5f83g2IS0bdgkmX7wsKLT6f+b42FCN2+Yc3sfKFR6uEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341411; c=relaxed/simple;
	bh=JXW5pazIt0m9rW3j1FCLLZD+/rfJcIwPBJLZ86E9+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKks1ZXX2ZHIbpCpJDwpzxTclpORwiWPK85U0GxsLKu0rrfVP3/bgE2Zvj45cL8t/d4oZ0nkA01zI9iJ0PS2bcW5BB1h3niPN9+Q5vQPIRwLRjock97fxxF1fNPnQfOAg/MgQRUF1pzhT+44kyDyWM3+LscQR80rjXVpX8NVa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky2lcyJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky2lcyJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CDB1F00898;
	Sun, 13 Sep 2026 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341403;
	bh=Wpw8DXIdkmwtYAESTFnvMq2JNAB1lVuTFbrUo8u7ykE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ky2lcyJ1UQElX5/fKuNaizqCgpqptTT9L5/IRqzY0ok6jsAJ8pW75mAG6EOuECvyw
	 0CyehCHh454DO5ENHHeSDtxfVYWLxaqCJCNvsqidr391lfL6/ABdkJ8KwJPODMbM/K
	 94UfZV/jr6j3b1GmhdgeCMRIFQpxBWKqGyDykDtekZKudb0QF62TxMHlmH73pEcfWM
	 z+5P46k2YFZKfM9Wwn8TGvdBPqsn5KBC3y9c2sTAHgSAT3BX1qrQk/+o8HLmHQxQUv
	 amddvJVr7DNkJUcQHh4ByhE+yie8fNRrHxiQTqGUawcLAzUc5OfHFUuQJsKkM3fk4y
	 42zOxSwutQ+bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2226BCE107B; Sun, 13 Sep 2026 13:35:07 -0700 (PDT)
Date: Sun, 13 Sep 2026 13:35:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: kunwu.chan@gmail.com, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3] srcutree: Don't transition atomic SRCU to big in
 srcu_gp_end()
Message-ID: <c2992cac-af72-447f-b1c6-cee138433e4a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911072125.2268530-1-kunwu.chan@gmail.com>
 <52A1E6DD-17E3-42AC-B5A4-B2835A288EF8@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52A1E6DD-17E3-42AC-B5A4-B2835A288EF8@mainlining.org>

On Sun, Sep 13, 2026 at 01:47:05PM +0100, Bradley Morgan wrote:
> On 11 September 2026 08:21:25 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
> 
> Better late than never.
> 
> >Atomic SRCU must remain in the small size state. Warn if this
> >invariant is violated and avoid transitioning to big in that case.
> 
> Fair enough.
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

> >Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >---
> >Changes since v2:
> >- Also prevent the transition when the atomic SRCU size-state
> >  invariant is violated, per Paul McKenney's suggestion.
> >-v2: https://lore.kernel.org/rcu/20260910084629.3695383-1-kunwu.chan@gmail.com/
> >
> >Changes since v1:
> >- Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
> >  per Paul McKenney's suggestion.
> >- v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
> >---
> > kernel/rcu/srcutree.c | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index 84c022ec8e09..07db4e459b30 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -1073,8 +1073,11 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> > 		raw_spin_unlock_irq_rcu_node(sup);
> > 	}
> > 
> >-	/* Transition to big if needed. */
> >-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> >+	/* Transition to big if needed, but never for atomic SRCU. */
> >+	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
> >+	    ss_state != SRCU_SIZE_SMALL) {
> >+		WARN_ON_ONCE(1);
> >+	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> 
> I like this fix.
> 
> > 		if (ss_state == SRCU_SIZE_ALLOC)
> > 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > 		else
> >
> 
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
