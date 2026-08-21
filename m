Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26D370AE1
	for <rcu@vger.kernel.org>; Fri, 21 Aug 2026 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282554; cv=none; b=utUt4QqpnThcRtZHScBZLh73KG8033hSCkQFcNCITRPFLRNP9XHyzhKD9isF6tu2O2xkf4m66qmI7UGdulDpoPc3P5Z2WN9onFlHVcQTv4AxM1lr9GFEKNOYj/q7ea59PI2MqMXA7kfkH/8fOmzYkDTBgDBuJ33mkXLFeoQEp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282554; c=relaxed/simple;
	bh=tgJloRfeeS7oreM0fNCdGrfk46K+Jnqydc5/4HZLxeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rw/3nLZai0jcIG4rFqeMuDrO9fFLjtQdKWKhH/QxB30qQnizX1bqN6YzYR5Lj/sZECMT8G8SYatOlaTVks3jtGaDXUn8yzfoQ88P0ZqCbZGQh1Nq0a/xELGVtBnPo8ryFJ7OwH2bUquVmMousHHaFAX16GdijONB1ifcBdC8Rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4rauOCI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4rauOCI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso538411a91.3
        for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282552; x=1787887352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FArwaMZX2eiWKPnzPqfz9Xd0f0Z/D0qbA/uRrn33MqI=;
        b=c4rauOCIFS/tmqVNgQm2KaFQzQ3+c6AD6SN1o+glZMD+MaVnw1Aq1t/PwmzMTY/oUV
         gyo6wilsGwdRP5eVhvdbMMfH2OXmLoPpiOUrZXIydk9WPP9Khni41/TBEhbyihF7rBe6
         IX/qdedwN6d5H6WU62i7CHKLnogyxl2jaOp7WtyCzFX/31VXrIJQrwEnUoEtXhTye2eA
         A0a6MGu32r7HPxa3rzlBYhu11Do81khQ0DN5e+E+gB+Bxg3xZjPGY+26lZEjsju7Z9b8
         YJPnHnulg5bfs1Jifi1puRPU0OV1AfCV76ZAkwzGXD/jkHQOk48p/PZe2SdJ5cDjgC0E
         nLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282552; x=1787887352;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FArwaMZX2eiWKPnzPqfz9Xd0f0Z/D0qbA/uRrn33MqI=;
        b=irlm6v49CUL145bHMCweni/eeQSM4DW2EX6xWMAHvI029NHiHDSyEJyFaNeEuWZkif
         RL0hV7TYuPCN5X6w8FGA6t+v+Q6ahw/BxaCpFndXPJsgoE37vQawU9BtMlCKAPDiH4ZZ
         aDKtmpBh563zSnxH0VeUiG0Xd3Md89Tu7iYz45NPmPapFOLnLuXpuiG6Hkz4YYzWRrns
         AseJk26eCxhEKo02DxVIXF+cP2nM1ZrWz2SyoIEME9rA6kEEzZx5SKOnByBFBHH8MSHB
         e9afP+ipf7fCVSgyBEpW3gdWNoJJUnFgrp77utLYZsP4nuMQUkoBVohTFuSReAiJXJgC
         frGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrro5q6FoLSYpNLnbrhJvoTRMCOAK722UvFez0sFCqzz5gc7kCDICoNogg3GQJeiIGbAiM=@vger.kernel.org
X-Gm-Message-State: AFuF++lY5jfxhtg3q4OxBZ5KROsTZW7Kr4verocyt7WTO7V8MOk2Beq/
	H3UPuJs8izr0GyL6HrZqoh4dKqeWl74fN1wTis8/sZKe+7pL+HdG0V84
X-Gm-Gg: AR+sD11ghIr9yKYrMEVKlkXwuYqzbDbSKCgSrnmUAoS+B58IeKS3OoT1ZyN6AYDt66t
	aMH4DOIuULEXKeUcXWkCeXLdn8kUOFb1lHxwjiTtX2E/ksFSAJQ2kMgmB7nru89x5fPejrwhzXf
	Wk3Xy/hcb3tPW7+HJ/05utbMt469aD7SECRvfaocO4lHcN2fAvUj+pmBaGHfJ7rK0LrEj4POlvy
	o/9BXDo/Z/sBC++hifdDZd3kl432RT2cwG7yAtosQSOnvPTGe4AZn4ncXsAAMOR8pyprhIZpm5+
	aRYHI2I4rwSFTGtLuw6K1xJ63NtWq7UGjuNq8Tu4ZoSunrW/60Ghewt1Y1qOS1UQYZfv4+MaVAD
	uvzCIZQ/v3Ymg0D+lO5EB/p0+r+SlgJilUQuoVF/LNNkte6/Mhy/nJJgZS58DVF6lAQvlJkLFSO
	j+InZwi4r/lSuriLSLaehMJvftgiKWsImS+902A6Miq6Rcjitorv0k4Z+wWjpC3eTQ11QcUl1NP
	7fI3zo=
X-Received: by 2002:a17:90b:4484:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-395c3552988mr4946396a91.14.1787282546673;
        Thu, 20 Aug 2026 20:22:26 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm1199574a91.3.2026.08.20.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:22:26 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sean Christopherson <seanjc@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	rcu@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can prove readers absent
