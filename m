Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E047318BAB
	for <rcu@vger.kernel.org>; Sun, 11 Jan 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133320; cv=none; b=aeZ2QdUq0aurU1fBf99zrP0ckag6HTA3AlUffkw5pydBxhqC9bIcgWjq7NjI+IuCXxh7LIK2v55txyCzuW3UE9ICmlPy10oDXlTy3V43qMJ2B1B8ebSM1evFAS4lI3/BoJjEiVCLIcaAXX46dGGiwhuHfd85pO5kCl/nFLB+E2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133320; c=relaxed/simple;
	bh=us3GSBuy3HqBoT/l52eEBR4/3xZVpqJk/QeAH5S5vn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcLTdWlWVW4ssDTaT8J19hl8KcBfHN6XO+79k9NMCpd70rK+rQvfHewA3CSLGffRH9tVhLKdM/aBN8aT6KtKcyUDS/zXujiH3DEvRsWjzfh3S3Rr/0Tub3R3ufxduAmOi95+XZcOXV5TRTxfnmoKHRB2WtjwYDhNkYxDldrGAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i99l2aqG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i99l2aqG"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b31a665ba5so682557385a.2
        for <rcu@vger.kernel.org>; Sun, 11 Jan 2026 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768133318; x=1768738118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hmHP2gC8213i+BGrPk3oVR1Bmw8GpK3bfdc7SOSlmRs=;
        b=i99l2aqGgkIZMZ163RbXChpElg0jtgeWJ+d2kwTifbZwhsn4dUHQUomclicPfUn4gI
         NiSPWmBSCD43TGhUr14D+iNbc7xSXI/WvULQhMgiztn8t1O+/mJlofiTG17eB380VVG+
         xQnDNOGcdstkpVhA0NBSDAQMVaX1cf2x7TEu9rOghrXocoAkkeJD4ASagwzrUzfbffX/
         YuevtoJYZEupJUuhznHL6Del//aXcsTuAG43LacCrUZntEu87cnQzgVdx7PMJCzyYL4T
         BtqSiV7KkY3zVVNaWLYPHCkDx9jv1BatlVoxIGLqLm4mmGmWuJ0FbBPsEv6ugmkZ6dqb
         MQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768133318; x=1768738118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmHP2gC8213i+BGrPk3oVR1Bmw8GpK3bfdc7SOSlmRs=;
        b=W3+513/RsIwf/Zwkae0Dhf1I1eJ9c/EYqXomaW0Aw32kFHeHJQinjXm4tPOklkHy5v
         p62IvA64yzl16zQyrWrLq7VvnpCPZOzYGuNbMirhrAmbLxdR54kiTQZeb8ecvvB7Qby9
         jiOC6mwuMgWOXUuWVFNwaCyRc7JWmhNi1ZLzAH1dgS5G/YesapiIFbuv2k2mcgB0RDyE
         a/WH9/FySUCWVPiSmpIjVO9Jy/1Uerk8x/YW8I+vafPYkgg5yYYBtsoRzhbftmybGhMY
         WkLtSDQvj0tlP20qh7qaTsDkBPPGa3f+9Lq7c0NjxRWDq78Xu9ZZO9yAXnryXfNV1drO
         40YA==
X-Forwarded-Encrypted: i=1; AJvYcCVEUHtD1xyKH3qJRAQXxmGJp2e4eq5ffFl+qW+K/i0Tyaj9dygcYunztah/bBhAvP68GWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6LjCT26Oiken1Twy6JkvfufvJBNjZjFcB0nqjMsDn55IWpQd
	qs/G6qS7dgE+BFlEPLfhRVAGcrbs1hnYQMvujPXOqMTFPM9Ca2SWXWI0
