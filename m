Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047701624EA;
	Wed, 30 Jul 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903453; cv=none; b=O8Qr5QsGH56u3KysemaYSXHbHdnPcnYnFtJj0Fnj2aDdDPQyMUjnAlaq1mSWCM8gKPVjGDpbNwqTxgCCfB+s9HQNIqlxzJc9stS4SjbhwqlI8hbcdlIXaEwsaMwin/P5nxGIY3L4SIwqPvHJqZDE9hx2leiXgrlACZmadWWtKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903453; c=relaxed/simple;
	bh=PVblrGh8PDkgO1FXZQGU7VfThb9eoQbr+tfN95NR4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnIE+FLYJEktNUmbQZut/IEUiP5rdTWipiJ9nLZNayrDxeLFV6CjIBy+20KTLZZrL8qiqk7vRpzeAY4jDxrNCRPpf3pebT5AWDt75wtE71P7vzOZz6Ym0t9STA/hiSTCm71YPBxqXAIsYtCGKvj5wVnjyr6COPm/+1sC2rgFEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcgZtv2Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcgZtv2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77013C4CEE3;
	Wed, 30 Jul 2025 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903452;
	bh=PVblrGh8PDkgO1FXZQGU7VfThb9eoQbr+tfN95NR4wA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VcgZtv2YQaTbFarcCZghqf5K3hdQFCOkg1VVCSE+GJEaYQOlrZlORtmEqIJ7/zUDo
	 ldJAn4bm6ovij7iQyMZOX1uTSkUPTVdcyQk9poBoSIfUGqFxrvXLWszH1M1B9a4Xz9
	 w12+lpSadkkZL7+ugWiVfbwMKhu/ikFCvMeRkbsi0fDPjjtYH5L4270yY9Fnk8FT//
	 wHC1fK+xBOfHyZ7vK+QTTUrYPu8gwuhwndaww6zI1Vw3ZeQg2Bpb7jLZZ3cKcYp9xt
	 N4lW9ZKrxouivTKRT+KrA1WaD0RgusQxy6gaH0ScUErVyFOV3jpMNgv0I2hvLAw+PZ
	 SJPddZp9SkLBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 163BCCE0B1C; Wed, 30 Jul 2025 12:24:12 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:24:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, joelagnelf@nvidia.com,
	frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rcu@vger.kernel.org, Tze-nan.Wu@mediatek.com,
	a.sadovnikov@ispras.ru
Subject: Re: [GIT PULL] RCU changes for v6.17
Message-ID: <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250726024605.GA17131@neeraj.linux>
 <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>

On Wed, Jul 30, 2025 at 11:11:43AM -0700, Linus Torvalds wrote:
> On Fri, 25 Jul 2025 at 19:46, Neeraj Upadhyay
> <Neeraj.Upadhyay@kernel.org> wrote:
> >
> > This pull request contains the following branches:
> >
> > rcu-exp.23.07.2025 [..]
> 
> I've pulled this, but I do have a request (or two, really)..
> 
> The octopus merges look cool, but they have the problem that if there
> are subtle bugs introduced by interactions between branches, they are
> a pain to bisect. So in general, I advise people to avoid them.
> 
> But the *real* thing I note is that merges are more subtle than normal
> commits in the first place, and octopus merges are subtler still - and
> your have no explanation at all outside of the 'merge X Y and Z into
> ABC'.
> 
> Please write more of a commit message explaining what those branches
> *are* that you are merging.
> 
> Which is the second part of the request: when you ask me to merge "the
> following branches", the branch names are basically line noise. I'm
> not in the least interested in seeing what the date of a branch is.
> That adds no value.
> 
> So can you please instead describe the branches by what they do than
> by some internal branch name you used. I made up my own "names" for
> the sub-branches in the merge message, but it would be much nicer if
> you did it in the pull request.
> 
> So, for example, I changed "rcu-exp.23.07.2025" to be "Expedited grace
> period", which seems to be what that branch name was cryptically
> trying to say.

Apologies!  I missed the empty merge-commit commit log when reviewing
this pull request, and I should have spotted that.  :-(

As it happens, I will be sending the pull request for the v6.18 merge
window, so I will stop doing my usual octopus merges (hey, they *were*
cool!) and instead merge each branch separately, with each merge's commit
log giving a synopsis of the commits in the branch being merged.

If you have a best-practice series of merges example in mind, could you
please point me at it?

							Thanx, Paul
