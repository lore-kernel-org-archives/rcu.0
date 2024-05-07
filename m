Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB916D4DF;
	Tue,  7 May 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088760; cv=none; b=C9zGORXu2vhiYw+njxX1o/zBtWqoUKReQsqLFcFgYIrzNXsLuupYLl05paXLI4tTqT9Hjyo64bzg3q2cz2kx+om4UxHaSKl8PtbfBdp6kOcUPUpcU7lyNgSVC0Ru7809/zosmBEa+QuHmmiivdC0CkBcpI+41nY5FBzydhUitJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088760; c=relaxed/simple;
	bh=G6I17PDBQdLIDBAVhfjVBp/SrAW4GX4/wPzwmMQSKYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUUkJgWhEJthIC3d/V9DrS77A/h+VrgPWZAwdsl9/WaldqRteVND5FeaYP4cNk++k64HDNTmiyFgKd+h6vxUM2YQA0e6TsHpJSs1iXgUHf2DI2BReyzJPdj3Vk07OJu0jVHPWlZu3r8QXlAlCQU8uGITmNoBBoViGQt8Dupt6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPVM6tgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPVM6tgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E2C3277B;
	Tue,  7 May 2024 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088759;
	bh=G6I17PDBQdLIDBAVhfjVBp/SrAW4GX4/wPzwmMQSKYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPVM6tgYD0JdV7kF9pFpuUUG/SmXrDjBL3V4gGBLj05sJH+TsGk/K2R7NAmMT/mrz
	 oUN+ueHb1ZTrKScUeZVpBLk7NN7F5SOdGocLE162Qf5kDa+mpBSwBcYZVx1PBEUKY+
	 OYzw8voqQymQyCxDuoim5dkWKd1wuCae0CfTcm1eABBTZUMaH4dZWG1Cu4mbLM6A6C
	 k+1YhnWb5PrPrO1cA/LjjV8qvECmwFRyeCzxe3Hb3BPq1m6mnKAKMIC6dbazZigoJE
	 3l3Urdk991Hoqjy2I/T9HHQNDvJuvktJAvKFAq0bwflwIqnUf9UFDiOK4FWFZ92qc7
	 Lp+8/fNIywzAg==
Date: Tue, 7 May 2024 15:32:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 17/27] rcu: Rename rcu_dynticks_in_eqs() into
 rcu_watching_in_eqs()
Message-ID: <ZjotdJwp3RXkrA7S@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-18-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-18-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:21AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/rcu/tree.c       | 8 ++++----
>  kernel/rcu/tree_exp.h   | 2 +-
>  kernel/rcu/tree_stall.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 857c2565efeac..d772755ccd564 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -308,9 +308,9 @@ static int rcu_watching_snap(int cpu)
>  
>  /*
>   * Return true if the snapshot returned from rcu_watching_snap()
> - * indicates that RCU is in an extended quiescent state.
> + * indicates that RCU in an extended quiescent state (not watching).

*is in

>   */
> -static bool rcu_dynticks_in_eqs(int snap)
> +static bool rcu_watching_in_eqs(int snap)

I would be tempted to propose rcu_watching_snap_in_eqs() but the
purpose is not to dissuade people from intoning RCU code after all.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

