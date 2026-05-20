Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17323DCD8E;
	Wed, 20 May 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278648; cv=none; b=R6IQmiOv7XPQi8bcRKDwhG5bzxfaKbtGM4JVrORqu0PRY1S8wyLWEsMwPf7LJ/Phtzd1DZouPa7KtUqiejuMBNSNF7W17ACYlJPSTU9jCkAa7lygcLMSbYRqvNh/uCncnqJ5seJH23pnusfwuvE1a+vdI2uh8phggUXAaKjdZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278648; c=relaxed/simple;
	bh=Z6sME0NwFKz1eNF7NsRxV4p5tX5/KLargxC6QvFeK10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf5R2joHCNADf+UZkXbNGUGPSY3lANNMiE1FrOjKU6hhGaLAATt4ZrjUcQGRplpjD9JxHKp2JY9P8yWpfTBSiCKQH9G3ikhhmSpkiqmA/qYBxQpqMVcwaIyXgF7HFIBXeMTtt3qlV6F/qLyJEjDpCnMTWKo1W+dAMChGTSHGYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgYlc5nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgYlc5nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3641F1F000E9;
	Wed, 20 May 2026 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278646;
	bh=045ed/tgbddVZ+28k+FWptvH7MWJKziH2bMgI9nNs98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgYlc5nhM0n5R7OCl7YCJEZI0x6ZJFqRPFhnVYqkrdY8BQkA1eV9yoLo7Qp96mSYV
	 y5JUqMXVw1XECCvEMVEt5rMwiovft1OXMUt2UcOc06SNSBuSCJY3fhVP3/H5+/J0eA
	 ZIK3BSZVZq/gxjssxnqqNhetydizgZAHWzyTJGwIBSmrJ84AhT3yMqsfeiwE0Frd3N
	 YNjD+RCzStGDOVB+a95SAK+sNKN9E+XEaIcsyoAbVDjvnvn3Q4q0F+dAM8ZLCM6XsW
	 qhYch7zBwY8MdHxsjXHxw06wPIYIC6nNjtNSQbnF/uIWiK2n62IIRww8iLAy3xONOw
	 8p0EAdHLZzG/Q==
Date: Wed, 20 May 2026 14:04:01 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Ingo Molnar <mingo@kernel.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: reduce stack usage in nocb_gp_wait()
Message-ID: <ag2jMYwauyQPODdk@localhost.localdomain>
References: <20260519190447.1716375-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519190447.1716375-1-arnd@kernel.org>

Le Tue, May 19, 2026 at 09:01:28PM +0200, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_UBSAN_ALIGNMENT is enabled, the stack usage of nocb_gp_wait()
> grows above typical warning limits:
> 
> In file included from kernel/rcu/tree.c:4930:
> kernel/rcu/tree_nocb.h: In function 'rcu_nocb_gp_kthread':
> kernel/rcu/tree_nocb.h:866:1: error: the frame size of 1968 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Apparently, the problem is passing rcu_data from a 'void *' pointer,
> which gcc assumes may be misaligned. When the function is not inlined
> into rcu_nocb_gp_kthread(), that is no longer visible to gcc.
> 
> Add a 'noinline_for_stack' annotation that leads to skipping a lot of
> the alignment sanitizer checks and keeps the stack usage 60% lower here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1047b30cd46b..373b877cf171 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -655,7 +655,7 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
>   */
> -static void nocb_gp_wait(struct rcu_data *my_rdp)
> +static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)

This probably deserve a comment though.

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  {
>  	bool bypass = false;
>  	int __maybe_unused cpu = my_rdp->cpu;
> -- 
> 2.39.5
> 

-- 
Frederic Weisbecker
SUSE Labs
