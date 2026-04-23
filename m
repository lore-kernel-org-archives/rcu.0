Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBB1F3BAC
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909385; cv=none; b=FsyM21JLDynZ16pevGsCn0VKCS7FMkfrsyZPpwGj/2brV+KTSfQ91h+vdMhUyCEFuj34in2wuJKkXRKqTVyXEMnTCC5Dh5CB8Jb8/4rDAK6L87GYBeGrfqZYmSsJMd0i4QhPOQC24SpJ1delsoZIDJVa6qUxSSK1A6GeiLaSEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909385; c=relaxed/simple;
	bh=KAGOUx6yOQBUTWbcJZ5YYD8oZgXKSd/G9nbZorBB8VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbfq8qfNtktqq1Ck+AK2IgX3Z3JJewRPVBkRcrSl++NWJm9LiceNxO5E6ohN2q5JvqRy1+aGWKidY08PNzw/xhXouKo0krIfbLjMXhC3OVOBtKtz5tmXwu+LfK7QzHb6WDGSAyg0lID+uW76WJlyR/n3BbpOKWFv2NRUJIuEAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncJzQNmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncJzQNmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072B3C19425;
	Thu, 23 Apr 2026 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776909385;
	bh=KAGOUx6yOQBUTWbcJZ5YYD8oZgXKSd/G9nbZorBB8VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncJzQNmU8XIhi0yRu9hOCQjgLfDGJEYeL70YBREslC+wBqHUdqZ271/iCXsrfsBWr
	 luJ2YTFRBvf8tWy4agH3WztEDkLqhYe/5JI3b4EXJtt+leCo1yMyp1FQkATADIKigj
	 ad5BBJdJrXZGp0nkyCvSOTCdmZvW6g727Tm91z8aLIUn5aiTv2acVnMVnsD7KOA0A7
	 ZEan9MBbXd8xe+A2aIuqbcB4d2wVxrjkBb5eWGyBALkgDKvN285yTprc4mQ3ogsLFx
	 70mmHSbkGwKf9KIRHN7KmRRVPGLK9JQ4elbEmYD6cyzc0th2nHNmHLNQInHOnkfThn
	 UApdlssqWVN5A==
Date: Thu, 23 Apr 2026 10:56:23 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <ael8R0vOeZ0Xbcoe@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aelxH--hZkCahPv6@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aelxH--hZkCahPv6@hyeyoo>

On Thu, Apr 23, 2026 at 10:08:49AM +0900, Harry Yoo (Oracle) wrote:
> On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
> > As discussed or noted earlier, having third argument and check the
> > entire path with "if (allow_spin)" is not optimal and is not good
> > approach. I do not think it this would be a good fit for mainline.
> 
> I understand that this pattern is pretty uncommon and adds complexity.
> But there is a reason why we're doing this. As Alexei pointed out
> earlier, even rare spikes of irq_work hurt performance [1]; that can be
> avoided in most cases where the lock is not in use. That's why buddy [2]
> and slab [3] accepted this pattern despite the added complexity?

Perhaps we can avoid complicating existing kvfree_rcu batching
(and still avoid hurting performance).

Given that kfree_rcu_nolock() (at least BPF) doesn't need to free
vmalloc objects, we can make kfree_rcu_sheaf() handle most of frees
(slab already knows how to handle allow_spin = false) and fall back to
a simple irq_work as Ulad suggested.

But then we need to make kfree_rcu_sheaf() try harder (currently it
gives up when it fails to get an empty sheaf from the barn).

And I guess the tricky part is making kfree_rcu_sheaf() work on RT ;)

-- 
Cheers,
Harry / Hyeonggon
