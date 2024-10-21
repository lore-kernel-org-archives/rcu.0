Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B731E47BC;
	Mon, 21 Oct 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511056; cv=none; b=hRzZNde6akwGnPf1M0biq3LZl5QCuDG9bvqoP4Sar42plz2CK2kbiGXtKRluNMrvakeoTnB4p/gOJxf6tRqivG227iDrIda+8WjloB3Q4sn96nr7hgNb7ZrTADeBV+AKGTE3/UcXsz7YA2yNhE+oUWgB8KtlYQ9L5ZP0YADJLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511056; c=relaxed/simple;
	bh=Gy1Z3Hj9K7ESYVVgrFv3BAdciLd7prx1WodctXSKU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW4dhvr2/6UzrNKCfvLW9owI9NrGxj9qoFdG38e2LCIXBNtUsE2x49TdPnoph4fF39FywtSY4Ql2WCAq9RZtLvBTv1A+E+P9F664H2VNxJO8VflwCA1tI551CFPyt1gCVqWUEW6V1iJQEAbaLijk+5eghj1i20SvkVSrLo3M/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A540tJji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A540tJji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041B6C4CEE6;
	Mon, 21 Oct 2024 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511056;
	bh=Gy1Z3Hj9K7ESYVVgrFv3BAdciLd7prx1WodctXSKU/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A540tJji1vIm1qZ+U4Rqrrl6tJKUAyPo971NfJuLoTD+8cedRuBQewE83ITPURWqJ
	 C2/Ka/zXux0RPOa5p+BWiujOgMpQWEEON02kQ7NQPS8UBfJKzf0lLim/26x/LGYWtu
	 Cz3EjQdyl3jijO4bK3YcGN3Bs1NpO8S74+KtQICwk0nbLTIev+pseAG5erAovJ38Y7
	 Y3pzwWQSGhKKL3HDf4IlE6W1cavBtAgcyl+3rMCz8iTkNLrla5obMmN4kAoYQoktd1
	 JJ/L24XUVJ/MUWbALxY4bkoZVheUE/Jm2p29xn6l0OtS+zzTK+J+7s7qnaRpmtCIxE
	 SXgh5OcrTGKWg==
Date: Mon, 21 Oct 2024 13:44:13 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in
 rcu_nocb_rdp_deoffload()
Message-ID: <ZxY-jRKBf8672czT@localhost.localdomain>
References: <20241020125119.14751-1-qiang.zhang1211@gmail.com>
 <ZxWO6BmRutOC0RnZ@pavilion.home>
 <CALm+0cW=1PAVhjHKM+aXLHHzsD0+7pbVDvmm+kxvff7r=Di2tA@mail.gmail.com>
 <CALm+0cV-s+gYDXKQV9dYWEr-ui6aJ6DZzvyNhW6H2T39WtPjWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cV-s+gYDXKQV9dYWEr-ui6aJ6DZzvyNhW6H2T39WtPjWw@mail.gmail.com>

Le Mon, Oct 21, 2024 at 07:01:02PM +0800, Z qiang a écrit :
> > For the non-nocb cpus set during boot, the corresponding
> > rcuop kthread, we should park directly, otherwise
> > WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)) will be triggered.

Ah but this case is different. kthread_park() is called on
the kthread that is freshly created. In that case it is
parked before the kthread even had a chance to call its handler
(which is rcu_nocb_cb_kthread()).

See these lines in kthread():

	/* OK, tell user we're spawned, wait for stop or wakeup */
	__set_current_state(TASK_UNINTERRUPTIBLE);
	create->result = current;
	/*
	 * Thread is going to call schedule(), do not preempt it,
	 * or the creator may spend more time in wait_task_inactive().
	 */
	preempt_disable();
	complete(done);
	schedule_preempt_disabled();
	preempt_enable();

	ret = -EINTR;
	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
		cgroup_kthread_ready();
		__kthread_parkme(self);
		ret = threadfn(data);
	}



So really rcu_rdp_is_offloaded() has to be true (but we can
warn if it's not. Though we already have a test for this in
nocb_cb_wait()).

Thanks.
