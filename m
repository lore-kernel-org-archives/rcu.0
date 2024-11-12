Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9412204930;
	Tue, 12 Nov 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447449; cv=none; b=QqhjRDczpE/jdx6oaCbF5DlSXKDHlMLuqurEimcyrTa0XCyy+4YRDR7m+HBqvb5Zh26p/ce5yeHF7iyUHIRXLyqv7DTBxxHPuicp8jtq7jbk2/yc3KdEVCyJUIrPmPTSCnlQ4jypBd2zAWqLtjWAFTjhKuGmZK5Ex4k69FktENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447449; c=relaxed/simple;
	bh=lZl3O4OaN8VLN+d/4PXg/BbsljeYpKRWf3B0Ywm3OPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPwjoqF4QsOCC4P6FVktVBsETF7e5KCo17olll/tCz/PISCySHMI+LvEKzpcmgHg69h7wWufNIO/vrgDM+wpJxq5UybiKhZCOfg0Dg/0NqCVB5//p8zW1+0AeyT01+Z1ey027l+4TeQiwYdffG/J0ZDvwag6aMZ6f8fDJKefnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ+ErNK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ+ErNK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0426CC4CECD;
	Tue, 12 Nov 2024 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447449;
	bh=lZl3O4OaN8VLN+d/4PXg/BbsljeYpKRWf3B0Ywm3OPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJ+ErNK+T0TDxgPGhvB7PkdRX8STjXXXVxnULzn6grDSF0NCrBOCDiYb/kW6b3w+i
	 Qm272rewCc8KWGm37SCmRMJMs+E0fl+W3pUbyZ+yWm2oiiBqzzp0tmmXCUz4txz927
	 zqoRb7XQrsXqn2YOUx8CwmBOkz9ViSBLrmZn2ryAkSiKHeSeixL1ZwrSph3LDIl96r
	 iHfZktBz6a/jOuCHR4+MBDHwAD177iGoSdcPKOyzpnk6HwvkYdJlJE7g94ZqJIhJg2
	 U0wjJ/nlChYXfyUPzun10DqA6sSWBTlvqdU8zsHR3u+QaAr9tW+kFAHd83T6Bq/BJn
	 O06kQCWMBQF7w==
Date: Tue, 12 Nov 2024 22:37:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Zqiang <qiang.zhang1211@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu/nocb: Fix missed RCU barrier on deoffloading
Message-ID: <ZzPKlujDt20gMkY3@pavilion.home>
References: <20241106153213.38896-1-frederic@kernel.org>
 <20241106153213.38896-3-frederic@kernel.org>
 <68c39e33-6281-4978-ba4e-131c6336aa7e@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c39e33-6281-4978-ba4e-131c6336aa7e@amd.com>

Le Mon, Nov 11, 2024 at 01:07:16PM +0530, Neeraj Upadhyay a écrit :
> 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 16865475120b..2605dd234a13 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -891,7 +891,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> >  					    nocb_cb_wait_cond(rdp));
> >  	if (kthread_should_park()) {
> > -		kthread_parkme();
> > +		/*
> > +		 * kthread_park() must be preceded by an rcu_barrier().
> > +		 * But yet another rcu_barrier() might have sneaked in between
> > +		 * the barrier callback execution and the callbacks counter
> > +		 * decrement.
> > +		 */
> > +		if (rdp->nocb_cb_sleep) {
> 
> Is READ_ONCE() not required here?

No because it can't be written concurrently at this point. The value observed
here if kthread_should_park() must have been written locally on the previous
call to nocb_cb_wait().

Thanks.


> 
> 
> - Neeraj
> 
> > +			rcu_nocb_lock_irqsave(rdp, flags);
> > +			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> > +			rcu_nocb_unlock_irqrestore(rdp, flags);
> > +			kthread_parkme();
> > +		}
> >  	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
> >  		WARN_ON(signal_pending(current));
> >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> 
