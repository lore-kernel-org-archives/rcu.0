Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D035F5FD;
	Fri, 13 Mar 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421654; cv=none; b=qGhKxL5ReMgidirWwK0Wqzik+xu1mcglBJ79b9Gdn8dhKzf1qNvDM26JWO66l+0BxV/DbxDkGZDkDUm85ptIx+46bAh/eTPN0eedQHl++GpwyJ6q9GDSr61TgA2/D2fRZ41Bb/8kb63gp3e0teLlxNr6jtOPhEYVF+yr/XQFuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421654; c=relaxed/simple;
	bh=Kbsc5ZLa4rQteS0D9v2Rlyto7t237zXp7aVRB6axqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW0OC//GTgjc0SJrI5YR6f9QQSbzGgJivIiFMfXeXu3+DUS9Qs++VOzh+JNkhxA98srD+7b9JQ5U+aD/nx9KGHoHlI6fhozbGJx/KCbPzl//rWayr+43W2qnMn16ehp+rNOqPigAaatLj2ZGzE6FvSqje7hX/e2/XOs+xGXynsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clmnKdLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clmnKdLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74814C19421;
	Fri, 13 Mar 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773421654;
	bh=Kbsc5ZLa4rQteS0D9v2Rlyto7t237zXp7aVRB6axqTo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=clmnKdLiyVXzrY0elcGARzDpCPznSYhWHmmxDPS+YXKljhre4ChgOsJ4ZJ12CiqrR
	 0DQ3AsZbcAIdbaGMcnMm5Iawm8dUpLvybb+tDgP3YlimUXVb8Jxww8cjT8cOznUu8y
	 dK2QLt0hkcOdyvefVy4EogUSPlzE8nLwgslnimK0/TnvLeLVP71XMUC8KwhcRtRoqm
	 Ngp0JHTfKBGBfbJlTrIVs/lgntnrbKENoTURRm5MH3FeXRa8s9fvT+yOy2YGU5OvJg
	 h5rEUVrIE4e79HoQeS4UpRRvNKCL6bYlu4B+J6653rhmmLB01icoTKaVQmcdlZyaYw
	 OPjCNsJIxOfFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1E7FCE0F14; Fri, 13 Mar 2026 10:07:33 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:07:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add BOOTPARAM_RCU_STALL_PANIC Kconfig option
Message-ID: <3dbfa497-091f-4538-8926-13f33fed3603@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>

On Fri, Mar 13, 2026 at 09:56:49AM -0700, Gustavo Luiz Duarte wrote:
> Add a Kconfig option to set the default value of the
> kernel.panic_on_rcu_stall sysctl, allowing the kernel to be built
> with panic-on-RCU-stall enabled by default.
> 
> This is useful for high-availability systems that require automatic
> recovery (via panic_timeout) when a CPU stall is detected, without
> needing userspace to configure the sysctl at boot.
> 
> This follows the pattern established by BOOTPARAM_SOFTLOCKUP_PANIC
> and BOOTPARAM_HUNG_TASK_PANIC.  The runtime sysctl can still override
> the Kconfig default.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/Kconfig.debug | 24 ++++++++++++++++++++++++
>  kernel/rcu/tree_stall.h  |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 625d75392647..fc2c775eeefc 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -175,6 +175,30 @@ config RCU_CPU_STALL_NOTIFIER
>  	  Say Y here if you want RCU CPU stall notifiers (you don't want them)
>  	  Say N if you are unsure.
>  
> +config BOOTPARAM_RCU_STALL_PANIC
> +	bool "Panic (reboot) on RCU CPU stall"
> +	depends on RCU_STALL_COMMON
> +	default n
> +	help
> +	  Say Y here to enable the kernel to panic when an RCU CPU stall
> +	  is detected.
> +
> +	  The panic can be used in combination with panic_timeout,
> +	  to cause the system to reboot automatically after an
> +	  RCU CPU stall has been detected. This feature is useful for
> +	  high-availability systems that have uptime guarantees and
> +	  where a CPU stall must be resolved ASAP.
> +
> +	  The kernel.max_rcu_stall_to_panic sysctl can be used to set
> +	  a minimum number of stalls before panicking, allowing the
> +	  system to tolerate a given number of RCU CPU stalls before
> +	  triggering a panic.
> +
> +	  This setting can be overridden at runtime via the
> +	  kernel.panic_on_rcu_stall sysctl parameter.
> +
> +	  Say N if unsure.
> +
>  config RCU_TRACE
>  	bool "Enable tracing for RCU"
>  	depends on DEBUG_KERNEL
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..43ddabf46b5e 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -17,7 +17,7 @@
>  // Controlling CPU stall warnings, including delay calculation.
>  
>  /* panic() on RCU Stall sysctl. */
> -static int sysctl_panic_on_rcu_stall __read_mostly;
> +static int sysctl_panic_on_rcu_stall __read_mostly = IS_ENABLED(CONFIG_BOOTPARAM_RCU_STALL_PANIC);
>  static int sysctl_max_rcu_stall_to_panic __read_mostly;
>  
>  static const struct ctl_table rcu_stall_sysctl_table[] = {
> 
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260313-panic_on_rcustall-95709d1abf2f
> 
> Best regards,
> -- 
> Gustavo Luiz Duarte <gustavold@gmail.com>
> 
