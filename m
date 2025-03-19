Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F92251793;
	Wed, 19 Mar 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374901; cv=none; b=dHG3Lq2NoI858D9GUPL7bh0wEHVkhJt+wnRBv4RQKCGCA4YPhuTsOxnY7sPphZztQkKl20KG31L6VMtKTpd3ACXXsYdUTW+G3D/LVIxTAqTjItYjF+SNNj0Rj4uLL+4Ba9lTgKCcfp8/AB/EjoSQbOP+zwF591SHf5H/b+z6Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374901; c=relaxed/simple;
	bh=RvpwI2aDYVeF1gVJz8YRQ12jMBzTRkZJJir2youLL0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBNq0MJoFINeWuO6XfqOu2hAsfVCZJukcFj06uQed6cCG7wo47X8fWzSRLTSxUyiSG5XCsobnzTtgExyb2QDsNUttN2kj6LVaQzZ2aygmF7k1K0jAPhGWM05osSXnEi0PGQ1GfwAskccCKZR03OeJkdx+G44L5tb+gwHnBE6nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IonTyTz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IonTyTz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309CFC4CEE9;
	Wed, 19 Mar 2025 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742374900;
	bh=RvpwI2aDYVeF1gVJz8YRQ12jMBzTRkZJJir2youLL0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IonTyTz1Z8E7ep8b2L2v5j5QC/eCF6XbU2p8ZPRQP/wb+3sZOnTE9I+jog24SgHfc
	 0lomSL+miPEgRrzG6Ff93wsUGCrLioP6lcmT8GpL9gN7Kxsd3Xs9qQ9rn0xS/wzeBd
	 EGVEeD16mT/QgICVpglmoNU2P//NqcyboYR6txQHpUqeDVJt/vjh1+VV/2deZfdkTo
	 1JnPQi0hhkse/BEedi6+W1PEsgzEvehG3iiip09nFmrbzx5HVFFNOKeHunyJ8aem8u
	 PkfyKGNjbfnVi2woi73vkos9CsP+fdbNdtXcfGDKV07vq0zOE6IRaDVNiurdQ264R7
	 u15aEE9alL7Ig==
Date: Wed, 19 Mar 2025 10:01:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/5] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <Z9qH8MHMtL-l_X-G@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-3-frederic@kernel.org>
 <6fa10edf-a04c-4a1d-9e11-fbed6332bff0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa10edf-a04c-4a1d-9e11-fbed6332bff0@paulmck-laptop>

Le Tue, Mar 18, 2025 at 10:18:12AM -0700, Paul E. McKenney a écrit :
> On Fri, Mar 14, 2025 at 03:36:39PM +0100, Frederic Weisbecker wrote:
> > A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> > to order the context switch (or rather the accesses prior to
> > rcu_read_unlock()) with the expedited grace period fastpath.
> > 
> > However the grace period can not complete without the rnp calling into
> > rcu_report_exp_rnp() with the node locked. This reports the quiescent
> > state in a fully ordered fashion against updater's accesses thanks to:
> > 
> > 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
> >    locking while propagating QS up to the root.
> > 
> > 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
> >    the root rnp to wait/check for the GP completion.
> > 
> > 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
> >    before the grace period completes.
> > 
> > This makes the explicit barrier in this place superflous. Therefore
> > remove it as it is confusing.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Still cannot see a problem with this, but still a bit nervous.

Where is the challenge in life if we manage to fall alseep within a minute
at bedtime?

> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!