X-Gm-Gg: AY/fxX6Z/7iCm41wOmMkWGFRJajRmSRnJAtkeSoqhMSTH7koBmrblNUn83OphxDEYTO
	rpVwuM/0iS3i52LWj3ZWDGv5jlAw1EARRdFmaypiUVieA9+R93mJdraTrfkDMUr01uJHj1b4xRi
	x03X04lRCBSZFuy0bmVvp4bJCPFl9S0SvzR9h9PP9MMGFOJODBYO8EFn/MaB2f1VLRPQYgZ7g+q
	lA+uh5n8ClJa8M8Q9vPe5jiD+7qZJSr/6vUEdUufI0wc03+PpckWgk6rZSYrV8EL/Z6OsWrC11V
	qUOTCCwP+C+9iSuSwLgfiHdOo35TwE4w4jcpYSUgAcsHZ5qO7b3q5GuJdEPDMh6Nnt6SQgCDYCz
	ZYrzI5e3fU+q3RNFWaJE9z6RQzHyvxboTOy6Cmjo2PLnKNmfhEMvmdjbFsplWLQgKKaf8eIEVvh
	mVtIm2hfKxrllUjBwvmhGzAaojfN/1Z7TUpaS0WzdvqEck5C2yww3JckOWMdU/VEherYRLM1VjB
	sPlFJzXGEhKTmE=
X-Google-Smtp-Source: AGHT+IEWRF7KbRkkZo6wQPbtDmrRBCm2+8Sb9KflgUURh0G7kPj+yCSZH02xC0gVmVBLqHquvvK+gw==
X-Received: by 2002:a05:620a:2684:b0:8b2:eefb:c8a6 with SMTP id af79cd13be357-8c38941bf00mr2026534185a.88.1768133317880;
        Sun, 11 Jan 2026 04:08:37 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51ba4bsm1283231285a.34.2026.01.11.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 04:08:37 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 00631F40068;
	Sun, 11 Jan 2026 07:08:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 11 Jan 2026 07:08:37 -0500
X-ME-Sender: <xms:xJJjaRzSFnkwlsJTskO68BdyuuOyODKClQlbcKK-qiNEZsAFzg_8Qg>
    <xme:xJJjaRsR9zwQ0A6ZCQTiXE7wtXJoxCK5ad36k-8Z8VOwSXIeLswZEWpyRSaWQu2XF
    SfGYNokJVwkwwvnXSJyB9mi5YlvZN26WDh5JT_cJSU4JjQTmpmHhSU>
X-ME-Received: <xmr:xJJjabH6V36WxkbEqYoC-p6pzmQoFfG32XW0TszmItHeJGiCH7Xo_8_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefhgfeg
    leefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepshgrmhhirheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehjoh
    gvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpth
    htohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xJJjaf6SbsaJ-vBWwMMEpXfEP94V_bIdqmLZqiMYeM7uSNVZYJvwBQ>
    <xmx:xJJjaczU97Ud4tK4iw2rjt2XYD3ccErvwIqLSh8H0dOJVhkRgaSTgg>
    <xmx:xJJjaV1CeOt0ZYh4L7vexGmtrf0AwBKAVmCMOSc7noWpjVioC0a-OQ>
    <xmx:xJJjaX5X4TWDg3AriODvaDRC2psZxr5pSWXQTdVS8tuV4Gw1DPFERQ>
    <xmx:xJJjabayOzFiXwCNmHusg2RHT79ToUasE0L8_p23Ta--0rRUjjyxs8pj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 07:08:36 -0500 (EST)
Date: Sun, 11 Jan 2026 20:08:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Samir M <samir@linux.ibm.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, vishalc@linux.ibm.com
Subject: Re: [PATCH v3] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Message-ID: <aWOSwpiiTkduVk-E@tardis-2.local>
References: <20251230004124.438070-1-joelagnelf@nvidia.com>
 <02d29108-e145-4513-a378-e2dc353b1ef3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02d29108-e145-4513-a378-e2dc353b1ef3@linux.ibm.com>

