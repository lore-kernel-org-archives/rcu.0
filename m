Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09214248F57;
	Mon, 20 Jul 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559424; cv=none; b=DVwgzLZfRQHoBiOgL28XiPlvqmwybDn6l0KIZcSQDLymRe8tzHQo87BGGguDintjHt50lg8SEoh5zqolTHpFrvidGfYoybJGMqQ7sE3ZbB1n5Hjvkvc9g4OAKSbTjKs1CjCpOHxvd+SPWidbWlzM7EO507YroCmzGwAARZk3eWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559424; c=relaxed/simple;
	bh=zUL9F0pXE28ksBEQdphSXw/4TTl80s4PxKR4gzui+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgXWKkBKYzPQGLoxYqIEKr/EbEXko4UidQsUxY1JJm78RObeinyIeh4/+k3OeA5ZHPvwygTt1IPyzmvqQvOQnHT9niSB4WVvAyWaZOLv9BrjRcsKw9KRnl7xS1MHMcUJUDmetYcFjViR24QgEh/Zge5ZSx2uHLdTt0YM/lmrVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J04eXS7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J04eXS7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D021F000E9;
	Mon, 20 Jul 2026 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559422;
	bh=yV/RjTZGvwpOixLwQnWs6XWvha2ncSvJ7+KeUmUdb04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J04eXS7UgUw/JKq3MtTSs49wj1BmdJSv2x7zhQzNaYb1CI/QdbLUDZUu5/fzs81UD
	 FLNKO0W8+eQR42OqOHZdKwoOPoW/EgpXAe4FvtHb+008RFP862fYuPZKqAgntnY8Bb
	 zSD4OQbNq39KJXFIyxmXDyCXs6wPA5AsC46d0Oyr75x/NWZ905n5GCHBbckHGL7gVc
	 D5uWA24eiQ0StKh3IDmBpzcR9gJwP18NaRemD0GKzAfQrm7z/KaeKz3e/Iy2J51yCD
	 vFSmohwFn2QlvW/kYcZOcQAWI1yDKeHAQVusT88nYXSUNXuz/wr5z8+8EJmq8E8HD5
	 P2gBZHKQi3b8g==
Date: Mon, 20 Jul 2026 16:56:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 07/11] rcu: Update comments for gp_seq and expedited
 GP tracking
Message-ID: <al43O05On8W2xv4_@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-8-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-8-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:49AM -0700, Puranjay Mohan a écrit :
> Update documentation comments throughout the RCU callback infrastructure
> to reflect the transition from a single grace-period sequence number to
> the full struct rcu_gp_seq that tracks both normal and expedited grace
> periods.
> 
> The ->gp_seq[] array documentation in rcu_segcblist.h is updated to
> describe dual (normal and expedited) GP tracking.  The
> rcu_segcblist_advance(), rcu_segcblist_accelerate(), and
> rcu_advance_cbs() comments are updated to refer to the struct rcu_gp_seq
> state (gsp) instead of the old bare grace-period sequence number (seq).
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
