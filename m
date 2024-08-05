Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02054170A33;
	Mon,  5 Aug 2024 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902390; cv=none; b=bG7Hr/ktG9dQpebcFBxN5YR/VH8TSiaX77lc3sps0hpFuRnWPQKODP1AvKHOrX6FcrYMzT5OTAv9AxK2wM/SHJU2da/WZPdlQkK3u1sMcGtZhL2jtB870U0VR/oc6BzsonIn5oowldf8gERrHTlH0JW9JKhX3gsTO/poA68NOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902390; c=relaxed/simple;
	bh=qPipzIqpOFeYTGpyUGvCyLbP2YXb2Z1WH0dgber+cC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlpOKtZfAHRkRiU5j3q/m5TnQhbAyQaiH7zlcqUfTFZA+v/u+beiGdgTj/HVWeZo1uuBVDmeDxs+YgiioG+D6WrmSwOpLgu3bMt6y6qDWK9nFlf3z4k4CJYMYyxiuJvdL8edupZv3uLlFLop7a2MFbnYOmmRp7sTlnZDNq/luVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzVbKjsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzVbKjsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18476C32782;
	Mon,  5 Aug 2024 23:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902389;
	bh=qPipzIqpOFeYTGpyUGvCyLbP2YXb2Z1WH0dgber+cC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzVbKjsLb08FPak/EQhMiOfmR6o9vTANUK5rqxkhBNJhzxpkEzV1Ht4LK7ubkyJa9
	 pua2YfKNs5pXY74XcqQ3itgR2ZwwlCrheSmoPcnL4Po+FCOVr2hbKPGx3jM70xjLwR
	 zYYxGXnuxSeGZ3MvOZSetPkRoTMZnFPfZ8zKGzPA3W7l6lIDQKLWYK2vyFVeXtDolZ
	 e+kNoH2iDiTaQzcp+zVBQLyPpahu+SNI0fjlNeCySEYe/U1cuLJXo/8hKN1rjE/8QP
	 gxHSM7iYffi5its8fgUBDw4/jN0COKBKLpXrDIvzC2LECNqr07kvCaTsmMZ7ZZcGvY
	 HpfmvoHvx3tDw==
Date: Tue, 6 Aug 2024 01:59:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 12/20] kthread: Implement preferred affinity
Message-ID: <ZrFncpgfJj9sWuDO@lothringen>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-13-frederic@kernel.org>
 <4e9d1f6d-9cd8-493c-9440-b46a99f1c8af@suse.cz>
 <ZrDhp3TLz6Kp93BJ@localhost.localdomain>
 <00914d25-f0ae-4b00-9608-2457821c071c@suse.cz>
 <ZrD8kmRw73bS3Lj6@localhost.localdomain>
 <b358e42e-e8aa-40e9-9fca-90ae28cfdfaa@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b358e42e-e8aa-40e9-9fca-90ae28cfdfaa@suse.cz>

On Mon, Aug 05, 2024 at 11:25:59PM +0200, Vlastimil Babka wrote:
> > It's too bad we don't have a way to have a cpumask_possible_of_node(). I've
> > looked into the guts of numa but that doesn't look easy to do.
> 
> That was my impression as well. Maybe not even possible because exact cpu
> ids might not be pre-determined like this?

Probably.

> 
> > Or there could be kthread_set_preferred_node()... ?
> 
> Possible instead of the callback idea suggested above?
> kthreads_hotplug_update() could check if this is set and construct the mask
> accordingly.

Or even better, callers of kthread_create_on_node() with actual node passed
(!NUMA_NO_NODE) can be preferrably affined to the corresponding node by default
unless told otherwise (that is unless kthread_bind() or
kthread_set_preferred_affinity() has been called before the first wake up, and
that includes kthread_create_on_cpu()).

There are a few callers concerned: kswapd, kcompactd, some drivers:
drivers/block/mtip32xx/mtip32xx.c, drivers/firmware/stratix10-svc.c,
kernel/dma/map_benchmark.c, net/sunrpc/svc.c

After all kthread_create_on_cpu() affines to the corresponding CPU. So
it sounds natural that kthread_create_on_node() affines to the corresponding
node.

And then it's handled on hotplug just as a special case of preferred affinity.

Or is there something that wouldn't make that work?

Thanks.


> 
> > Thanks.
> > 
> >> 
> >> > Thanks.
> >> 
> 