On Sun, Jan 11, 2026 at 03:42:36PM +0530, Samir M wrote:
> 
> On 30/12/25 6:11 am, Joel Fernandes wrote:
> > The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
> > State) design where the first FQS saves dyntick-idle snapshots and
> > the second FQS compares them. This results in long and unnecessary latency
> > for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with
> > 1000HZ) whenever one FQS wait sufficed.
> > 
> > Some investigations showed that the GP kthread's CPU is the holdout CPU
> > a lot of times after the first FQS as - it cannot be detected as "idle"
> > because it's actively running the FQS scan in the GP kthread.
> > 
> > Therefore, at the end of rcu_gp_init(), immediately report a quiescent
> > state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). The
> > GP kthread cannot be in an RCU read-side critical section while running
> > GP initialization, so this is safe and results in significant latency
> > improvements.
> > 
> > I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
> > showing significant latency improvements (default settings for fqs jiffies):
> > 
> > Baseline (without fix):
> > | Run | Mean      | Min      | Max       |
> > |-----|-----------|----------|-----------|
> > | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
> > | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
> > | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
> > | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
> > | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
> > | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
> > | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
> > | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
> > | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
> > | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
> > 
> > With fix:
> > | Run | Mean     | Min      | Max       |
> > |-----|----------|----------|-----------|
> > | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
> > | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
> > | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
> > | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
> > | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
> > | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
> > | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
> > | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
> > | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
> > | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
> > 
> > Summary:
> > - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
> > - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
> > 
> > Additional bridge setup/teardown testing by Uladzislau Rezki on x86_64
> > with 64 CPUs (100 iterations of bridge add/configure/delete):
> > 
> >                                 real time
> > 1 - default:                   24.221s
> > 2 - this patch:                20.754s  (14% faster)
> > 3 - this patch + wake_from_gp: 15.895s  (34% faster)
> > 4 - wake_from_gp only:         18.947s  (22% faster)
> > 
> > Per-synchronize_rcu() latency (in usec):
> >                1         2         3       4
> > median: 37249.5   31540.5   15765   22480
> > min:    7881      7918      9803    7857
> > max:    63651     55639     31861   32040
> > 
> > This patch combined with rcu_normal_wake_from_gp reduces bridge
> > setup/teardown time from 24 seconds to 16 seconds.
> > 
> > Tested rcutorture TREE and SRCU configurations.
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >   kernel/rcu/tree.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 78c045a5ef03..b7c818cabe44 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -160,6 +160,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
> >   			      unsigned long gps, unsigned long flags);
> >   static void invoke_rcu_core(void);
> >   static void rcu_report_exp_rdp(struct rcu_data *rdp);
> > +static void rcu_report_qs_rdp(struct rcu_data *rdp);
> >   static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
> >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
> >   static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
> > @@ -1983,6 +1984,17 @@ static noinline_for_stack bool rcu_gp_init(void)
> >   	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >   		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > +	/*
> > +	 * Immediately report QS for the GP kthread's CPU. The GP kthread
> > +	 * cannot be in an RCU read-side critical section while running
> > +	 * the FQS scan. This eliminates the need for a second FQS wait
> > +	 * when all CPUs are idle.
> > +	 */
> > +	preempt_disable();
> > +	rcu_qs();
> > +	rcu_report_qs_rdp(this_cpu_ptr(&rcu_data));
> > +	preempt_enable();
> > +
> >   	return true;
> >   }
> 
> Hi,
> 
> 
> I verified this patch on ppc64 systems and observed consistent performance
> improvements.
> 
> The testing was conducted on Power LPARs using 20 cores (160 CPUs) with SMT
> enabled and disabled. All tests were performed on the latest upstream kernel
> (v6.19.0-rc3+), and the patch showed measurable improvements in both SMT
> configurations.
> 
> SMT Mode   |      With Patch (s)    |    Without Patch (s)  | Improvement
> (%)
> ————————————————————————————————————
> SMT ON.      |    51.662               |      75.540  |       31.61% faster
> SMT OFF      |    44.246               |      59.933  |       26.18% faster
> 
> Please add below tag:  Tested-by: Samir M <samir@linux.ibm.com>
> 

Applied, thanks!

Regards,
Boqun

> Thanks,
> Samir
> 
> 
