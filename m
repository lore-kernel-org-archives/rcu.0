Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36571E87B;
	Fri, 21 Feb 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151870; cv=none; b=HXaa3sp5sMy+y565Y3h/eQUNNgjI31rF+2CnrPGm/RLXU19+KEyocnBOWZskkMXRI9umpJue+w+b1aEAade6Mp+Qyjqri/HWPPplKlvwLSGGcdOhm7a8pW+8iTpQvcnN0r3uSuAY6KklkVCTnKvyxQ6gt988elPZmLYCpDtWgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151870; c=relaxed/simple;
	bh=DAAOHAFUSIYiuwahp3IQS9xds/bKBMPw8aEZIGAnf/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbhf4zprjBKMSXnOX6juRAMlEDy/CKqPBelcSFxKd4KEfTI9lnNRP3lvoBNp6mvL59jUDe0rP6XGlsIImQr+ATPwMyiNFcIFiLtcdszqub7mq8+7FAnOayQt3kuOzxfrLRyOaMGQoIAFYu6iAXtmSX+iXvbf4if6vBCfVK/6Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpGMqtF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpGMqtF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2093C4CED6;
	Fri, 21 Feb 2025 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740151870;
	bh=DAAOHAFUSIYiuwahp3IQS9xds/bKBMPw8aEZIGAnf/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpGMqtF5iMuNnuD2Fzs+ukabyq6pfy1i5HLQN14mOO8hEGGq7fzK65N2uwcveYOxr
	 27N9r+DxLUm6RX8gxYdN1O0IR5s38cFD1+V70QDEZJNb9UHnYbjSlGcaaWbvc5L/s5
	 dgOYbyKm4uGYcfGz5ShHfUSnRnSzzWihz5E4paROu9cCzvcsC2TEQ8tE67vmw/dya/
	 wo5aqzmkVrN2yvJ1ACWfSGX/E5fjb8L+AG1be9RFUyPaPBEDe0y4o91F0QYVFVgneH
	 jPapLBrHE2pGQDTFhijvAW37Gd3QuOyyFeFpWKTcNksT3CiG/O8WQ312e5PlX9hINw
	 RcEFFnltBZ68g==
Date: Fri, 21 Feb 2025 16:31:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <Z7icO5sp9SoXZSJs@localhost.localdomain>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
 <Z68yzBURiIr_7Lmy@pavilion.home>
 <610596cf-9836-473f-bcdc-15c69b7e0cd4@paulmck-laptop>
 <Z7ET8S4HKqSPubQY@pavilion.home>
 <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>
 <966fe653-7dbf-40b6-8b6e-c9bcf7b34335@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966fe653-7dbf-40b6-8b6e-c9bcf7b34335@paulmck-laptop>

Le Wed, Feb 19, 2025 at 07:55:05AM -0800, Paul E. McKenney a écrit :
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 86935fe00397..40d6090a33f5 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -4347,6 +4347,12 @@ void rcutree_report_cpu_dead(void)
> > >  	 * may introduce a new READ-side while it is actually off the QS masks.
> > >  	 */
> > >  	lockdep_assert_irqs_disabled();
> > > +	/*
> > > +	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
> > > +	 * The requested QS must have been reported on the last context switch
> > > +	 * from stop machine to idle.
> > > +	 */
> > > +	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
> > >  	// Do any dangling deferred wakeups.
> > >  	do_nocb_deferred_wakeup(rdp);
> > 
> > I fired off a 30-minute run of 100*TREE03 with this change also.
> 
> And no failures!

Ok I'm adding that one on my queue.

> 
> 							Thanx, Paul
> 
> > > > 3.	Your ideas here!  ;-)
> > > 
> > > :-)
> > 
> > 							Thanx, Paul
