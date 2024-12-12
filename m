Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BE158DB1
	for <rcu@vger.kernel.org>; Thu, 12 Dec 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003969; cv=none; b=uaPIrd+loxTFGBL8VjNTlXBc35EQDU6Qu9i6Plv8XcaIRRHrhVbsto/vV+xCOqaTW0ZPMUAZAq7mkY7tCVI6WX7VFK8ija8ux33ke+vV4sCnFxqt5/ZPQq3rOHRDtjzfv5rBFJmrXzeguWrTBBjO+2EPQ1QDcpDqp3KS8IQz+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003969; c=relaxed/simple;
	bh=wWq6ps3CnkBR48lrSrsX2RdyMWxJHYlnb34ZdixUeNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0lAXDpcMhWNg8AG7qpDn8FRX2Pre3FdlwffVfLZEhHlzpGPbkk4NapSQG1y9hvQghFo+ktKGg1wCbJhbRYpsHy6OONn53jzxC2U35f76JqHXUlygQu/AXjE/jsi27r13t9QryhrnGF4feVbbX8HssrYlH8AoLqkz83urD11Iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7b/2hG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7b/2hG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C5DC4CED4;
	Thu, 12 Dec 2024 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003968;
	bh=wWq6ps3CnkBR48lrSrsX2RdyMWxJHYlnb34ZdixUeNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7b/2hG9svmcfcYB4Oy+D+4NnElwSXyE2LzhtGBjIbyrW7OhsX5+Ya2DGMLjqf0g+
	 isvymSPpprJH4T0DRCGfG8T4Xbl35Zltj83qzF0StFAKJaiBIGlC6SPsQjGXa2+sjy
	 8YgwiUmp4zaQDSjXNRXOL/oea69wME76QwLFdYn1vqROc3N6oQ+WnplWGo1KthbC2Z
	 lQclLzBt6hOA+7nhbCpvPDKftPEg1WKCUTcTukPU9F0Du7bLAC/hSRaqcJALbizlUG
	 ERNBZEzQJVgfrHkyL7NixtJwUU5yKC7R62qGrSN0kQWfxXVnWiCTLYSD0zNgNsx/jE
	 JQbFgCULUQ02g==
Date: Thu, 12 Dec 2024 12:46:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: Why is there no list_prev_rcu()?
Message-ID: <20241212-brotkrumen-lehrveranstaltung-bb6c78ea0c83@brauner>
References: <kq7lbvk7naxkx4m7mg3bg3dhx6v5py2jinzh33lqusae5n2x7q@hwrfbwlpsbfs>
 <10cf9752-8991-405e-8ce6-589a306e3116@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10cf9752-8991-405e-8ce6-589a306e3116@paulmck-laptop>

On Wed, Dec 11, 2024 at 03:44:34PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 12, 2024 at 12:25:42AM +0100, Christian Brauner wrote:
> > Hey Paul,
> > 
> > I have a rather dumb question...
> > 
> > I'm keeping a very boring:
> > 
> > static LIST_HEAD(mnt_ns_list);
> > 
> > of mount namespaces. Userspace can pass a file descriptor for a mount
> > namespace in that list to the kernel and then open a file descriptor to
> > the next or previous mount namespace.
> > 
> > As I was working on that I found list_next_rcu() but no
> > list_prev_rcu(). Which made me curious and then I saw the comment in
> > commit afa47fdfa29f ("rculist.h: Add list_tail_rcu()").
> > 
> > /**
> >  * list_tail_rcu - returns the prev pointer of the head of the list
> >  * @head: the head of the list
> >  *
> >  * Note: This should only be used with the list header, and even then
> >  * only if list_del() and similar primitives are not also used on the
> >  * list header.
> >  */
> > 
> > That comment strongly suggests that list_prev_rcu() somehow isn't
> > generally safe to do? Is that the case and if so why? And what are
> > possible ways to safely get to the previous list entry under rcu?
> > 
> > (I'm currently doing this in an rbtree via rb_prev() and rb_next() but I
> > can't do either of those locklessly which is why I want to keep a list
> > in parallel as well.)
> 
> This is a design choice.  It would be easy to create an RCU-protected list
> that allowed readers to iterate in both the ->next and ->prev directions.
> 
> Why the forward-only restriction?
> 
> Because most use cases only need to traverse forward.  Prohibiting
> backwards traversal permits list_del_rcu() to poison the ->prev pointers,
> which arguably makes for better error detection and debuggability.

Aha, thank you for the explanation!

> 
> If you need an RCU-protected bidirectional list, one way to supply
> one would be to add list_del_bidir_rcu() and list_prev_bidir_rcu()
> to the current list_head API, with the former dispensing with ->prev
> poisoning and the latter adding rcu_dereference().  Note well that
> p->lh.next->lh.prev will not necessarily be equal to p.  This is because
> there might have been a concurrent insertion or deletion, which would
> instead result in p->lh.next or p->lh.prev, respectively.
> 
> One alternative is to supply a different list_head structure that has
> a full API.  But unless there is a strong reason for exploding the
> API in the manner, adding the API members mentioned above seems like
> it would be a better choice.

Yes, I agree.

> 
> But in that case, there might need to be some sort of debugging features
> prohibiting use of list_del_rcu() and list_prev_bidir_rcu() on the
> same list.
> 
> Do you also need reverse-direction list iterators as well?

No, I don't think so. I just need the ability to walk somewhere from the
middle but not the whole list from the end to the beginning... yet... I
don't want to make promises I can't keep. :)

> 
> Details aside, it is eminently implementable.  How would you like to
> proceed?

I will try and add list_del_bidir_rcu() and list_prev_bidir_rcu().
I'll Cc you on the series.

Thank you, Paul!
