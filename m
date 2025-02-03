Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC34192B74
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609655; cv=none; b=Du0GRg6dp6l+uspf/VZl+z9lQ2MRpsyIItljoK5h1nEJIm7ePVHBXcKh3atwbRLMfr2O6NWYPAYZmve2MNdrWYGH5n5WFaBK2Nho9Rn34aO7p0MmNjIDMjjWZXCxEBE6ao46M4k60IzT58YVfHo8Hid1WYfm0KxXQze4BihKMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609655; c=relaxed/simple;
	bh=sFECFljIY8hF7UElYtjTLnwB8NoqEp0fdysI/bokdY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgCzQ7BErEKCA4WJx2FxGYMdZz19bIRpMl++iUltN1KiOIpHAR/Dxte5v6o/PZMbvQar0uaPecYXB844vMJERYVaJACrpqMZCF6wb5ugPREVESpJ9OSGenRLQjIg5xrvhoHy52sWUINIsNDtJRPKFg8Mb2DfqmnzWsj6Dht5Y5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erTS1JfU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erTS1JfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCD6C4CED2;
	Mon,  3 Feb 2025 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738609654;
	bh=sFECFljIY8hF7UElYtjTLnwB8NoqEp0fdysI/bokdY4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=erTS1JfURzghn+eQafn/1AmUyM1NIcwS3pRwMpvV3PbK4wu+FLUplWEpFkPV6Gc1j
	 LlPqEm3MRQHM0Lr3mXn+RYf3hx/mjSeLHOyHhInAH3WUAxRRJfA8erImWzwnVNjtsZ
	 2MMQDqYRylPEg9ute5/qbmf3yr7mSMHRVlNMfVM2m8sws+xz6nyiMO5KdOzbg7uw2X
	 tdViHk8GexZ+Pn7Y2ojPky7VqnsZX3jmJUz+XCi5pdaIXw6lRQO0d+mCE9KhMBC1g4
	 jcG//CU65LLyOjG5angJ+ygCmOVKgqYyR6wnprnzHmTszbasePyBaeglFzeUXKhpML
	 JT5yYTgU4ecpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F405CE00C4; Mon,  3 Feb 2025 11:07:34 -0800 (PST)
Date: Mon, 3 Feb 2025 11:07:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/4] slab, rcu: move and consolidate TINY_RCU
 kvfree_rcu() to SLAB
Message-ID: <5ee3321c-417a-4638-8d9e-77faa5f07462@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>

On Mon, Feb 03, 2025 at 10:28:46AM +0100, Vlastimil Babka wrote:
> Following the move of the TREE_RCU batching kvfree_rcu() implementation
> to slab, we still have the simple non-batching implementation in tiny
> RCU, and RCU implementation specific ifdefs in slab code.
> 
> Finish the move and integration into slab. Allow using the simple
> call_rcu() based implementation also with tree RCU when SLUB_TINY is
> enabled, as its goal is also to limit memory footprint with less concern
> for top performance.
> 
> In order to avoid RCU having to recognize the fake callback function
> pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
> a callback that can calculate the object's address from the embedded
> rcu_head pointer without knowing the specific offset (previously SLOB
> would not have made it possible, but it's gone now).
> 
> After this series, AFAIK only the following kvfree_rcu specific code
> remains in RCU:
> 
> - a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()
> 
>   - probably necessary and a generic registration interface would be
>     unnecessary bloat?

I am OK with this calling directly.

Alternatively, you could create a core_initcall() that did nothing
but invoke kfree_rcu_scheduler_running(), and then drop that call from
rcu_set_runtime_mode().  Up to you guys!

> - declarations of kfree_rcu() API in include/linux/rcupdate.h
> 
>   - could be moved to slab.h after checking for/fixing up potential
>     missing includes

It would be good to move them, but no real hurry from this end.

> git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu
> 
> Changes since RFC [1]:
> - Rebased to v6.14-rc1
> - Fixed build errors reported by bots.
> - Changed where kvfree_call_rcu() is moved to in patch 1 to avoid another
>   move in patch 4.
> - R-b's by Ulad and Joel
> - Fix a memory leak in kvfree_rcu_list() thanks to Ulad
> - Various comments' improvements and fixes (Joel, Ulad)
> - Rename config to CONFIG_KFREE_RCU_BATCHED (Ulad)
> 
> Due to changes, didn't keep Paul's Tested-by (but thanks!)

I re-ran the tests, so feel free to add it back in.  ;-)

							Thanx, Paul

> Will include in slab/for-next if no objection.
> 
> [1] https://lore.kernel.org/all/20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz/
> 
> To: Christoph Lameter <cl@linux.com>
> To: David Rientjes <rientjes@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> To: "Paul E. McKenney" <paulmck@kernel.org>
> To: Joel Fernandes <joel@joelfernandes.org>
> To: Josh Triplett <josh@joshtriplett.org>
> To: Boqun Feng <boqun.feng@gmail.com>
> To: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: rcu@vger.kernel.org
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Vlastimil Babka (4):
>       slab, rcu: move TINY_RCU variant of kvfree_rcu() to SLAB
>       rcu: remove trace_rcu_kvfree_callback
>       rcu, slab: use a regular callback function for kvfree_rcu
>       slab: don't batch kvfree_rcu() with SLUB_TINY
> 
>  include/linux/rcupdate.h   | 33 ++++++++++++++++++---------------
>  include/linux/rcutiny.h    | 36 ------------------------------------
>  include/linux/rcutree.h    |  3 ---
>  include/linux/slab.h       | 14 ++++++++++++++
>  include/trace/events/rcu.h | 34 ----------------------------------
>  kernel/rcu/tiny.c          | 25 -------------------------
>  kernel/rcu/tree.c          |  9 ++-------
>  mm/Kconfig                 |  4 ++++
>  mm/slab.h                  |  2 ++
>  mm/slab_common.c           | 33 +++++++++++++++++++++++++++------
>  mm/slub.c                  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 113 insertions(+), 126 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
