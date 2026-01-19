Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E8263F34;
	Mon, 19 Jan 2026 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768866811; cv=none; b=dv/0XjybNhi9Ea/jMJ1ssrLgxAb010PYQHxSAYtlM6Mz+z2ZYXobLMATarUgtGrDHErboK9lLdLXbEIbv+Fyv6JzCt4caSypOdNzS4DHHnKyhApheNLQDhoEwfREBkg2e36K28JiJxXFskaXf6rpH5n/8ntrSvMu4JgFGaN6q7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768866811; c=relaxed/simple;
	bh=U/T6evyeL/QW1UF3DGDmeiZ7ztFTZk1lfnv2Gys3oTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSF+9X2LWGDsRj9hRJDUxf68+/QbkEozHdrq3L6aajXI7n+9ohxOlA6UfbDLVNq/Gy9DrgcZyvIFXUJWUUrJr3LaeaO/L2TQFtlOfLbkqIJsRW7fh4jJRCM0Hug0n8XnBtl4FR0NaKX0TGjLxH86/TFqp5y5ol3rBBsFc7Qmf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDMMhyFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDMMhyFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1746C116C6;
	Mon, 19 Jan 2026 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768866810;
	bh=U/T6evyeL/QW1UF3DGDmeiZ7ztFTZk1lfnv2Gys3oTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDMMhyFueakSc30fH0avs93RU8BIuTjLP9Jw9Zacu2tlsCAJVu/C6T5pVyRTSDLmf
	 kFCqu+Ujop6ah+Jz+5Ipl4ojvu+eNw0tWehYODIyAI+DTJ0gf8BiFS/+H5yN1S7D0E
	 puCtBY2ca49Y35ZqVUN/Jzi5tIAoST0z/e0N9wObpvewOt0bt52HZGDNPUlfCV7IST
	 clcaRE89XbN3N5R1rdt1nnUoioFjDWecAVzWDbCJP9lMU4cju81UwH7+7mdrh6j6t+
	 lKjHoRuJM+OAeHuwtD8fGeETn8CdzZ1YtwgC+EzkK8I7yGFkXGeQFh8MTeIZ5A4RGz
	 7yk72yR4Mmrqw==
Date: Tue, 20 Jan 2026 00:53:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <aW7D9ghPFdplSBII@localhost.localdomain>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119231223.989409-3-joelagnelf@nvidia.com>

Le Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes a écrit :
> During callback overload (exceeding qhimark), the NOCB code attempts
> opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
> this entire code path is dead:
> 
> - 30 overload conditions triggered with 300,000 callback flood
> - 0 advancements actually occurred
> - 100% of time blocked because current GP not done
> 
> The overload condition triggers when callbacks are coming in at a high
> rate with GPs not completing as fast. But the advancement requires the
> GP to be complete - a logical contradiction. Even if the GP did complete
> in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
> it is pointless.
> 
> Since the advancement is dead code, the entire overload handling block
> serves no purpose. Remove it entirely.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Would be nice to have Paul's ack as well, in case we missed something subtle
here.

Also probably for upcoming merge window + 1, note that similar code with
similar removal opportunity resides in rcu_nocb_try_bypass().
And ->nocb_gp_adv_time could then be removed.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
