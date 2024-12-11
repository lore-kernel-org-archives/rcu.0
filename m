Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E91F8681
	for <rcu@vger.kernel.org>; Wed, 11 Dec 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960675; cv=none; b=J45Pakt/iFnzlkiNmtwRSkXrGSj97cA8pXG+xubgR5lP7ErALS7GEoOcom+PDQjPdsvz6bbqKf5JTK+o8Lw5JT4BMDWPaV03bmclKzoHGbByZKuPAhphTM5Q2ubgQr3hPdk+9ta0JbQAa/7VaeSRvuwh1vbwEGqsXNncVHfqj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960675; c=relaxed/simple;
	bh=2t+f8zJQRyIjQQMVRTpUsVVy7tp23fh/bMiubquXtJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX8gA+d0IuD5lMVW26swiwn2BKIP0Ul38kgUHnSlLyUgYMqZ0LRQlSp6XkQgiZT7c9MQYIFuUxej97hoqOojI+nDfJZ/K3qj9ykIhfLLXI4LPKAhsd49ZIB8R7Zb+agdtLmK2VzPPlvz/N1/SiWkrIxqWAyH7Eyb81/85UVsyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZfd+tpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZfd+tpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C0DC4CED2;
	Wed, 11 Dec 2024 23:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733960674;
	bh=2t+f8zJQRyIjQQMVRTpUsVVy7tp23fh/bMiubquXtJE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iZfd+tpYehWEcjgY0C7riGQxr3CGP1G4YIPjNZ50dSetIebWpNb2B8MQcQEKJVXQE
	 nidlKcVD0nLbZ/ULEQz6ASizy4PoGZEkiff7XeY2VHZ0DXE1ai+NmtC0VKgodQQTd4
	 pbogWtn0elmBjrdYL4JU44tZk9qqM9lynUaODckzHmVucdRZusjkvQ4qcymhEJMxp+
	 LQhqcGRSV/aGI3ubEKGaFdEvtN3TeWJdRTkzxt+e6zpTKNKQVZs0wXZ17ugbjYqegi
	 5XJtN/5OeP+sarVAR18LhYH2kUuTDRdNz9gg3a/MBTUKRPNo//9LuGhZVovjpZD+BY
	 Q9qslJx2JH11Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8101DCE08E6; Wed, 11 Dec 2024 15:44:34 -0800 (PST)
Date: Wed, 11 Dec 2024 15:44:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: Why is there no list_prev_rcu()?
Message-ID: <10cf9752-8991-405e-8ce6-589a306e3116@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <kq7lbvk7naxkx4m7mg3bg3dhx6v5py2jinzh33lqusae5n2x7q@hwrfbwlpsbfs>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kq7lbvk7naxkx4m7mg3bg3dhx6v5py2jinzh33lqusae5n2x7q@hwrfbwlpsbfs>

On Thu, Dec 12, 2024 at 12:25:42AM +0100, Christian Brauner wrote:
> Hey Paul,
> 
> I have a rather dumb question...
> 
> I'm keeping a very boring:
> 
> static LIST_HEAD(mnt_ns_list);
> 
> of mount namespaces. Userspace can pass a file descriptor for a mount
> namespace in that list to the kernel and then open a file descriptor to
> the next or previous mount namespace.
> 
> As I was working on that I found list_next_rcu() but no
> list_prev_rcu(). Which made me curious and then I saw the comment in
> commit afa47fdfa29f ("rculist.h: Add list_tail_rcu()").
> 
> /**
>  * list_tail_rcu - returns the prev pointer of the head of the list
>  * @head: the head of the list
>  *
>  * Note: This should only be used with the list header, and even then
>  * only if list_del() and similar primitives are not also used on the
>  * list header.
>  */
> 
> That comment strongly suggests that list_prev_rcu() somehow isn't
> generally safe to do? Is that the case and if so why? And what are
> possible ways to safely get to the previous list entry under rcu?
> 
> (I'm currently doing this in an rbtree via rb_prev() and rb_next() but I
> can't do either of those locklessly which is why I want to keep a list
> in parallel as well.)

This is a design choice.  It would be easy to create an RCU-protected list
that allowed readers to iterate in both the ->next and ->prev directions.

Why the forward-only restriction?

Because most use cases only need to traverse forward.  Prohibiting
backwards traversal permits list_del_rcu() to poison the ->prev pointers,
which arguably makes for better error detection and debuggability.

If you need an RCU-protected bidirectional list, one way to supply
one would be to add list_del_bidir_rcu() and list_prev_bidir_rcu()
to the current list_head API, with the former dispensing with ->prev
poisoning and the latter adding rcu_dereference().  Note well that
p->lh.next->lh.prev will not necessarily be equal to p.  This is because
there might have been a concurrent insertion or deletion, which would
instead result in p->lh.next or p->lh.prev, respectively.

One alternative is to supply a different list_head structure that has
a full API.  But unless there is a strong reason for exploding the
API in the manner, adding the API members mentioned above seems like
it would be a better choice.

But in that case, there might need to be some sort of debugging features
prohibiting use of list_del_rcu() and list_prev_bidir_rcu() on the
same list.

Do you also need reverse-direction list iterators as well?

Details aside, it is eminently implementable.  How would you like to
proceed?

							Thanx, Paul
