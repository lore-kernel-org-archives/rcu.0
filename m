Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D963A71A8;
	Tue, 21 Jul 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644329; cv=none; b=nJv4/l4yFOxJxUFkICWGRx2OL21Hpvu9FOQlQRofUzzspVLQpQS56/BkBDVWYscXW+q4/fqOHHeW5JPTk+qQFmSR+U1pKr0TCDeyUUFjD443eKAlb23TrDiMf+zwiW5Y0SBd+KdiAGiYIbtpBVzFfV5guS3r727zGAvLo+zGAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644329; c=relaxed/simple;
	bh=tJZjyoShyweuGopnnWV7PzGnIi3+Zje/RdtlDmKke5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDC533K7K0t8nKMv4pgDiVey0fZykUwdRvbTuj/2Nmlt01C2Mit9vmtpzYT5ad2i0OkKp4N/0FQ5BoxrTDW9NvU5D5skn5vwPPF6+q+2a9KIN5VGIlPlwF+ps9wQMeiq1yvOSGFAO1S56K7zXnUc9GmU/Vw0Y9lV0VRd9TpE2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1GeubsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1GeubsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBBE1F00A3D;
	Tue, 21 Jul 2026 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644328;
	bh=+9P4nQ30H2lbynQhAmgEZaCKF8E86DdTuPpLNMBxPPI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=I1GeubsXZUzC8XFI+JgNWMzktPSTGxnjNjT82xHgPNihFYP1hj3XNNeW0dvzE3+XH
	 QxOc+JJbVwF4JxlJ6zbtkgqtPtKNZDrOhQLsgY+9KA7rkqokZuZ08dflPqh04tH6/e
	 5gtLYUmxoT144p01cNhZ4YZVhcGigixJRzilZJueMsZV+sZaBUcFit9wPNcpnJj7s6
	 In8uN5cTKIkT3eKLOWSPr2yUJ80sXEkD3O++d2CHMx+CeJDtkg/TI4QWTuOZdsVEJ0
	 aVtN28USlDjlmD9PXaKDUKGbThQJuTvtdxyAUBMTV6pmoF+G+qtZeVZOFLfVNCtIXF
	 TEZwG6DsVAHJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E1501CE09F8; Tue, 21 Jul 2026 07:32:07 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:32:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 09/11] rcu: Detect expedited grace period completion
 in rcu_pending()
Message-ID: <d2eca500-344d-49ed-8731-edbc8a090fce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-10-puranjay@kernel.org>
 <al9p8MrcEdByrjfh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al9p8MrcEdByrjfh@localhost.localdomain>

On Tue, Jul 21, 2026 at 02:45:36PM +0200, Frederic Weisbecker wrote:
> Le Wed, Jun 24, 2026 at 06:23:51AM -0700, Puranjay Mohan a écrit :
> > rcu_pending() decides whether rcu_core() should run on the current CPU's
> > timer tick.  It does not account for expedited grace periods: after an
> > expedited GP completes, a non-offloaded CPU's callbacks remain in
> > RCU_WAIT_TAIL (not yet advanced to RCU_DONE_TAIL) and rcu_core() is
> > never invoked to advance them.
> > 
> > Detect that case via rcu_segcblist_nextgp() combined with a new
> > memory-ordering-free poll variant,
> > poll_state_synchronize_rcu_full_unordered().  This keeps rcu_pending()
> > cheap: it runs on every tick that has pending callbacks, so it must
> > not pay for the two memory barriers in
> > poll_state_synchronize_rcu_full().  The check is only a hint to run
> > rcu_core(); the ordered re-check and the actual callback advancement
> > happen there.
> > 
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
