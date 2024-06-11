Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C6482ED
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127835; cv=none; b=kghKtBphmvLN8mwQU46RFM6MMnWzsM6GYSDk/ylgcBiqh0uKaftq2YT0iCRMxM91DrSYQ5Ru+wtyH7xMXYldceXY1ABfEYY6mm5/KfiWQq1J2xLKq2PdzrGAI3ec8dJPfcvOU88ZJfEhzBBLffwqgvsd1W3ykQ//K4er5NrqnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127835; c=relaxed/simple;
	bh=ckh65J4ZDXHqdYOWkbEuepLYJ8V0wRSgS5E79Dm0Kh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEjQTKsHJTvrB0z2pTcXfJigmg5cjv6YtGNwkJ0TVR8ovms6YrfR9dvqxQ6nJeKpTjVnh6RkbJk5FeVfQZ1olp+7WTyDcdpfO/i52AjKQ6XJCLJHket0KmYnaCWiI5u61b4vpNobhUn+81i9wqG16jsccv4n6jxPIEc/tQRrvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZCADHux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZCADHux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F091FC2BD10;
	Tue, 11 Jun 2024 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718127835;
	bh=ckh65J4ZDXHqdYOWkbEuepLYJ8V0wRSgS5E79Dm0Kh0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MZCADHuxHShUbBVFGWbK1LFY6Xly3X1ALb+w3ew3wgEVPn5hlI5LpwIdTlFdGkmNA
	 jwZd1dBoRsqeNJjnT62UUEta/+FCoagQLhxFEbAmzsFP6RYw/ZRaTU7l1VaPkHHkP5
	 hFNFY5eTFuvummQbOTC/a2oK57Xh89/imv3nzdEySQUbp7qKPwTD+DYb8YogYnOFK2
	 bO62meGPxxFLOm+XRGF+tMw4v9pMAG7Xwup3NmQzMwZGpC8v4f0A/iEO0kgaTxt6uy
	 NQUmLrJppLQ902+qbmi5qJ8XaS21Ac4eAn7aVy91wIWgUWHs/jz2G8ZkSybdPXwacK
	 dWnY5AMl8r3iA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BE64CE0991; Tue, 11 Jun 2024 10:43:54 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:43:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <5339a82f-33c0-445d-91be-1ab8d8f39dd4@paulmck-laptop>
Reply-To: paulmck@kernel.org
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

Almost.  They move the whole list and Keith wants just part of it moved.
It should not be hard to create such a thing, and Keith said (offlist)
that he would like to give it a try.

							Thanx, Paul
