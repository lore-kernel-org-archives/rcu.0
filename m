Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD01CFA9
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126528; cv=none; b=nxXKErtLEq2+0SsDu9+3G0iRU1HxY4oRRxDJyZHXYvSL0b7d3/r8w2RLTEewllpE/TTPuFnitW3ykVaItEPfN7WzMFlbFxlIkXrnKhj+PrqqHShG3awrT6d5dhEaWUR4voW+FXIIXdxAnl7M8iSUmDQnSie9YF4DdQw1JvSvOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126528; c=relaxed/simple;
	bh=OYSPTY6E56yAcssiecMZz3By0s5MpBDcS+5AMxOh6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk63AHavJ8d3smfx68nRNmrdu74vpfkayb5Os/+4m/UdbPE2yI7PVE00Lduw14mK9SVsl2WSnzF17GTu0MTA57z7s5g8G6aqKFNMfO4Vm0rPtbiNiQbHYUYbc8M6AeBxe7OeS2KOEFCQ9odkyKitzba3bX6hYzEuAyjE//380uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRDHzjL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRDHzjL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B9C2BD10;
	Tue, 11 Jun 2024 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126527;
	bh=OYSPTY6E56yAcssiecMZz3By0s5MpBDcS+5AMxOh6so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRDHzjL7D3xE8PUkuGQA4bPQdrvsSMfpEOB+dpCGgk3/h8g7NdmokAEBLs1z06cQV
	 fQoKmLGCEWEs0sKn2J3bAAF0H1+7GWUivdJszHGodzwa0hJf0qu906pWNEBfLjP0VX
	 mQNA7Kd8Ng4FBeJ+j+Kl+nwKBk9PRW1T2T2KvRgqLZxpDnOMJ+JBptXGUu8gmzKtRR
	 k2GBZKj7/6/sxWtTFfPn/EuRQM5xOb3kpef5TEClhRlJpc6pqR5cFeakkvPlTfdvSB
	 OfeAdTyQ/3we+RfM4NwKTSBnThxF8hzBtgjfdK/U20wYszFTlLlsXhLc5A1/F3EyuH
	 q3GWqjilTFP0Q==
Date: Tue, 11 Jun 2024 11:22:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611163955.GA12787@lst.de>

On Tue, Jun 11, 2024 at 06:39:55PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
> >  	mutex_lock(&ctrl->namespaces_lock);
> >  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -		if (ns->head->ns_id > nsid)
> > -			list_splice_init_rcu(&ns->list, &rm_list,
> > -					     synchronize_rcu);
> > +		if (ns->head->ns_id > nsid) {
> > +			list_del_rcu(&ns->list);
> > +			list_add_tail_rcu(&ns->list, &rm_list);
> > +		}
> 
> Is this actually valid for a (S)RCU protected list?  If the entry gets
> added to the new list before the grace period has completed, we could
> trick a concurrent traversal into following the new list unless I'm
> mistaken (although chances I'm mistaken on RCU corner cases aren't that
> low..).

Good call, you are absolutely right that a sync should happen between
the del and the add for readers to consistently iterate this list.

I might be able to weasel out of this though: our namespace list is
sorted, and this function wants to append everything from this element
all the way to the end to the "rm_list": a reader should get the same
result either way, whether if it was torn at this element or the move
happened without the reader seeing it.

Now if there was a way to rcu split the list so we don't have to do it
element by element...
