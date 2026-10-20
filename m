Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533808;
	b=X3tia4vdrXrEewVlQiHVjiBBUNGEOMKRBPU+vfhHb3uDtjWNDVPh3UCt+Y/qo+ALASJq
	 vSSAbFtHaGBjJTdhurQ2e7KoM6Vzj5bhFgN+lK/yKTQdRi2UngHZoqhsdghmGC7uHsF83
	 b18ksso6ibws5Kd+cKT3S5gTYEGcyn3mAQwwG5xneAVVRArq+zTI2m/K7PModev3YziH7
	 XUg0utApLQG1yXE34UrPk9gjVhL3yi3btXq94YDuDNEHErzn9LuAeEF0VelQdy2VDxcnZ
	 GG0AYcP7dzA0DbutfS2Hx4HSUDC9qw/CzDCeqv619cW8SPqm6CJ0bq+Hgucqq8wXDNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533808;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=sZ/cbaTyrmN3VYl0iRHv+YflIXV8m5aVuOkAxOkqlWc=;
	b=gA8MnXdyZl9QpkSQn9yFSDEeQ6h0VPl+yC9sVXumGur0jFBH6G+FAIBUbZD2jTw5p+mo
	 Ti3WzsTCwlG+9mfEm/+Ed0CIKqZRt6tKMCe2yUdRSXHU5RwykBuUSwRLfok+xxNl+HNId
	 xxRGNc9vcZcb19jmnJfP8erz+y7Uanffks/K7YJlQy4fJpaWWe0dDwucKAEX/lLGZ5T4N
	 6XQBnYK2VSOL0aQ4vXb1NUVZunXa7BpJX/wCUCauMN7ug2rFXbIL1VosVV+sORyJ02w3v
	 Ws2KCNnvt7mopkPHeVXUSb+SZCL068eqEmbg9YNL9EwjflJG1KXVhu71lzu7hipsmDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnIeYpm9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13D606A319;
	Tue, 20 Oct 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnIeYpm9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42BD1F000C9;
	Tue, 20 Oct 2026 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533807;
	bh=sZ/cbaTyrmN3VYl0iRHv+YflIXV8m5aVuOkAxOkqlWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=nnIeYpm90AYQhMQIYaAYHuR08HspSocDh7ywsjU8iN8pbHZfMSbVGM3QYoYbhdrfM
	 svZ9p/WB/dWBL8WVSaoE5gmjkQSP8cHgmmNXyv+6AzEcbFvNxOGR7ptrJMWzuXyylM
	 /GLw5EDJjfNI+X8eeFkIenQu+h3n+HW9ATMt4aMa5k/dOtqcOtHiXDcwgE3PCuzmwg
	 C9UVTCJOO+lbWdKBS9tVRQfF4dU9lPeXZzpqWAw265/FWKWr0JBLWCaLw1ApjZLTK8
	 ZoxqjQEAN3B1S8HQe+pTuSpkhnWkPhXrejBek7lEXZ7Lc+CVQtFDzv/BVkcchO61gt
	 /Tt/91dpKBd4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81C59CE09E8; Tue, 20 Oct 2026 15:03:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:03:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: qiang.zhang@linux.dev, boqun@kernel.org, frederic@kernel.org,
	joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcutorture: Fix suspicious rcu_dereference_check() usage
 for trivial-preempt
Message-ID: <37881d14-7efe-4e03-8a92-6bd80c82b52f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261020094907.15781-1-qiang.zhang@linux.dev>
 <BD9E8AED-23DC-4A7E-86E9-297B8FE29846@mainlining.org>
 <3280ed4e-2fc0-4eef-b6b9-234bf4acce58@paulmck-laptop>
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
In-Reply-To: <3280ed4e-2fc0-4eef-b6b9-234bf4acce58@paulmck-laptop>

On Tue, Oct 20, 2026 at 03:01:27PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 20, 2026 at 04:06:49PM +0100, Bradley Morgan wrote:
> > On 20 October 2026 10:49:07 BST, Zqiang <qiang.zhang@linux.dev> wrote:
> > >Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
> > >usage" warning from rcu_torture_one_read_start():
> > >
> > >WARNING: suspicious RCU usage
> > >kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
> > >...
> > >lockdep_rcu_suspicious
> > >rcu_torture_one_read_start
> > >rcu_torture_one_read
> > >rcu_torture_reader
> > >
> > >The trivial-preempt flavor .readlock_held is set to
> > >torture_readlock_not_held(),
> > >which check RCU-bh/RCU-sched critical sections. however, it's read lock
> > >just increments current->rcu_trivial_preempt_nesting, it's not also RCU
> > >read critical sections. the rcu_dereference_check() condition is therefore
> > >false, and lockdep report warnings. this commit therefore drop
> > >.readlock_held
> > >callback to avoid this lockdep warnings.
> > >
> > >Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")
> > 
> > Looks ok to me.
> > 
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > 
> > >Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> And it works here, thank you both.  I have queued this, and thank you
> Zqiang for thinking to test trivial-preempt with lockdep enabled!

Wait, Joel is doing the next merge window, not me!

Joel, please make that be:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>

I will drop it from my tree, apologies for my confusion!

							Thanx, Paul

> > >---
> > > kernel/rcu/rcutorture.c | 1 -
> > > 1 file changed, 1 deletion(-)
> > >
> > >diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > >index 92ff197f4789..1bbf8192786a 100644
> > >--- a/kernel/rcu/rcutorture.c
> > >+++ b/kernel/rcu/rcutorture.c
> > >@@ -1164,7 +1164,6 @@ static struct rcu_torture_ops trivial_preempt_ops = {
> > > 	.readlock	= rcu_torture_read_lock_trivial_preempt,
> > > 	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
> > > 	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
> > >-	.readlock_held	= torture_readlock_not_held,
> > > 	.get_gp_seq	= rcu_no_completed,
> > > 	.sync		= synchronize_rcu_trivial_preempt,
> > > 	.exp_sync	= synchronize_rcu_trivial_preempt,
> > >
> > 
> > --- Thanks!
> > "I'm not a very positive person" - Linus torvalds
