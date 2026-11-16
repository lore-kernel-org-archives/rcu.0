Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790174;
	b=HA5RGdXXXpBK0kbZOzG/etsWnI/0R4QFFXi0IH4mRYJ0eStn5wmS8JRTeSgLNXRvW2sY
	 82aX3RhHcB+3IGtGjKsgHfdf0mVWxs5aIQSvSVa26bNXMB8zm9OTzJiYiu1RinYDR/UWO
	 h1uVarUJqkt2T+WUeuTZ1EpycxNa+NR9da36B0ISfhyQjvEM5Dz+cy4FJq3sHzd8FijwB
	 T9HSvAGeDsbPAzj1ankGqlYIGr28VCf5+lry1DxbccdfqNhcHk5A5la4enELllhKhQsYT
	 LeEfTnzxyOndIEGBHilwk7xzrepDvnQ0JSRGwxEE6wSc0iDxv196+gVHESwMULz0D9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790174;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=E0D8N8G+zEmku/06qMS2sDSDN9cKW5ShnuCBC1SI0dw=;
	b=qWDxGiuqEYBlqRFqL+NEiBHy9fDbYyf5xanLiiLxs3r15CXQLu25R90IrSMvtEU5XJ2e
	 6+wb2jVT3Ducz3OKXBW1hy1wfcbLZt102VWt4iPqJsozqaFqsEFLIO82h0qHEEDNRUAhF
	 FcaP2DGLOjeycH3leuy7UzYFxKqG9KaPDAKuk/eCDkf3hiIQa2zJsCpbMaC6QZpdcw8lU
	 mvspI5Jc1CmbPrLIFMNS57HfhnAgBdL7QW2BRCHvG/KQn8uBpNpP3jyQqID5Zqc/jQMMy
	 gUg6/iGe5UNX7gj/a/uBHbLquTFyKWrE5qg3y24FjVWno3E5wMDC5fTjfWeabKJAMnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnC3Qo72;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9F606A32C;
	Mon, 16 Nov 2026 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnC3Qo72
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD481F000C4;
	Mon, 16 Nov 2026 00:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790173;
	bh=E0D8N8G+zEmku/06qMS2sDSDN9cKW5ShnuCBC1SI0dw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZnC3Qo72C6TkP5AGe79E48HTpmvVbpXRkqSXmp92Ww4GMlTPQwLAQkMzo3Z/VywZd
	 SEZRBNxjlaP/Ktg4pbbEQBCQATEXRKvnHFJfJ+4OwOB6x7PrgWKSapGyq4XFy5sjeX
	 I1tcYKbuT/7BM8bazqsQtd/bprMAH8f6JLRb+V8qUfVtkqli/NiRi5o+35aDw746OW
	 LoGfOAqoaNA5+taKR94ko9WeROPzcAQiDSU749B3QTNSe/Q1Ml5OGJj/Es7XoMtHjU
	 cYIbM03bVOZxh8hj27IczOlKPhdk/hbcP51gi2GvJ227hpt/jtdkqvPmnrxD7XNWGK
	 u/D+mSn1ZfOdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5D97CE0C39; Sun, 15 Nov 2026 16:49:33 -0800 (PST)
Date: Sun, 15 Nov 2026 16:49:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <jfern@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH for-v7.5 12/14] rcutorture: Enable RCU_BOOST where
 supported
Message-ID: <ea57ec3b-fcb0-4382-8327-3384b38e2747@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261113005747.2977123-13-jfern@kernel.org>
 <20261115233931.GC3906606@joelbox>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115233931.GC3906606@joelbox>

On Sun, Nov 15, 2026 at 06:39:31PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> Can I fold in the below diff?  Sashiko found this issue in [1]: with
> RCU_BOOST now enabled without RCU_EXPERT, its dependent options
> RCU_BOOST_DELAY and RCU_NOCB_CPU_CB_BOOST would prompt during "make oldconfig"
> for non-expert configurations.  The diff shows those prompts only with
> RCU_EXPERT; the defaults stay in effect.
> 
> [1] https://lore.kernel.org/all/sashiko-outbox-213970@kernel.org/

Good catch, and again, please do!

							Thanx, Paul

> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 2d0132e0a90f..a0c10750b792 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -249,7 +249,7 @@ config RCU_BOOST
>  
>  
>  config RCU_BOOST_DELAY
> -	int "Milliseconds to delay boosting after RCU grace-period start"
> +	int "Milliseconds to delay boosting after RCU grace-period start" if RCU_EXPERT
>  	range 0 3000
>  	depends on RCU_BOOST
>  	default 500
> @@ -325,7 +325,7 @@ config RCU_NOCB_CPU_DEFAULT_ALL
>  	  Say N here if you are unsure.
>  
>  config RCU_NOCB_CPU_CB_BOOST
> -	bool "Offload RCU callback from real-time kthread"
> +	bool "Offload RCU callback from real-time kthread" if RCU_EXPERT
>  	depends on RCU_NOCB_CPU && RCU_BOOST
>  	default y if PREEMPT_RT
>  	help
> 
> Thanks,
> Joel
> 
