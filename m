Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AC36BCE2;
	Mon,  9 Feb 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655254; cv=none; b=joVRHYuWgTaib8Vu0VI6mqEJHwVZBDyyB37frd6K6J73y3zXP7QamByRFtkvG6dPawl11vK+oYAGJKCTA4/j25eMQ6325M2OkYjwgyUhzpb6u9n2F8JvAnR0rDg+lAdDiIf/qmbZvvBYrxhTdvgrWTPGq30UNOMayVEpZ2457Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655254; c=relaxed/simple;
	bh=lARbkbntWGtDhEXk7qoEkyADOxVnx/IfWT0MwbUrRfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTd7k+T9XnddTwhVtOHLfWCNNiRyFsgoWMy818Dhconn7LfsTzBaNc44tKNFhg7CGPd2anF7e3eOzml5ZCwdQSF7SPqptcJerOnPxtry1xJNUMBIWBiVgEnFbAV8BXOcilMdKToa0f2F5Nwg2oAlBhHhGQuhcJWxbBckOWNjrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU8YatN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU8YatN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61B5C116C6;
	Mon,  9 Feb 2026 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770655253;
	bh=lARbkbntWGtDhEXk7qoEkyADOxVnx/IfWT0MwbUrRfg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KU8YatN0GgoQMo7vohVj2AM0aYLcVLS/YXu4d+X/qih4Q0bXpBGmIdAQGhd52fL0m
	 AvSZ3CV69yKen1Ps18FYU9lFPKRqYD3TQkCV+jfOmlZJWLpGcu6oaJ+ZMmwHNeDFTb
	 42QL5pAXF9rECbSelJ8TvZ/yvgISxF0oWlekqTNvxZZKtyQQ4HyyG0eqbf+2pWbUnx
	 c3pIlN1X0ZHIwcRvpDDd7P5I9Yh7wabs+2uH/wf7i7xL1qH5PNokxUj5hGvpxiFbz3
	 AKnvuGfyO2wvuXq5cMWa1GhpP4XKSJRqnqtE68gHOzU0heiqQE0Ik6f8E1K1RH/VpK
	 pcTPZqbL46OUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AFA1CE1105; Mon,  9 Feb 2026 08:40:53 -0800 (PST)
Date: Mon, 9 Feb 2026 08:40:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] k[v]free_rcu() improvements
Message-ID: <14281c04-a14d-43ef-8433-a780230838c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <3069e76d-5c7a-4c3f-9b83-43ed1700b95f@paulmck-laptop>
 <aYaTluYIbqt7xSC5@hyeyoo>
 <a49009d1-a0f7-4111-a148-c94fc6e506b9@paulmck-laptop>
 <aYmivqZKklspsa_8@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYmivqZKklspsa_8@hyeyoo>

On Mon, Feb 09, 2026 at 06:02:54PM +0900, Harry Yoo wrote:
> On Fri, Feb 06, 2026 at 05:33:52PM -0800, Paul E. McKenney wrote:
> > On Sat, Feb 07, 2026 at 10:21:26AM +0900, Harry Yoo wrote:
> > > On Fri, Feb 06, 2026 at 04:16:46PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 06, 2026 at 06:34:03PM +0900, Harry Yoo wrote:
> > > > > These are a few improvements for k[v]free_rcu() API, which were suggested
> > > > > by Alexei Starovoitov.
> > > > > 
> > > > > [ To kmemleak folks: I'm going to teach delete_object_full() and
> > > > >   paint_ptr() to ignore cases when the object does not exist.
> > > > >   Could you please let me know if the way it's done in patch 3
> > > > >   looks good? Only part 2 is relevant to you. ]
> > > > 
> > > > On what commit should I apply this series?
> > > 
> > > It's based on Vlastimil's slab/for-next:
> > > 
> > > bc33906024eb Merge branch 'slab/for-7.0/sheaves' into slab/for-next
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
> > > 
> > > > I get conflicts on top of -rcu
> > > > (no surprise there) and build errors on top of next-20260205.
> > > 
> > > Interesting, I don't get build errors when applied it on top of next-20260205.
> > 
> > Here you go!
> > 
> > Here is my repeat-by for these build errors, perhaps a .config issue
> > or difference:
> > 
> > tools/testing/selftests/rcutorture/bin/torture.sh --do-none --do-kvfree --do-kasan
> 
> Haha, thanks! The kernel test robot reported the same issue on the
> weekend. It seems I forgot to include <linux/irq_work.h> and it's
> accidentally included on my environment.
> 
> Adding #include <linux/irq_work.h> in mm/slab_common.c fixes this.
> Will adjust next time I post it, thanks!

Very good, and I will give the update another spin.

							Thanx, Paul

> -- 
> Cheers,
> Harry / Hyeonggon
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > mm/slab_common.c:1475:21: error: implicit declaration of function ‘IRQ_WORK_INIT’; did you mean ‘IRQ_WORK_VECTOR’? [-Werror=implicit-function-declaration]
> >  1475 |         .irq_work = IRQ_WORK_INIT(defer_kfree_rcu),
> >       |                     ^~~~~~~~~~~~~
> >       |                     IRQ_WORK_VECTOR
> > mm/slab_common.c:1475:21: error: initialization of ‘struct llist_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > mm/slab_common.c:1475:21: note: (near initialization for ‘krc.irq_work.node.llist.next’)
> > mm/slab_common.c:1475:21: error: initializer element is not constant
> > mm/slab_common.c:1475:21: note: (near initialization for ‘krc.irq_work.node.llist.next’)
> >   CC      drivers/tty/pty.o
> > mm/slab_common.c:1477:17: error: implicit declaration of function ‘IRQ_WORK_INIT_LAZY’ [-Werror=implicit-function-declaration]
> >  1477 |                 IRQ_WORK_INIT_LAZY(sched_monitor_irq_work),
> >       |                 ^~~~~~~~~~~~~~~~~~
> > mm/slab_common.c:1477:17: error: initialization of ‘struct llist_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > mm/slab_common.c:1477:17: note: (near initialization for ‘krc.sched_monitor_irq_work.node.llist.next’)
> > mm/slab_common.c:1477:17: error: initializer element is not constant
> > mm/slab_common.c:1477:17: note: (near initialization for ‘krc.sched_monitor_irq_work.node.llist.next’)
> >   CC      drivers/tty/tty_audit.o
> >   CC      net/ethtool/eee.o
> > mm/slab_common.c: In function ‘kvfree_call_rcu_ptr’:
> > mm/slab_common.c:2097:25: error: implicit declaration of function ‘irq_work_queue’; did you mean ‘drain_workqueue’? [-Werror=implicit-function-declaration]
> >  2097 |                         irq_work_queue(&krcp->sched_monitor_irq_work);
> >       |                         ^~~~~~~~~~~~~~
> >       |                         drain_workqueue
> > 
