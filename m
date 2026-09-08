Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F539478E5F;
	Tue,  8 Sep 2026 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911913; cv=none; b=DL6rpPyMc8oaH1czSweKzsIascSedsVTWzlSXtglYmoy6v5HP2envX5eHLtmnuk0sC0Wsd+TooKwZh0F8DW4iQpU2BXhQO+Hs6xQ7NZPO92Gz1kv3XhafgNrFH8/asvY0ucNIWkIrhKYcYxSQJcBnGxllZBG8NxRliom0QHyHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911913; c=relaxed/simple;
	bh=2iIt0dBVtnpUQa+dofM87w//G+Mhvv2wMDbSc1XTA/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI5P5VebaeOOW7X6s8874msW489KTfVpKtMoHmRu0qBZycpA+7ncXGoF2A6imVXqO6RDHpuSqpO3Zwmt3MogCm+rjR3CkuwHJ5OWI+7oyNKOn9GZ8xYIBF4CzCuDLmWTeUs/6ejFLxekUBAdSujNa7O7CxQ0bpJ6Kk4ns8s7Gxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AukXqa51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AukXqa51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4031F00A3A;
	Tue,  8 Sep 2026 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911912;
	bh=/2r5FRCbotxO4zRGHoC5i3cxoc8+LgVE65Nim6xix+I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=AukXqa51nA9XBJ1CN13d0ezHjNKq3UF6Zg1Q7yhVzAUmbX7WbJj2ZbENSwLlRD0Lz
	 yDK9sjuB2NvqVI09Ua3EAlWln8k6Wf8VYY33AQ8rMsM84cIMKxTGw7x8OzFc7Vqeu8
	 IuDz13pWami7ap2VBDyXVmhBQY1NOdjQBPrC8rgWjmkU6RExSBcmZHbCeoeczya7bK
	 8vGQKe1OVeg+9PIKnAYVK7ASRdhP3OLbIlmgK0IfNTxczuzz/zzyq3l1kV7UFuS4iL
	 CfI9sA8fI67LviO9GI4hHc6fADjnNeshgHJ5OPWzGh8BpSz4DcIBSebKSB2zsecX43
	 FxaMEPlrc6qgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00EAFCE18F4; Tue,  8 Sep 2026 16:58:31 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:58:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] litmus: Add SRCU fastpath anchor-before-scan test
Message-ID: <35d6d803-41d9-48d6-a8d0-b8d0f6f67efd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-2-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-2-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:17PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> synchronize_srcu_atomic() may end its grace period immediately when
> its scan of the per-CPU lock counters finds no readers.  Correctness
> requires the grace-period anchor written by srcu_gp_start() to precede
> the smp_mb() ordering the lock scan.  This ordering ensures that any
> reader whose lock increment is missed by the scan cannot have
> incremented its lock counter before the grace-period anchor, and
> therefore cannot be a pre-existing reader of this grace period.
> 
> This litmus test models the key ordering between the grace-period
> anchor and the lock counter scan, where "seq" models the
> grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> smp_mb() and the lock scan.  P1 models the reader-side counter
> increment, with the smp_mb() of __srcu_read_lock() following the
> increment.  P2 models an observer that sees the reader's increment
> before seeing the anchor.
> 
> The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> which permits this outcome.
> 
> Tested with herd7 7.58 using linux-kernel.cfg.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Litmus tests!  Very nice!!!  

Could you please put both of these in Documentation/litmus-tests, in a
new "srcu" subdirectory?

One thing for your consideration is use of the "filter" clause for the
first term of your "exists" clause.  Not a big deal at all for this small
of a litmus test, but the idea is that this litmus test only cares about
the 0:r2=0 case:  If that condition does not hold, then P0() and P1()
aren't the beginning and end of a valid SRCU read-side critical section.

Use of the "filter" allows herd7 to abandon a given execution early,
so it is a big deal for larger litmus tests.

Again, what you have is fine (or will be when moved to the other
directory), just pointing out the additional feature.

If you would like to see a use case, please see:

Documentation/litmus-tests/locking/RM-fixed.litmus

							Thanx, Paul

> ---
>  .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> 
> diff --git a/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> new file mode 100644
> index 000000000000..8200a75e15ef
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> @@ -0,0 +1,56 @@
> +C SRCU-fastpath-anchor-before-scan
> +
> +(*
> + * Result: Never
> + *
> + * The synchronize_srcu_atomic() fastpath may end its grace period
> + * immediately when its scan of the per-CPU lock counters finds no
> + * readers.  Correctness requires the grace-period anchor written by
> + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> + * This ordering ensures that any reader whose lock increment is missed
> + * by the scan cannot have incremented its lock counter before the
> + * grace-period anchor, and therefore cannot be a pre-existing reader
> + * of this grace period.
> + *
> + * This litmus test models the key ordering between the grace-period
> + * anchor and the lock counter scan, where "seq" models the
> + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> + * smp_mb() and the lock scan.  P1 models the reader-side counter
> + * increment, with the smp_mb() of __srcu_read_lock() following the
> + * increment.  P2 models an observer that sees the reader's increment
> + * before seeing the anchor.
> + *
> + * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> + * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> + * which permits this outcome.
> + *)
> +
> +{}
> +
> +P0(int *seq, int *ctr)
> +{
> +	int r2;
> +
> +	WRITE_ONCE(*seq, 1);
> +	smp_mb();
> +	r2 = READ_ONCE(*ctr);
> +}
> +
> +P1(int *ctr)
> +{
> +	WRITE_ONCE(*ctr, 1);
> +	smp_mb();
> +}
> +
> +P2(int *seq, int *ctr)
> +{
> +	int r3;
> +	int r4;
> +
> +	r3 = READ_ONCE(*ctr);
> +	smp_mb();
> +	r4 = READ_ONCE(*seq);
> +}
> +
> +exists (0:r2 = 0 /\ 2:r3 = 1 /\ 2:r4 = 0)
> -- 
> 2.43.0
> 
