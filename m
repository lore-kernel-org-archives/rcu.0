Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="B/J8ZK/i"
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D0C3
	for <rcu@vger.kernel.org>; Tue,  5 Dec 2023 08:20:45 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b3871b5ff7so216799339f.3
        for <rcu@vger.kernel.org>; Tue, 05 Dec 2023 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1701793245; x=1702398045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBuGaAJFY5OZVJUfBILHZ16GmnApBjz6XJR5WiDcpZ0=;
        b=B/J8ZK/ipQfLDtmvCgNG+uFb06KRkHGbFrrK55SOyTadhJYfa6exsUCu2b+EZXOVAz
         z9hcABLd2m044HZLyl6ZWDYjIM+bFoAGnYiGL0j/Z+PggcJZ/dPZdTDx9d750xtcxzXC
         27BEjAUAQAfhvHfydVSjFGKDY71ZY7GMoJVK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793245; x=1702398045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBuGaAJFY5OZVJUfBILHZ16GmnApBjz6XJR5WiDcpZ0=;
        b=UnRjeLrx2vJmlbBDZFALX4mzHL9s9xL2GHYEdaw8D0yEC3NSDz0fTrDmpkeZIyyT3Q
         1fQ/z1bKolbRZYuTxnfblafxmZeJ/TIUp3lLUPCNHOiOCnhQRv2e68pM1+RwZ86aIVAV
         m83r+TZX9TEk0Qmt8TArUkMlPjdmScpRxmhADvifdlI6zkRTFj3ykHqeExi9URxI6y78
         jq+ogV6t4s6VecrOVd7fd1+2Mujr9VIsmHVs2kfTkeUz+KPFYZy4OgMt+wtDoWoujWa9
         6W1RtQ2YhcW4e/ZGEVsRGCY3cJk1JRBfvGI7aVSBv6CpjwARmTnh1cEBcSUtZrRyD1XA
         E56Q==
X-Gm-Message-State: AOJu0Yyt/PKEz9iBEPYcE2WYBTWarjDJv8y2RzUaWdJQtyHyG9/+oXkb
	AaIjYUI2l0JoPXR7I2gpvqOxXA==
X-Google-Smtp-Source: AGHT+IFdV22JKkn3AU9h/iHTCNkbcqwNKQTPYh1GkLjeDd3z34IRh0OyVnd1/QkDWWGCVOh+aWEGPQ==
X-Received: by 2002:a05:6e02:4ac:b0:35d:59a2:92a3 with SMTP id e12-20020a056e0204ac00b0035d59a292a3mr5613938ils.55.1701793244786;
        Tue, 05 Dec 2023 08:20:44 -0800 (PST)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id bs11-20020a056e02240b00b0035d55788523sm680856ilb.82.2023.12.05.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:20:44 -0800 (PST)
Date: Tue, 5 Dec 2023 16:20:43 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <20231205162043.GA2558193@google.com>
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

Thanks Qais, I have a comment below:

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

I think a better approach is not do an anti-CONFIG option and instead do
a shorter parameter "rcutree.lazy=0". If CONFIG_RCU_LAZY is set, then we can
just default to keeping lazy on. I'd like to avoid proliferation of already
large number of RCU config options and more chances of errors.

I also want lazy to be ON for everybody configuring it into the kernel by
default (those who don't want it just set CONFIG_RCU_LAZY=n), this is what
tglx also suggested that's why we made changed of our initial prototypes of
call_rcu_lazy() and instead we made call_rcu() to put everyone on the lazy
train and not add more APIs (thus causing more confusion to kernel
developers). This was a bit painful, but it was worth it.

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

And then this can just be                    = true;

thanks,

 - Joel


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
> 
