Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF561664;
	Tue, 21 May 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285600; cv=none; b=b1rATSMgFrTyBL8lQroZyU7algCWRIUb1YCm3MKtmaW8lWJU1VaVrJthtKrzsCYlWuRuZyy0f1aRPCPVwkZJWh4wB9OWDetiVGj33F4+2Pk73IUC+yCFXQ0MtMYJSF8dFMAIEcRkZMb1YflGqdLlBVkaJY4TsIbHq+w1kLnjntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285600; c=relaxed/simple;
	bh=1V+29lB8btSlk68MGRUu8mgqZi72yOl5RrQVg1+kexY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9B/q/p0EajYritAlaOBoO3JHDQTM/ckvsVPGr7Lp0PQkELFGTobpG5hk81/k97tK6vOegkBX0ZdmvGixCtnOgwRSVdTqdWe/qCp5VyVwQMTtUUGffUR4f9fHc0LpfltTwcistaXem/SBSOiGdiV2nzAXNyXR4RaiJo1/xNHTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyfMop+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyfMop+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C5C2BD11;
	Tue, 21 May 2024 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716285600;
	bh=1V+29lB8btSlk68MGRUu8mgqZi72yOl5RrQVg1+kexY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyfMop+BD1EOaHMDOUcgxCjgGH4r0BVXE4kkuV9vX3spvPSyjikPXNRngWxSruEQF
	 Fp8mI6YDGTv/v7LiRB1vLcaLntsQwG/BOk8Ywn0HUiXBo2PDwLqcUy0xQ/fZCwo2YQ
	 YUhj1SLn0tavDdt3dd03SMM3IAubupU6w4QM0VczXp5us61s12Px/QLrNHzsS/1Q2l
	 iKaNEaX6NUf7piEuuwFkYFDVyvoPIUqbR3n7R9F32bWn07cAgmMjdS2a/AMZ7NgJe9
	 rzNFi792eS2R9KUkxgIrgUn5nzX/TGiAPPQStT0TykVpFo7ZdUElYS6e2WT+HVcz2E
	 a54SjffkfzIDg==
Date: Tue, 21 May 2024 11:59:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] rcu/tasks: Further comment ordering around current
 task snapshot on TASK-TRACE
Message-ID: <ZkxwnZacvXqfHxZD@localhost.localdomain>
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-3-frederic@kernel.org>
 <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>
 <Zku1kDj_LjK3WxaA@pavilion.home>
 <24467166-5f00-45f2-867f-40b8a836d085@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24467166-5f00-45f2-867f-40b8a836d085@paulmck-laptop>

Le Mon, May 20, 2024 at 04:25:33PM -0700, Paul E. McKenney a écrit :
> Good points!  How about the following?
> 
> 		// Note that cpu_curr_snapshot() picks up the target
> 		// CPU's current task while its runqueue is locked with
> 		// an smp_mb__after_spinlock().  This ensures that either
> 		// the grace-period kthread will see that task's read-side
> 		// critical section or the task will see the updater's pre-GP
> 		// accesses.  The trailng smp_mb() in cpu_curr_snapshot()

*trailing

> 		// does not currently play a role other than simplify
> 		// that function's ordering semantics.  If these simplified
> 		// ordering semantics continue to be redundant, that smp_mb()
> 		// might be removed.
> 
> Keeping in mind that the commit's log fully lays out the troublesome
> scenario.

Yep, looks very good!

Thanks!

> 
> 							Thanx, Paul
> 
