Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533689;
	b=jHOAIxf2H7h93Mh4R5liuIbeDgLkRqDVSIW9h9KMss7iXnsbhi9CiiU81IYzvI/H513A
	 kNjzvoScOcHcmzH/4kuLDR3k8A24I3jLrJGNpt05dqlKRxLWK3rLufrzAsczausyEjN5w
	 C77nUjpPywh7I04MI68y9Yr/r15uPkl2gurm1rwTimFhA6KVDq3PzgaKYvNO1j6IhS5Ij
	 2DSch+OWNr3DcjIgPWgWju2U5bZ6Y60wjUthP65AyYNjCGsqiFERUMwo808TYM9CfczdK
	 WvVh3pvkwCougWjKCIHmWXEK5Uz2dkQBvsSOFvOZ66TgH1ekUkLcMoCpVc640dehQYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533689;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+s7mApPWhnCndpKXgIn4mXsefprJUJU44SU83Gpede8=;
	b=Q9AZ07H2YwbIV8kai+NEO95Z1/KPquCK1UVkwQFfXnjjfwITHgWj16s8pENKjBQG6aVX
	 H2wazocGh9ngy6TYLuze8Hk3tNcCkEEHb59WGLAV8L1gUhUTU8mFd7ahUAUK0gffnE5VH
	 IVLSwhSI1nsiHErFfYUfn3semxAvbnLvSm35GBcRmHlfLcJ3ebh164OQYDP/nzmfqTXhC
	 LzDVCmNTpurej7uyeokkfEVK0tMaT1NDahgvKbxmHPX+8fcNJWqntTN8XhrTqgc6DzDxW
	 v0FG686qlnHdWopo09vMMMlZWpZHvEew1ZmLEQvfM2efQlFePaUqElg8UFHMEgRc+yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBPc2rfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE984606A319;
	Tue, 20 Oct 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBPc2rfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479681F000C9;
	Tue, 20 Oct 2026 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533688;
	bh=+s7mApPWhnCndpKXgIn4mXsefprJUJU44SU83Gpede8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=OBPc2rfCUYQo2WlidII7rOpSBA/vWlQ0h7Ab+lek8cBRt4R35V30o6FYvUffF+yvh
	 yfM+NkCCdGexvpHeP9W61QAa/w5Uq6CsP8ScbjOaLFqJHmcRGU9luzYUjMATk+XzO1
	 PRavIlFZ8DSYQzTyC8qcEdKpuBZ4Ppg9m3GDVaSgT2siIMnp/ukD+ufuRxrcUQ+gYZ
	 tLHApBymEQrMHzCAHvhUk1oPx/k8DpzP9L8K9Rm3w/GQ2D7fKdz06/1MHWYr+fKdIU
	 NXDRkCB4Qb/7lWYthieD2HRyqUASgouJJkhH8/INqz0DN2x+mRtjOuo1RQJQ/uWrzK
	 ux3bs0R4xMaKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7599CE09E8; Tue, 20 Oct 2026 15:01:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:01:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: qiang.zhang@linux.dev, boqun@kernel.org, frederic@kernel.org,
	joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcutorture: Fix suspicious rcu_dereference_check() usage
 for trivial-preempt
Message-ID: <3280ed4e-2fc0-4eef-b6b9-234bf4acce58@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261020094907.15781-1-qiang.zhang@linux.dev>
 <BD9E8AED-23DC-4A7E-86E9-297B8FE29846@mainlining.org>
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
In-Reply-To: <BD9E8AED-23DC-4A7E-86E9-297B8FE29846@mainlining.org>

On Tue, Oct 20, 2026 at 04:06:49PM +0100, Bradley Morgan wrote:
> On 20 October 2026 10:49:07 BST, Zqiang <qiang.zhang@linux.dev> wrote:
> >Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
> >usage" warning from rcu_torture_one_read_start():
> >
> >WARNING: suspicious RCU usage
> >kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
> >...
> >lockdep_rcu_suspicious
> >rcu_torture_one_read_start
> >rcu_torture_one_read
> >rcu_torture_reader
> >
> >The trivial-preempt flavor .readlock_held is set to
> >torture_readlock_not_held(),
> >which check RCU-bh/RCU-sched critical sections. however, it's read lock
> >just increments current->rcu_trivial_preempt_nesting, it's not also RCU
> >read critical sections. the rcu_dereference_check() condition is therefore
> >false, and lockdep report warnings. this commit therefore drop
> >.readlock_held
> >callback to avoid this lockdep warnings.
> >
> >Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")
> 
> Looks ok to me.
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> 
> >Signed-off-by: Zqiang <qiang.zhang@linux.dev>

And it works here, thank you both.  I have queued this, and thank you
Zqiang for thinking to test trivial-preempt with lockdep enabled!

							Thanx, Paul

> >---
> > kernel/rcu/rcutorture.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >index 92ff197f4789..1bbf8192786a 100644
> >--- a/kernel/rcu/rcutorture.c
> >+++ b/kernel/rcu/rcutorture.c
> >@@ -1164,7 +1164,6 @@ static struct rcu_torture_ops trivial_preempt_ops = {
> > 	.readlock	= rcu_torture_read_lock_trivial_preempt,
> > 	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
> > 	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
> >-	.readlock_held	= torture_readlock_not_held,
> > 	.get_gp_seq	= rcu_no_completed,
> > 	.sync		= synchronize_rcu_trivial_preempt,
> > 	.exp_sync	= synchronize_rcu_trivial_preempt,
> >
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds
