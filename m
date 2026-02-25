Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57919EED3;
	Wed, 25 Feb 2026 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056045; cv=none; b=W5hQ6H0gyARFG657rvh39CAIZzvoYFn3WDVaaevHx5jvVcK4tmNUhqFdAXXhETZ+e+2j4cm8E5M1xkO+k21iDfuXqUonQk1wuCy2+noRj2cpRPc/b9Cngy1kYdREdcbefohYsvKKt0Ua7tMAOhcMKa0//4ZsASEA6p6PCNhZS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056045; c=relaxed/simple;
	bh=eB3dlDanSUqHdVRoj+kS2XXrd11UXSD/TKi4J5qRdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttPUdzt1nL7O1NCJPaGRxSpaerN5TRibmuzLbHnjVJ51nZqIezdtc7LyVjq4bbDs/qBb9Rf3sBrkEzYiHMGf69WPVZq1zZqukOzlq3tBNvrwtenO4h+cHXsEtZiF3VRoBokReI1D3dZEUEoqqj7G72p7krKXzH50+gytcvYjCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvQul3ao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvQul3ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D3CC116D0;
	Wed, 25 Feb 2026 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772056045;
	bh=eB3dlDanSUqHdVRoj+kS2XXrd11UXSD/TKi4J5qRdIs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rvQul3aoyYiV3rHDdCLvjyBHsATkmo+C0Z+0XmbWvUypeh9ek6l0mh6924e94wNbE
	 QQxu0G42OZ8Urmpr7jQ4miF3xBdlCD7qBW8E34mXSBitldklFf9XrSHXzPFswtNKm0
	 Rq4WBdViQisD+GN3z+GTaY3isBPcK8d6nnPEer8KZdRTFiT1JK8r1e2qU9gWr0YaCn
	 NwB/i/gKka83DkgtmFTwrrlOGB2kVnLVnYmspWiPJ+KNqfvfCfvLC0ch4wYJO/ti6m
	 oyaZ6s+tDM1vqO1tgZoeUuN4bMznDn3+DfNGKgZf6/ePi9665oikDftIgRG+KIVe46
	 8N4n7T530fbrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C4702CE0A7F; Wed, 25 Feb 2026 13:47:24 -0800 (PST)
Date: Wed, 25 Feb 2026 13:47:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 4/4] rcutorture: Add NOCB02 config for nocb poll
 mode testing
Message-ID: <89367e04-7647-4165-be41-385b61aa131b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224230435.3390963-5-joelagnelf@nvidia.com>

On Tue, Feb 24, 2026 at 06:04:35PM -0500, Joel Fernandes wrote:
> Add new rcutorture config NOCB02 that enables rcu_nocb_poll boot
> parameter combined with CONFIG_RCU_NOCB_CPU to exercise the polling
> mode code paths in the NOCB implementation.
> 
> This config exercises poll-mode paths not covered by other configs,
> where callback invocation uses active polling instead of kthread
> wakeups.
> 
> This config is not added to CFLIST to avoid increasing the default
> test duration; it can be run explicitly when poll-mode testing
> is needed.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

For 3/4 and 4/4:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  .../selftests/rcutorture/configs/rcu/NOCB02   | 20 +++++++++++++++++++
>  .../rcutorture/configs/rcu/NOCB02.boot        |  3 +++
>  2 files changed, 23 insertions(+)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
> new file mode 100644
> index 000000000000..4c2b8cd6d8fd
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
> @@ -0,0 +1,20 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=8
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +#CHECK#CONFIG_PREEMPT_RCU=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_RCU_TRACE=y
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_RCU_FANOUT=3
> +CONFIG_RCU_FANOUT_LEAF=2
> +CONFIG_RCU_NOCB_CPU=y
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_PROVE_LOCKING=n
> +CONFIG_RCU_BOOST=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_RCU_EXPERT=y
> +CONFIG_RCU_EQS_DEBUG=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> new file mode 100644
> index 000000000000..c212ae299b0b
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> @@ -0,0 +1,3 @@
> +rcupdate.rcu_self_test=1
> +rcu_nocbs=all
> +rcu_nocb_poll
> -- 
> 2.34.1
> 
