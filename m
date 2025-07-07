Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6E28A3EC;
	Mon,  7 Jul 2025 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874657; cv=none; b=S3cFAj39WvReE3LvHeh0aF5LzzztXja3Z8AdD7Oy70fup6hvZN4Jj2vPr0Iq+eS2iyxBOL/i6RUKrp1IUcGmI93Yw1AMU9qvdLl6eTFVDOQH9OXNcQcSdaFdgIjyEPZTj3KsOqvvA2gBOXW4NZ6WnYZ/DtpNtp8n4x6pTcTVC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874657; c=relaxed/simple;
	bh=95HEUV9sZ4HS+8+sI9aRb/OVdW2LtmltUFiU7K+uQAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACDZZTlrTx8k66yq+lG0/1LhBAEDx6BYDZRcbZV7E7hBhrpvwp68fEeMo39ysKCsmX9c+QybacltHE+tHQeawv5Cy12WusZicy6ZAdMyjJ7Vg6jVNI++aHfVn5kLbl073fw6uFuu+LX5wt5xCWVaZMp6ICSmY2x9lGRUJ8B6s5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WT5kOkLK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WT5kOkLK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qwZGG4ywOQ0IHJUhaYE22UySUEJmxFhYtMFxI52azbo=; b=WT5kOkLK41i4vyAbd+g9WSE7A3
	dlLBGG5AkuZhzPhMiCzEUwz3eRWciL5hUzBXRW1Qjs9PA7R6PNb/Q7KVDR2RsmTN5OilaJcZVYndD
	vf8Ij2dCYkHdZ43ERFjIl9znJkojAUCspgb39sEwfQFYPn5IUrb+obyBZL/coc5qUaxIB8pvUgL96
	j8tvAiczn7d305WsONBqZiKXJojtAF3z8OCo1S23L3I0Rgt1gUD8P0sp/TwNexC1Omfd9WY4Ra7xf
	2XHJW+SAU4aNAlDAGpc0jFARPFnbtCK6pvzqQCUqAAGXfvfNUVfHAgS8agd0mAgTq5V18/XpqzkB8
	udOQjTFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYgcl-0000000C3aF-3UOo;
	Mon, 07 Jul 2025 07:50:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 790E030041D; Mon, 07 Jul 2025 09:50:50 +0200 (CEST)
Date: Mon, 7 Jul 2025 09:50:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705172328.4114289-1-joelagnelf@nvidia.com>

On Sat, Jul 05, 2025 at 01:23:27PM -0400, Joel Fernandes wrote:
> Recently while revising RCU's cpu online checks, there was some discussion
> around how IPIs synchronize with hotplug.
> 
> Add comments explaining how preemption disable creates mutual exclusion with
> CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
> atomically updates CPU masks and flushes IPIs with interrupts disabled, and
> cannot proceed while any CPU (including the IPI sender) has preemption
> disabled.

I'm very conflicted on this. While the added comments aren't wrong,
they're not quite accurate either. Stop_machine doesn't wait for people
to enable preemption as such.

Fundamentally there seems to be a misconception around what stop machine
is and how it works, and I don't feel these comments make things better.

Basically, stop-machine (and stop_one_cpu(), stop_two_cpus()) use the
stopper task, a task running at the ultimate priority; if it is
runnable, it will run.

Stop-machine simply wakes all the stopper tasks and co-ordinates them to
literally stop the machine. All CPUs have the stopper task scheduled and
then they go sit in a spin-loop driven state machine with IRQs disabled.

There really isn't anything magical about any of this.


