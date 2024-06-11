Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BA376E9
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126567; cv=none; b=Gi9b3HgKeFQwLCvda+IW1hdtGKrOcKlxhApq8P14QoMLFsmKgTWSSfyKpJmkhAvxhKpEZh+i3ScoamcXw8PQNAPcXyONf5aejKTM5N0KI/maD2GSOnevSELJi4C2SOOC3FbnkCHKmqCBfHEudXHHzlgMadeThw+GwxFhrpPNDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126567; c=relaxed/simple;
	bh=0BZ9tFCVBqaCeHphipKneKXZmMFZJlufZ9XAKIAREqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE4gKI/vY0I3yzwzJ2QmV2ZqMo/VaDPp7FzLNKFOtgFIWGZ0YeaxJTW0P12QOUrCREUqqEqcRpMNH0dnLB42cDkqwIM4YhireExChCQ+mx9Av5BLu/ZKGcnYzC1S+SobiyLlfRboTdjwhugZxfipx6uJGN99vAu5XI+PvjJQA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGaylCcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGaylCcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22A2C2BD10;
	Tue, 11 Jun 2024 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126567;
	bh=0BZ9tFCVBqaCeHphipKneKXZmMFZJlufZ9XAKIAREqk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WGaylCcuEOB1jmZ3hoZHsqxpwuA7eykpk34Yg3STpg6SLm4G61iWdT2lQ25uqvZyz
	 6I5Ae4Wy0tK+pVqjDEWp0EcJ4vDazzIdgKh1GSon4XEyFPW4OQLDUQbxLYskbELd9x
	 pwkgvnrJzbmibnnTOVfsgVe5bHBwfgvKylX6Tkxso3PHHI4GoFv6aqa7eMNWOca7IM
	 EjlaLFxIsFiP2TSOncoBYcnpPyOiZmMwXS+hVXka9sOHzNf+w6F/ikJ3hxEb9Ss6UN
	 9YnvpPXEOx+nnJu9BYvAM9dCJS6RVoGCxWJcKTwaObfGatxk75D1s8wKynEh1MiSVM
	 MGcnS2RJSc8lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96436CE0991; Tue, 11 Jun 2024 10:22:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:22:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <02b9e73e-aaea-4885-ab8f-692001ccb756@paulmck-laptop>
Reply-To: paulmck@kernel.org
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

Just to confirm, yes, if an RCU reader was referencing the object being
deleted from the first list, that reader really could be transported
(free of charge!) to the second list.

One (slow) way to avoid this involuntary transportation is to do something
like this:

		list_del_rcu(&ns->list);
		synchronize_rcu(); // drain all readers from ns.
		list_add_tail_rcu(&ns->list, &rm_list);

You could speed things up using synchronize_rcu_expedited, with the
usual downsides.

There are faster ways of getting this effect, but the ones that I
know of involve putting generation numbers on all objects, duplicating
objects on each change, and having readers chase pointers to find the
desired version.  Usually not worth it, but I don't know enough about
this code to judge.

							Thanx, Paul
