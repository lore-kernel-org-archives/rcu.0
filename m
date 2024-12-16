Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B0206280;
	Mon, 16 Dec 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367574; cv=none; b=YfC7ljHSvqstbQxSfBvT55qC6qwj9Z10Pw23QMID2BR09yhb1Y4rhKeMyg6rn2cxgU87BcJzSxKqR/3Qp2vlKIb+vXA/35jxfGSsl7OWOux+QA7DrHlrmonRbiZ+p5XckEfzKVjlZKccJf/ST5VYgDj1HYPD6aaDMJHbQ9JY5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367574; c=relaxed/simple;
	bh=wMjFHCnqbd1orATj6xhaCQkIQextYtaq2hJyyP4ZNRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ1Q8EZYlLlEsFdWaq5Z35ClEz1oSzeE5uqSYdilrjhlM8XbQi/mvhKHkw9Vk4VK0w+ZI5V5xmrnJMKc5fGvaybgIxslfluVlTHfoqcbDumM0ly+ohgqwWvwrigVLuMgyoLvs6PpALgCCf0YIvTEwgEfOEou9gn4sp9s0aoSVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLGcVnQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLGcVnQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C27C4CED0;
	Mon, 16 Dec 2024 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367574;
	bh=wMjFHCnqbd1orATj6xhaCQkIQextYtaq2hJyyP4ZNRQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sLGcVnQsF0yI9WZggA1XT3QI2IYOScA22yZxr8Wqcey6+m+ffDEpH3dtCeaM2iKQf
	 TpvRbU4KV5S41JvMrxpybJTHWIaKDuIG2uYpT5SyTIbWmsjGdQnnXon/MRm8byLOBe
	 m7eKbEHqZ+ilFu3PmcTnHZ3niQclKb5wgZHzhKjr7bU1tgdMFOVnxyUK4GLYkVTLCO
	 POCNbI3dNr9lmCS96zbxlXVS64X4I7XilEkgHTcQZtZLreAdps5uPbKTWgZZ9Anq4d
	 ZrxweBlwncNfj/lEsBl3CLgI28hHb5hjg8jQAJzFCz0SdoILQzmOOL/FgoQh/bNsHT
	 qEvP7j1yDPU/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CADB7CE0C4A; Mon, 16 Dec 2024 08:46:13 -0800 (PST)
Date: Mon, 16 Dec 2024 08:46:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
 <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BNWpkruY6rJv6A@pc636>

On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> > On 12/16/24 16:41, Uladzislau Rezki wrote:
> > > On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> > >> On 12/16/24 12:03, Uladzislau Rezki wrote:
> > >> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> > >> >> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> > >> >> > Hello!
> > >> >> > 
> > >> >> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > >> >> > here:
> > >> >> > 
> > >> >> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> > >> >> > 
> > >> >> > The difference between v1 and v2 is that, the preparation process is
> > >> >> > done in original place instead and after that there is one final move.
> > >> >> 
> > >> >> Looks good, will include in slab/for-next
> > >> >> 
> > >> >> I think patch 5 should add more explanation to the commit message - the
> > >> >> subthread started by Christoph could provide content :) Can you summarize so
> > >> >> I can amend the commit log?
> > >> >> 
> > >> > I will :)
> > >> > 
> > >> >> Also how about a followup patch moving the rcu-tiny implementation of
> > >> >> kvfree_call_rcu()?
> > >> >> 
> > >> > As, Paul already noted, it would make sense. Or just remove a tiny
> > >> > implementation.
> > >> 
> > >> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> > >> implementation with all the batching etc or would that be unnecessary overhead?
> > >> 
> > > Yes, it is for a really small systems with low amount of memory. I see
> > > only one overhead it is about driving objects in pages. For a small
> > > system it can be critical because we allocate.
> > > 
> > > From the other hand, for a tiny variant we can modify the normal variant
> > > by bypassing batching logic, thus do not consume memory(for Tiny case)
> > > i.e. merge it to a normal kvfree_rcu() path.
> > 
> > Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
> > case (less memory usage on low memory system, tradeoff for worse performance).
> > 
> Yep, i also was thinking about that without saying it :)

Works for me as well!

							Thanx, Paul
