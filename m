Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427424887A;
	Mon, 24 Feb 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411457; cv=none; b=hWf1RBqaN25FiXcHr6maCDfgC5Mz/Mxpo/NnhOOVauGBr5VNm3k52dTfuVlHluQXWx/MCgNdq5ICL2aYCpAnzlQtMeKXAn73jLU22dsQ/uNcPTirdxQuVVpGB1YD3H8lFp71Du+wola+5MX7KOeu+beALe3DaaQL+IjlGaeV3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411457; c=relaxed/simple;
	bh=u5QAJ42DRy8ZnhVq2mJsa+QiTU0Mr4iCvNVvkjkRrkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYJAy0g7hIE4dDA2ng3NieoUHWRsyEgTY0ztZO4WV8RsV4V3tq+KAwf+AmtQjdExnzph9/jx/nXubi5HifrV+zKeAdFS0/QLldXwLp+8ujN+HOCXwWPil77Xo2xxgHV/2yCCZACqWNqvMAVZiQ2M8rAhGCALZqKNbBUmeq9zZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26tiAiP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26tiAiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E79C4CED6;
	Mon, 24 Feb 2025 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740411456;
	bh=u5QAJ42DRy8ZnhVq2mJsa+QiTU0Mr4iCvNVvkjkRrkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n26tiAiPA/EnLuWwHHXxJQo0XxQ6+FBmRROtzKyw8CLdXwa+DUo1mj9Y81reXwfVZ
	 WsGSbBt/XxZBtCP3SjbQaQV0jXl0wUunnuQV+Tav5kL71Bkz4hcCFGRPIIBsNAAAAN
	 P9zs048qa1Mg83YtIgXR9odTHlLhs6p02flIpiTIRkQdZCL3+tOzQqkkDTI34AlpXZ
	 gwj7c3LauJTxkhK0uaxhrDDqPFNrPT+XjxpKm/a/R/3PIVSX+/OXHaDyJuxtlDNckI
	 Zu+f8gLBnxvo1ONE8vsDhNDYeSbcQZfgqXZ4yLzM4l2GnAmsE1jZZVNAar2DCThAVf
	 zarhrfHExOnzw==
Date: Mon, 24 Feb 2025 08:37:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z7ySPC32oKBccunx@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xbrnP8kTQKYO6T@pc636>

On Mon, Feb 24, 2025 at 12:44:46PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> > > 
> > > The warning indicates that this shouldn't be called from a
> > > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > > and tearing down block devices, so this is a memory reclaim use AIUI.
> > > I'm a bit confused why we can't tear down a disk from within a memory
> > > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > > flag when creating the workqueue?
> > 
> > I think it's reasonable to expect a memory reclaim related action would
> > destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> > then we could get another surprising warning elsewhere. Also making the
> > kmem_cache destroys async can be tricky when a recreation happens
> > immediately under the same name (implications with sysfs/debugfs etc). We
> > managed to make the destroying synchronous as part of this series and it
> > would be great to keep it that way.
> > 
> > >   ------------[ cut here ]------------
> > >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> > 
> > Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> > is after all freeing memory. Ulad, what do you think?
> > 
> We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
> AFAIR, there is an extra rescue worker, which can really help
> under a low memory condition in a way that we do a progress.
> 
> Do we have a reproducer of mentioned splat?

We're observing this happen in production, and I'm trying to get more
details on what is going on there. The stack trace says that the nvme
controller deleted a namespace, and it happens to also be the last disk
that drops the slab's final ref, which deletes the kmem_cache. I think
this must be part of some automated reimaging process, as the disk is
immediately recreated followed by a kexec.

Trying to manually recreate this hasn't been successful so far because
it's never the last disk on my test machines, so I'm always seeing a
non-zero ref when deleting namespaces from this nvme workqueue.
