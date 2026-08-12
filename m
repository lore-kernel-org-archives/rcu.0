Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AE30EF77;
	Wed, 12 Aug 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526904; cv=none; b=AYRHdgoHU+3GY3gtz87biuGYRzBTqHpvbHqN5bWQWLhkZ23jKWPVTYmp4QL6BtKJ7imkqmNMesxk4FWJp/mQ2YSaftzCjOI9EOtB8XzWmd9hNUakhZwugTtifM1+SGbDKSYuh1AgVll/2Y7KdTOd26jAJIAC7zEERv63M5nS3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526904; c=relaxed/simple;
	bh=SK4MPPOum5/xEb7ZtlABlunA/xhLveYIyZcRf8TwA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crtVHQrC/7K9XdetNxvckpYKyUpseJ5jkRckNXvcO+WdcUIfYZDP/1a/0k4hyK1UjMhLhA7UnERaxgtc6H5QbFumZnmXI//XkF9bmOje8A5HvHOpPMi6RrAMZ8qiOJ8vjp3Nv13er+gRj6FUP+pemGh1s0P1e8JIWrcP4/FmQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lOUVxZUP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lOUVxZUP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YUU7A/3S+/I5gW+NMIkmvowBgYiANelkV9JSudmJ3AQ=; b=lOUVxZUPZqLdhuVc7oRjr7bMIn
	dWoVui8YHVsx2e3f/rqm48PK6mDbVUCQRMluULhzTDVDuLWG0uw486P9Dl0zpPjyudSyaHZfoKIG1
	KQ3kx7Ngo7h6ULPLQj0n+jNOTdI6TGYCYR1ysgXQOnxoStpWyx47vA84LRwAhWbwQ8IfuO+u4zyZH
	FjuSGgk09njhita9sp/CsWsLFQPIQBa73r1QLqvx4v5iqdABiOe35h+anicZLiOB7t4XgCwWc2Dof
	SQLYYfQ7uDON/zyGDExamhX34ykUsFN4EvA06bZOkURETvQcy/Md1bkzXWUnytGJmWkQfCJ+lyIqm
	oGtQ1E1Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu5Fu-004F3B-25;
	Wed, 12 Aug 2026 09:28:14 +0000
Date: Wed, 12 Aug 2026 02:28:10 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Dai <david.dai@linux.dev>
Subject: Re: [PATCH RFC] rcu-tasks: Disable callback contend/collapse
 messages by default
Message-ID: <anw8Qw8lfeIykski@gmail.com>
References: <eb1c47d9-e694-407f-9e4c-3b7519f4ec46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1c47d9-e694-407f-9e4c-3b7519f4ec46@paulmck-laptop>
X-Debian-User: leitao

On Tue, Aug 11, 2026 at 07:00:14PM -0700, Paul E. McKenney wrote:
> New workloads can do large bursts of call_rcu_tasks() invocations in a
> short time period, followed by a quiet time period long enough to drain
> all of the callbacks, followed by another burst of call_rcu_tasks()
> invocations.  This can cause RCU Tasks to switch back and forth between
> queuing callbacks only on CPU 0 (during quiet periods) and on all CPUs
> (during bursts).
> 
> Which is fine.  Except for the fact that each cycle from CPU-0-only to
> all-CPUs queuing and back generates three console messages, one announcing
> the shift to all-CPUs queuing, another announcing the start of the shift
> back to CPU-0-only queuing, and the third announcing completion of this
> shift after an RCU grace period.  And these console messages can overrun
> console-log communications channels and obscure other console-message-based
> debugging information.  And the only known use for these console messages
> is debugging RCU Tasks itself.
> 
> This commit therefore adds a rcupdate.rcu_task_collapse_debug module
> parameter that defaults to false (suppressing these console messages).
> Those debugging or otherwise playing with RCU Tasks callback queuing
> auto-adjustment can set this parameter to the value true.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: David Dai <david.dai@linux.dev>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the patch. I confirm that this is flooding the monitoring
systems at Meta, together with [1]

Link:
https://lore.kernel.org/all/20260810-swap-v1-0-375ef0767206@debian.org/
[0]

> +static bool rcu_task_collapse_debug __read_mostly = false;

nit: You don't need false here. Checkpatch even raises an error:

	ERROR: do not initialise statics to false

Thanks!
--breno

