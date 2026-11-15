Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785973;
	b=Cpg1N9XAyFNDMCfvjj4or6u4YC7/ZXe33ga5bIibC8frus3shp4tfeBgnSJdvFeX/326
	 thSri5G0iqykfzzw6HbWJMDKVMp4BBgrk0cumjcUJmnswdFtNw4DVDPcYTaQVIHqDbok0
	 2pXxU97jbjMWn1EHsdotMG4bGLiWiZA7ZojBOo/tR29p2S2ekFz7NqIZBNnroqHvVHKgn
	 /ZR8VqkXS9yhvfX2Lv42fb6UPElMcLXsWYpbmE5uAQydsUSby3TUJra77359PTvdPoqsG
	 8ZA3Gs6VFzlIt+YoxANVRLwWOg2rY4MhyOqfIxaDmQ1jqdspwHg05mhF+sqFvCD3Hxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785973;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TqNu7M+dUQ3EhUq2ckET0QYutuCBtT7VxLyNAsn36cw=;
	b=YZyMChfCK3F0O24c2JUCiBG8YVNeWNL91n5Nv6Suq0yXyvpYfMIXaiu2v06ROH2lT7Xd
	 kCWyItnDAdY7aj3c/OktjSa7d5sdyn/2zShtoVXAHvlxaqE5pO5dYEXnMFeAhH1Sx+miw
	 nBzvIVm4FZji4QAVuht7hatH2BzMskZqZJVrfASzypXvZI/ALuk2nGe/56C4FpJ9xfr8p
	 1w31aQPZY2J+kkyuMPR8ACaBEqCvIEbkO8vucXcvfF0JDZP/vaP9+ZUdltmAEISTcFvk4
	 Dd8shkwKYn+AzgPNOtmwTYVpacQRmmu3CNzqkeOMJTJSd1dyUMuhKFki1Uy7hGTji2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgRqg9bO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D2F9A606A31F;
	Sun, 15 Nov 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgRqg9bO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E80E81F000C4;
	Sun, 15 Nov 2026 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785973;
	bh=TqNu7M+dUQ3EhUq2ckET0QYutuCBtT7VxLyNAsn36cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgRqg9bOexODWBsqwil2KxvZNVENNDuC3ViUxLpBSJ7p5mXIQrPl/yPbsGHNrqkSi
	 Ektvxq6Q3KZohZsizyWXmelPWpdDktK6RIjFKvx2fkMFLEmEfVQU9ZA4tnEEzuWeWZ
	 GdpFalsIs/Nmo4QvoU7pkV8dYA8ZQYk/TN4+iCYtg9OQaK6vBk+VH8AQ9Nyk5DkGri
	 K7ffbJe3VI3KhivzvE4y/1WBs6Oyr0mTE8d++hoF+3DEv8ZMZx/GU0ZZYKH7w7BtwG
	 HwNrSnJ2fzGMNAq49kbqvN125pSQUZHshZs/OEoFFEbBN+B7WJP/co/mvp1/gA3OG9
	 hnBl6r7sxS8kw==
Date: Sun, 15 Nov 2026 18:39:31 -0500
From: Joel Fernandes <jfern@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20261115233931.GC3906606@joelbox>
References: <20261113005747.2977123-13-jfern@kernel.org>
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
In-Reply-To: <20261113005747.2977123-13-jfern@kernel.org>

Hi Paul,

Can I fold in the below diff?  Sashiko found this issue in [1]: with
RCU_BOOST now enabled without RCU_EXPERT, its dependent options
RCU_BOOST_DELAY and RCU_NOCB_CPU_CB_BOOST would prompt during "make oldconfig"
for non-expert configurations.  The diff shows those prompts only with
RCU_EXPERT; the defaults stay in effect.

[1] https://lore.kernel.org/all/sashiko-outbox-213970@kernel.org/

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 2d0132e0a90f..a0c10750b792 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -249,7 +249,7 @@ config RCU_BOOST
 
 
 config RCU_BOOST_DELAY
-	int "Milliseconds to delay boosting after RCU grace-period start"
+	int "Milliseconds to delay boosting after RCU grace-period start" if RCU_EXPERT
 	range 0 3000
 	depends on RCU_BOOST
 	default 500
@@ -325,7 +325,7 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	  Say N here if you are unsure.
 
 config RCU_NOCB_CPU_CB_BOOST
-	bool "Offload RCU callback from real-time kthread"
+	bool "Offload RCU callback from real-time kthread" if RCU_EXPERT
 	depends on RCU_NOCB_CPU && RCU_BOOST
 	default y if PREEMPT_RT
 	help

Thanks,
Joel

