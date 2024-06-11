Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D31376E9
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126698; cv=none; b=DWz2Si1KLdFuS/N8qNiS9pY2ZWWz9OdiaDoDmWMku3W7jtBKUecjcg8toneN7CKPCidGVV/aPuZvMRWlPr+Upoi65lQOZxtOevIgy3rAqkdQH1tttrxHaEP9/9jTbziAp09EAYuMgW2NDfDiPrp1Lf6OiPkoqtiR/SvlV9r40Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126698; c=relaxed/simple;
	bh=f+69Jw51lpx0FB8ijAkCD57nC3csI7zsqGRAMnBb1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAJxcTCJetKOwhmPU2gIE0uS3GVvfVJzsw0e8WT14ZPrsDMrdLqBm+e5+Ot0vF8zeiVEhbBeO8dPi4ixBPQRpvSBNtR3er/zZN6bqy4NZ+zTz8OE0GFYdraflydziRPxyJaAYhel5LG1xlvD1aSo4dLIZSqum6fFwZCqEMojbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAAE868BEB; Tue, 11 Jun 2024 19:24:48 +0200 (CEST)
Date: Tue, 11 Jun 2024 19:24:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <20240611172448.GA13680@lst.de>
References: <20240611152055.2317197-1-kbusch@meta.com> <20240611163955.GA12787@lst.de> <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 11, 2024 at 11:22:04AM -0600, Keith Busch wrote:
> > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > added to the new list before the grace period has completed, we could
> > trick a concurrent traversal into following the new list unless I'm
> > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > low..).
> 
> Good call, you are absolutely right that a sync should happen between
> the del and the add for readers to consistently iterate this list.
> 
> I might be able to weasel out of this though: our namespace list is
> sorted, and this function wants to append everything from this element
> all the way to the end to the "rm_list": a reader should get the same
> result either way, whether if it was torn at this element or the move
> happened without the reader seeing it.
> 
> Now if there was a way to rcu split the list so we don't have to do it
> element by element...

Isn't that exactly what the list_splice helpers do?  We'd just need to
do that exactly once at the cutoff point and not once per namespace.
