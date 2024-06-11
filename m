Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E802570
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128027; cv=none; b=D/osf95wr3FgVaV+dk2ymssEulRSA67GeXxgfnbF9zLXyAcwxAJxrb/uhzo/XqTglRO+FTJPvwmpmWQT3YrUqp4GyqP5L8xtq85tgJeoZv6JT7a3wzpEaoZ1kj2uLivWca1jXR5nIKojUuepKHkGkryPXPCf90C3iX7jy2r65D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128027; c=relaxed/simple;
	bh=36T2K9aFkBfiAZcwV3STRai8NPf570te/8GleiFFim4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIT4vn772xrKhJzdUHAo6I8ibklIYo3a211FKv5UGi3fEhW8WKGD6VtU0/75ZkPoCWyrYuC9oky1t9kdrPXbkdTPccmF5NrTJ4/vL3lxWucBnyFoFQ+VdMUNsuk/yuUISi6FP2i07ykUbdel+ZYu9meASQbgLFsH9eFbcEF1ZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kydNF9Ss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kydNF9Ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F4C2BD10;
	Tue, 11 Jun 2024 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718128027;
	bh=36T2K9aFkBfiAZcwV3STRai8NPf570te/8GleiFFim4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kydNF9SsJ80vSZCuiiCkZuUDwKJZucbSmr9Y3AlI20saZg1IuJDZzKD2QBbt4Vs8d
	 Eu2Bk08iwefcQgQSA+mqlgEgYHt4DSKFphr0xrPzyjSgn9P9LLT4uX8ihJu+Rknyjg
	 DmP4Zyw6MppFIOijpkeGQqXp+6xBWtgC3P7OWTR0rCold/FyGzYfFG9mw/4cYGnkei
	 +e/+NyD68x47FfQf3pqHPTQNbxU7F9ax+JLKhn12YYSkgBeEfq9pzQVDc5YCE7Opb+
	 nHwgHjXABXCZuU/DX3frnP/NxSs+VrALqgZXjnhKcda2mI77dSmE4Q3c1Z1MOpbzZY
	 aahWPTm+4Db6Q==
Date: Tue, 11 Jun 2024 11:47:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <ZmiNmIPLom4NFhkY@kbusch-mbp.dhcp.thefacebook.com>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
 <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
 <20240611172448.GA13680@lst.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611172448.GA13680@lst.de>

On Tue, Jun 11, 2024 at 07:24:48PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 11:22:04AM -0600, Keith Busch wrote:
> > > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > > added to the new list before the grace period has completed, we could
> > > trick a concurrent traversal into following the new list unless I'm
> > > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > > low..).
> > 
> > Good call, you are absolutely right that a sync should happen between
> > the del and the add for readers to consistently iterate this list.
> > 
> > I might be able to weasel out of this though: our namespace list is
> > sorted, and this function wants to append everything from this element
> > all the way to the end to the "rm_list": a reader should get the same
> > result either way, whether if it was torn at this element or the move
> > happened without the reader seeing it.
> > 
> > Now if there was a way to rcu split the list so we don't have to do it
> > element by element...
> 
> Isn't that exactly what the list_splice helpers do?  We'd just need to
> do that exactly once at the cutoff point and not once per namespace.

Not a splice since that takes the entire source list; this usage is more
aligned to "list_cut_position()", which doesn't look rcu safe as-is, but
I think we can make one!