Date: Fri, 21 Aug 2026 11:22:05 +0800
Message-ID: <20260821032210.792451-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0f4dea21bac43685d3286df329401177e4452b36.camel@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi David,

Thanks for the patch.

On Wed, 12 Aug 2026 13:32:48 +0100 David Woodhouse <dwmw2@infradead.org> wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> For a dedicated srcu_struct whose read-side critical sections are
> short, atomic, and usually absent — such as one converted from a
> spinning lock — the common case at synchronize time is that there are
> no readers at all. Even synchronize_srcu_expedited() still costs the
> caller an unconditional sleep and two trips through the SRCU workqueue

If the common case is that there are no readers and the new fast path
is intended to avoid the SRCU grace-period machinery, could you explain
what property of SRCU is still required by the proposed users that
prevents using ordinary RCU instead?

> And synchronize_srcu()'s auto-expedite heuristic explicitly
> declines to expedite within exp_holdoff (25µs) of the previous grace
> period, which is exactly the regime a burst of back-to-back
> invalidations puts such a domain in.
> 

Could this use case instead be addressed by making exp_holdoff
configurable per srcu_struct, or otherwise allowing a dedicated SRCU
domain to use a more aggressive expedite policy?

If not, what makes the proposed try path preferable to changing the
expedite policy?

> Provide try_synchronize_srcu(), which proves the no-readers case
> inline and returns true without sleeping, without the workqueue, and
> without advancing the grace-period sequence (so cookies from
> get_state_synchronize_srcu() and queued callbacks are unaffected). If

Could you also clarify why observing no readers during this
check is sufficient for the reclamation/happens-before guarantee
required by the proposed callers?

Since a successful try_synchronize_srcu() does not advance srcu_gp_seq, 
flip the SRCU index, or process callbacks, could we document more 
explicitly that a successful try provides the required 
reclamation/happens-before guarantee to the caller, but does not 
constitute an SRCU grace-period completion for the state/callback APIs?


> the proof fails, it returns false and the caller falls back:
> 
> 	if (!try_synchronize_srcu(ssp))
> 		synchronize_srcu_expedited(ssp);
> 
> For Tree SRCU the proof sums both epochs' unlock counters, executes a
> full barrier, then sums both epochs' lock counters. Equality proves a

One question about the barriers: the existing
srcu_readers_active_idx_check() relies on the barrier between the
unlock-counter and lock-counter reads to provide the ordering with the
reader-side barrier; the !did_gp path there has no barrier before the
unlock-counter read.
 
[...]
> +	smp_mb();
> +
> +	unlocks0 = srcu_readers_unlock_idx(ssp, 0, &rdm0);
> +	unlocks1 = srcu_readers_unlock_idx(ssp, 1, &rdm1);
> +
> +	/*
> +	 * Reader flavors which elide the read-side smp_mb() that the
> +	 * pairing above depends on cannot be proven absent this way;
> +	 * they need a real grace period.
> +	 */
> +	if ((rdm0 | rdm1) & SRCU_READ_FLAVOR_SLOWGP)
> +		return false;
> +
> +	/*
> +	 * As in srcu_readers_active_idx_check(): ensure that a lock is
> +	 * always counted if the corresponding unlock is counted, so that
> +	 * a reader racing with these sums can only inflate the lock sum
> +	 * and force the (safe) fallback. Summing both epochs means no
> +	 * index flip is needed: a stable equality proves there was a
> +	 * moment in this function at which no readers existed at all.
> +	 */
> +	smp_mb();

And, the middle smp_mb() appears to occupy the same position, while
the final smp_mb() orders the caller's subsequent accesses after a
successful proof.

What ordering edge does the first smp_mb() establish that is not
already provided by the middle and final barriers? I couldn't identify
a specific execution requiring it from the current comment or code
structure.

Could you point out the ordering requirement for the first smp_mb(),
or provide an LKMM argument showing why it is needed?

If there is no additional ordering requirement, could it be removed to
avoid an extra full memory barrier in this fast path?

> +
> +	if (!srcu_readers_lock_idx(ssp, 0, false, unlocks0))
> +		return false;
> +	if (!srcu_readers_lock_idx(ssp, 1, false, unlocks1))
> +		return false;
> +
> +	/* Order the caller's subsequent accesses after the proof. */
> +	smp_mb();
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(try_synchronize_srcu);

One more question about the documented fallback: synchronize_srcu()
and __synchronize_srcu() use
RCU_LOCKDEP_WARN(lockdep_is_held(ssp) || ...) to catch invocation from
within a same-type SRCU read-side critical section.

try_synchronize_srcu() does not appear to perform the corresponding
check. A caller inside an SRCU read-side critical section would fail
the fast-path proof and then follow the documented expedited fallback,
resulting in a self-deadlock without the corresponding lockdep diagnostic.

Would it make sense to perform the same lockdep check in the try path?

When applying this to current rcu/dev, the patch also needs to account
for the additional bool is_atomic argument to
check_init_srcu_struct(). Please rebase accordingly.

Thanks,
KunWu
> +
>  /**
>   * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
>   * @ssp: srcu_struct to provide cookie for.
> -- 
> 2.43.0
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
