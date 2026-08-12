Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DF48C3E3;
	Wed, 12 Aug 2026 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570180; cv=none; b=mqYK9pVmBtm18H0wMG7I0TDe5EVvdvo1VZMf1Jmq4vX1C0RY9W4WW4wmaJwdAK8U6opuE8EoC3QiQDodu0PPtoTcVhxTeU/Z+xuSg8Pqpz3/Kcn0H+YaFNNIuyKiRqeQSZ4hBM5z2VIf33jPplYaBeKbheE02sHeKkrJfkSKGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570180; c=relaxed/simple;
	bh=iR1DKvAFor+wbnwSxob6rgygEa+SXp3NsC3eYPqjNx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcT39P9B6YOGhUAMAGbZjJ3AhZQtIrrbrwjW9w2P0YaDizDq7jhvnUabCwAxc3IM4anQjCwCyQcU1DQwy5zca8cKlOCllnQoXoXfNg2ahrfem1zsroV4PjVimOK7TmAuyzPI8Uf250EOnJeEn+lYbYp/2Il29JFBB9JHS7cbo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgoKDZYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgoKDZYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991171F000E9;
	Wed, 12 Aug 2026 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786570178;
	bh=BOHa58FJaGH8oiqqQ92/djPY9z94j0otwLbIoF0R/Do=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=hgoKDZYGxNcWxhmlm6ZUKQoVrcah/PraqIH5EsopsWmAMD6xYltXwcGqKXShqGJSp
	 09ZDTO5tXa3naNhLMGXWrDFlApp1lulTon/5TPJKC54iW4gaRVS8NEjLupJ0C73rAL
	 eBjswhC0Z9ba29vmYajMT6PMRUCESrv39Gfjc46lEQDgGcphp2cWO2qd46IelZLC6d
	 yYD0I7Cxz2GnoCX+nCtIDBBKUy/9PAzEuws3zys8CaOscJlWGylc/WRdKdvUNW9v3j
	 U7c6SJ7pq2IRKQu1EUmcYEEkyZGzhJKNLKCUYECtiIrQkMV5lpI85CxrYQME7buGO1
	 dL6d+pTZeZZnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C082CE0EBE; Wed, 12 Aug 2026 14:29:38 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:29:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Dai <david.dai@linux.dev>
Subject: Re: [PATCH RFC] rcu-tasks: Disable callback contend/collapse
 messages by default
Message-ID: <7924bc0d-2730-4187-9091-60e8725ec8a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb1c47d9-e694-407f-9e4c-3b7519f4ec46@paulmck-laptop>
 <anw8Qw8lfeIykski@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anw8Qw8lfeIykski@gmail.com>

On Wed, Aug 12, 2026 at 02:28:10AM -0700, Breno Leitao wrote:
> On Tue, Aug 11, 2026 at 07:00:14PM -0700, Paul E. McKenney wrote:
> > New workloads can do large bursts of call_rcu_tasks() invocations in a
> > short time period, followed by a quiet time period long enough to drain
> > all of the callbacks, followed by another burst of call_rcu_tasks()
> > invocations.  This can cause RCU Tasks to switch back and forth between
> > queuing callbacks only on CPU 0 (during quiet periods) and on all CPUs
> > (during bursts).
> > 
> > Which is fine.  Except for the fact that each cycle from CPU-0-only to
> > all-CPUs queuing and back generates three console messages, one announcing
> > the shift to all-CPUs queuing, another announcing the start of the shift
> > back to CPU-0-only queuing, and the third announcing completion of this
> > shift after an RCU grace period.  And these console messages can overrun
> > console-log communications channels and obscure other console-message-based
> > debugging information.  And the only known use for these console messages
> > is debugging RCU Tasks itself.
> > 
> > This commit therefore adds a rcupdate.rcu_task_collapse_debug module
> > parameter that defaults to false (suppressing these console messages).
> > Those debugging or otherwise playing with RCU Tasks callback queuing
> > auto-adjustment can set this parameter to the value true.
> > 
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Reported-by: David Dai <david.dai@linux.dev>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>

Thank you!  I will apply this on my next rebase.

> Thanks for the patch. I confirm that this is flooding the monitoring
> systems at Meta, together with [1]
> 
> Link:
> https://lore.kernel.org/all/20260810-swap-v1-0-375ef0767206@debian.org/
> [0]
> 
> > +static bool rcu_task_collapse_debug __read_mostly = false;
> 
> nit: You don't need false here. Checkpatch even raises an error:
> 
> 	ERROR: do not initialise statics to false

And this fix as well.

							Thanx, Paul
