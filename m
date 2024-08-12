Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C516CD08;
	Mon, 12 Aug 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461238; cv=none; b=aFUOLFJEk06bhi0LIm4lKdLSleW6Fa+EnFbEUM7oFh1ErHpdJ2CvW6/bVMz2fw9l/kt0QYZPOb7PS6426LXif4QasEyHQ28sB8ZCpxy0poaoI7GYfzuw3DodSvezBs1qh/UYy8NNnMCz1Gx6RjKS6h0+yKjIz4dUgEkK8K15G7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461238; c=relaxed/simple;
	bh=ZJVcMsZ+9XIIYs9Wp/RvwLQ8tTBR0KO2oTkBhcPhit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je798hJRy7a99BNnsnFt3zLpd+whEajM3JH5pJcr40h/bhpjeXga0hTto7PAqYWRkpQBzxn3Ik0O8F/V8sX/toFybsueBn3BrAy6VkamOwA3S1pDdLcDDolhdc5e3AThicOo384LM+sVnWGqxttqojJs8XXDLbiA3ES5rMXhoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQBEatZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQBEatZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E3FC32782;
	Mon, 12 Aug 2024 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723461237;
	bh=ZJVcMsZ+9XIIYs9Wp/RvwLQ8tTBR0KO2oTkBhcPhit8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQBEatZRD/h9p5VNDNIjdYneQ6jvxI8t1wiqPId0SSpWZm3nZCNJuWqlBCMz1Q7mK
	 HOAsfRYoUOom2aaA9wK9ptoYvefJ1VaebZgEkuRr/uJigfg80/QRiZDzwndTip9Djb
	 nRUoDUCsBIIbmUcDaWPrlK7ACc8iclGlRgrq+i2PCk305mHlZ8lvVC2C3DZkMRqKt1
	 7aXRkXmphq1B5UeiFjfYF2o13ELS0ODxCGO1+P/hbAKfKX3EOyk73gsl25Ygq07PgP
	 LTdPQShs6EuXA6Yi83Xd0I9IPreOhE+fyZ/i7ZovREOxFpkb7aVruTytOHFo6ugLfF
	 KxT84KQCqO/3g==
Date: Mon, 12 Aug 2024 13:13:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>
Cc: "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"neeraj.upadhyay@amd.com" <neeraj.upadhyay@amd.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZrnuctZQS4DTSb0q@localhost.localdomain>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>
 <ZYMElDsPLTJDdco3@localhost.localdomain>
 <65b6b97a6f61f80c5f1ea1f245eea392a0de5523.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65b6b97a6f61f80c5f1ea1f245eea392a0de5523.camel@mediatek.com>

Le Mon, Aug 12, 2024 at 09:10:56AM +0000, Cheng-Jui Wang (王正睿) a écrit :
> On Wed, 2023-12-20 at 16:13 +0100, Frederic Weisbecker wrote:
> > Le Wed, Dec 20, 2023 at 04:24:35PM +0800, Z qiang a écrit :
> > > > 
> > > 
> > > In the rcutree_report_cpu_dead(), the rcuog kthreads may also be
> > > wakeup in
> > > do_nocb_deferred_wakeup(), if the rcuog kthreads is rt-fifo and
> > > wakeup happen,
> > > the rt_period_active is set 1 and enqueue hrtimer to offline CPU in
> > > do_start_rt_bandwidth(),
> > > after that, we invoke swake_up_one_online() send ipi to online CPU,
> > > due to the
> > > rt_period_active is 1, the rt-bandwith hrtimer will not enqueue to
> > > online CPU.
> > > any thoughts?
> > 
> > Duh, you're right, that one too. How many more? This hrtimer
> > situation is scary...
> > 
> > Thanks.
> 
> I encountered the issue pointed out by Z Qiang on kernel-6.6, which
> cause RT tasks on the CPU to never be scheduled, leading to a system
> reboot. It triggered the WARN_ON_ONCE(!base->cpu_base->online)
> introduced in [PATCH 1/3]. Below is the call trace:
> 
>  Call trace:
>   enqueue_hrtimer+0x7c/0xf8
>   hrtimer_start_range_ns+0x2b8/0x300
>   enqueue_task_rt+0x298/0x3f0
>   enqueue_task+0x94/0x188
>   ttwu_do_activate+0xb4/0x27c
>   try_to_wake_up+0x2d8/0x79c
>   wake_up_process+0x18/0x28
>   __wake_nocb_gp+0x80/0x1a0
>   do_nocb_deferred_wakeup_common+0x3c/0xcc
>   rcu_report_dead+0x68/0x1ac
>   cpuhp_report_idle_dead+0x48/0x9c
>   do_idle+0x288/0x294
>   cpu_startup_entry+0x34/0x3c
>   secondary_start_kernel+0x138/0x158

This means you are setting rcuo kthreads as real time
tasks. I would be curious about your usecase.

Anyway I'm working on a fix. Thanks!
