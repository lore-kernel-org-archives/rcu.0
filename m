Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="odqrkkPO"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F39184
	for <rcu@vger.kernel.org>; Sun,  3 Dec 2023 05:18:24 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A32253F322
	for <rcu@vger.kernel.org>; Sun,  3 Dec 2023 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701609502;
	bh=HHmlffykkOJ0/mztigbZgIMRb64RNyQwKkrsR2WWoBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=odqrkkPOfA2hY4agb9CGyTHn1K2SUxWeLt0k8YpiCqxIAvcq+C/XfhyyEftc+pvl8
	 RKb/VxnXZboQNWKiQnWNu1iZt+pMtoRcShPGdrPasiegEXAeG3TCFAsp/4h/OIHaYa
	 g+LTPDn2ZHE1CfQTgCf1Rl0BRuKYIS9fnXylxpwU2+JjTIM3NubEM+cz2N4lp4ikrc
	 79Qco/b1aGotLzoA4Jt+EaAozxGZ1G/PK4C/e+Ugh54k5nFyTo9DTR3LDGYN/oknxe
	 tCEG/kGC6fKUl2TLmWREPLMHZf1IfrzbuB20KsCCSvHKlNYkbfnXcv8aOSp/NQ76qz
	 inDKWdpfsF4qQ==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c09873c81so2950725e9.3
        for <rcu@vger.kernel.org>; Sun, 03 Dec 2023 05:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701609502; x=1702214302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHmlffykkOJ0/mztigbZgIMRb64RNyQwKkrsR2WWoBM=;
        b=cmXejx0fNBZ7iYUcMnLbM3ctDG7onynW3SuAMN7AKBlkucnDf8I/MeaS1M1gxXh0Vb
         m+LONYRftaq9OHDQ5nwtOwGLIdkmPtWdTeGactmesUSK1L5+n0fKd1iazwhVMPpErew0
         JLSTA8XPx7eKSJLlTzxY1Y6DFfTBgJt6GrKRoA9aHvQTvasj0Dz57hVpvO3ES9Ognbro
         Mb5mIjyoAsIvkObL0FPSxBWvs8K0Ura9g53Ww8quVjL//SuyJtz/4eQcVE6dFb9bSxVs
         C/We8IpwvY0rE9gQw+ssjQpYj+uM/Q39gux3clItWzkK5r1RmtUDP8sQCTPXVQXf8p/K
         Eezg==
X-Gm-Message-State: AOJu0YzjHAOqDSTqDBGyWv+67dcDuWYS3nmBjhONlRuTp74eVSP8rI6X
	Ozetc7iHj8VM/S0NIddKTuCIxz8gCcpRNWtvs+IZjhuNmgt8gPVbO6/cN4BqPdsltig2GBN/Wde
	6yt3Z1hXWjFKm/5e0i4gnlgLCd/DQug/e6y/BoFSi
X-Received: by 2002:a05:600c:548c:b0:40b:5e21:bdc9 with SMTP id iv12-20020a05600c548c00b0040b5e21bdc9mr1533775wmb.88.1701609502083;
        Sun, 03 Dec 2023 05:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVYa5ls19mDZQ6yIBuaFYXzF2OGg7dLouI1dHA9+Yq2fZmaG26r57u7Bya+m2hSG6ybaXvQQ==
X-Received: by 2002:a05:600c:548c:b0:40b:5e21:bdc9 with SMTP id iv12-20020a05600c548c00b0040b5e21bdc9mr1533753wmb.88.1701609501096;
        Sun, 03 Dec 2023 05:18:21 -0800 (PST)
Received: from localhost (host-79-35-130-102.retail.telecomitalia.it. [79.35.130.102])
        by smtp.gmail.com with ESMTPSA id hd37-20020a17090796a500b009c503bf61c9sm4083032ejc.165.2023.12.03.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:18:20 -0800 (PST)
Date: Sun, 3 Dec 2023 14:18:19 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <ZWyAG145F+JWzg7u@gpd>
References: <20231203011252.233748-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203011252.233748-1-qyousef@layalina.io>

On Sun, Dec 03, 2023 at 01:12:52AM +0000, Qais Yousef wrote:
> To allow more flexible arrangements while still provide a single kernel
> for distros, provide a boot time parameter to enable/disable lazy RCU.
> 
> Specify:
> 
> 	rcutree.enable_rcu_lazy=[y|1|n|0]
> 
> Which also requires
> 
> 	rcu_nocbs=all
> 
> at boot time to enable/disable lazy RCU.
> 
> To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
> CONFIG_RCU_LAZY_DEFAULT_OFF can be used.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Thanks! Everything looks good to me and I also verified that
rcutree.enable_rcu_lazy is enforcing the proper behavior.

FWIW:

Tested-by: Andrea Righi <andrea.righi@canonical.com>

> ---
> 
> Changes since v1:
> 
> 	* Use module_param() instead of module_param_cb()
> 	* Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
> 	* Remove unnecessary READ_ONCE()
> 
> Tested on qemu only this time with various config/boot configuration to ensure
> expected values are in sysfs.
> 
> Did a bunch of build tests against various configs/archs.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree.c                               |  7 ++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..2f0386a12aa7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5021,6 +5021,11 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.enable_rcu_lazy= [KNL]
> +			To save power, batch RCU callbacks and flush after
> +			delay, memory pressure or callback list growing too
> +			big.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bdd7eadb33d8..e7d2dd267593 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -314,6 +314,19 @@ config RCU_LAZY
>  	  To save power, batch RCU callbacks and flush after delay, memory
>  	  pressure, or callback list growing too big.
>  
> +	  Requires rcu_nocbs=all to be set.
> +
> +	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> +
> +config RCU_LAZY_DEFAULT_OFF
> +	bool "Turn RCU lazy invocation off by default"
> +	depends on RCU_LAZY
> +	default n
> +	help
> +	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> +	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> +	  it back on.
> +
>  config RCU_DOUBLE_CHECK_CB_TIME
>  	bool "RCU callback-batch backup time check"
>  	depends on RCU_EXPERT
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..8b7675624815 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  }
>  
>  #ifdef CONFIG_RCU_LAZY
> +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> +module_param(enable_rcu_lazy, bool, 0444);
> +
>  /**
>   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
>   * flush all lazy callbacks (including the new one) to the main ->cblist while
> @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
>  	__call_rcu_common(head, func, false);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> +#else
> +#define enable_rcu_lazy		false
>  #endif
>  
>  /**
> @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> +	__call_rcu_common(head, func, enable_rcu_lazy);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> -- 
> 2.34.1
