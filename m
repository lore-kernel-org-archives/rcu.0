Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11929CFB
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126622; cv=none; b=o3bnv4+nWPkweTvMp6qw+EGC505vYqwvq8Oho8Wz7/XQSqo5XfpcZpx2NS44sMnWFW3hh6XMipV0fzI0tLzkiJGekSgEixkA8G6Isc9hL4F4pYHjmYB7bZAR4xjUtkEH17/YYCcrcdLS7nbJDDWdhGRXBhgkGtzZAv4e14i1jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126622; c=relaxed/simple;
	bh=yCAAL+k9DoPynPR+tH6ZSPC6rw4+MiOX/GQsLpF8lxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+u8n0Y/aKK70Yzrbh7LABIIcbpmgZh+SL1CEg5VTDN5XdEPmYPySWkH9M5ln1GEvDr4fi+Ga+pz3VLsICCkpSEcDLAf7UV+/2qrSS1kSM419sCx3aAmRQqkGip7kRVo0zWL1lTmxRXRzgG4bpdUFHl2pRAz+aaSsCUrIin/bV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEB+/Nsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEB+/Nsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E8EC2BD10;
	Tue, 11 Jun 2024 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126621;
	bh=yCAAL+k9DoPynPR+tH6ZSPC6rw4+MiOX/GQsLpF8lxM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XEB+/NsrE8V724cmb8hxT1FvXdOjfGerGNrt2/DYQtmc+OHeYXE8D5SlqgEZHDEcF
	 uODrXlmI6b7nSjEjl1lLDYny84I1Dhhs8utJJWJIyXRxvxZ9/gBrs7lYYiyC+fJ7g1
	 00r/wBAWj2i8jSA8geVhit/7oygk+ryALA8c+ZJCiBfc4XvI/BMguEbH+5vKZ/CpH/
	 rUnN5n2NKOTZEqZTvLnuBjCTE+0SS0uW+SafBBx4cluOQhYG4GTjb+OwpaSCrVZJq4
	 WlX7rYgt6OSciASb9OhoIwL5T4TQlkPlhLqAqT9kI1QTccY4p7LQHi/GUu4vTg37m1
	 quRC/+3xBrMJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7E685CE0991; Tue, 11 Jun 2024 10:23:41 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:23:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <25b3622f-81e4-403b-8d76-4f67fe8b001e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
 <f93a4963-f524-4ca3-9046-28bc65408721@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93a4963-f524-4ca3-9046-28bc65408721@linux.ibm.com>

On Tue, Jun 11, 2024 at 10:40:13PM +0530, Nilay Shroff wrote:
> 
> 
> On 6/11/24 22:09, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
> >>  	mutex_lock(&ctrl->namespaces_lock);
> >>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> >> -		if (ns->head->ns_id > nsid)
> >> -			list_splice_init_rcu(&ns->list, &rm_list,
> >> -					     synchronize_rcu);
> >> +		if (ns->head->ns_id > nsid) {
> >> +			list_del_rcu(&ns->list);
> >> +			list_add_tail_rcu(&ns->list, &rm_list);
> >> +		}
> > 
> > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > added to the new list before the grace period has completed, we could
> > trick a concurrent traversal into following the new list unless I'm
> > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > low..).
> > 
> > 
> I think we need synchronize_srcu() before we add deleted ns to rm_list.

After we delete it, but yes.

There will also be a window during which the element is not in either
list, but given the name "rm_list", I am guessing that this is OK.  ;-)

							Thanx, Paul
