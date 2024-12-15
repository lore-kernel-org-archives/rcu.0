Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188F145B03;
	Sun, 15 Dec 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286909; cv=none; b=NaurrFXYMEo55Y/uFr4tTzBzzpP0BYRrDJ+FOIoF1pvi9kC6BMKpobH6K8UHSotUwpiIlNRvBFZtidM3qSNpwzZ7Uu+HOMttQEbw5z3GGZWxgLeEtSRV7UDvZeaKJmP8a1cyMY9eewpQrx70zHvla2kBmg1QVjoSnbe/IMg8+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286909; c=relaxed/simple;
	bh=5EDtBQMA0SY/Mward6G4LNnXfp5NhOCmx78jWM35Iws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDYNRkTSzz9DDMMeg2e6xfWUM57rxKOF7OpH2gXGyrsWRKZcfQ090KdgQMSBzON+yEFEX7JjUdeW7KMKIJapjpYG2G2CxlHwqs7Z+v23hpU27TNrL9dMzccKQqCf5/0C5SBHgbo+jhOAlNnmmJc36H5peV4ZhMXFA/bobqW8sMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byGDC8vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byGDC8vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2987FC4CECE;
	Sun, 15 Dec 2024 18:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734286909;
	bh=5EDtBQMA0SY/Mward6G4LNnXfp5NhOCmx78jWM35Iws=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=byGDC8vbEIlBpVc5Rn37v9/BtqAuuaCrrtSpzra+lL+qm83eki5txhLbFfUpCzAvg
	 3qFLRTOnfbfTceH8+413Nm+6g5YyIFJ86IN508jtg4AMAZxvqHAkawbxpAXTt+nXS0
	 V2odkEMS8k4lxrWSmV1zDsl19g1uLcicw4GxXFb7aKDDE1M3kfDg660LrD/M/ChGYU
	 qLMm0uaDvmalXn+KqwBpgbQynJnyJrFcrNmtyV4avw4R4RcaeQb5AKj5AWkvaZenvX
	 CJul0d7jKJOAUhPl4Zwk+bkMYmmSWCLOzV4cE8ffXmewK1Tcdw9ympLcsiwA3aTBm6
	 b6MMKF420DhXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF64CCE09C4; Sun, 15 Dec 2024 10:21:48 -0800 (PST)
Date: Sun, 15 Dec 2024 10:21:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <fe8dc335-dac1-434d-b09b-d0f0fd0cdf2f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>

On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> > Hello!
> > 
> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > here:
> > 
> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> > 
> > The difference between v1 and v2 is that, the preparation process is
> > done in original place instead and after that there is one final move.
> 
> Looks good, will include in slab/for-next
> 
> I think patch 5 should add more explanation to the commit message - the
> subthread started by Christoph could provide content :) Can you summarize so
> I can amend the commit log?
> 
> Also how about a followup patch moving the rcu-tiny implementation of
> kvfree_call_rcu()?
> 
> We might also consider moving the kfree_rcu*() entry points from rcupdate.h
> to slab.h, what do you think, is it a more logical place for them? There's
> some risk that files that include rcupdate.h and not slab.h would break, so
> that will need some build testing...

Moving the RCU Tiny implemention (or maybe even just retiring it in
favor of the RCU Tree implementation) and moving the entry points make
sense to me!

							Thanx, Paul

> Thanks,
> Vlastimil
> 
> > Uladzislau Rezki (Sony) (5):
> >   rcu/kvfree: Initialize kvfree_rcu() separately
> >   rcu/kvfree: Move some functions under CONFIG_TINY_RCU
> >   rcu/kvfree: Adjust names passed into trace functions
> >   rcu/kvfree: Adjust a shrinker name
> >   mm/slab: Move kvfree_rcu() into SLAB
> > 
> >  include/linux/slab.h |   1 +
> >  init/main.c          |   1 +
> >  kernel/rcu/tree.c    | 876 ------------------------------------------
> >  mm/slab_common.c     | 880 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 882 insertions(+), 876 deletions(-)
> > 
> 
