Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCC1A00EC;
	Thu, 19 Sep 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755304; cv=none; b=LE4DPymxLQHB7qR4y+pgQxv2F+pIFukBCiEbG10wOsYYLicItVRh7B2QxL1SsQrgzlRNNWy93wF9Ttny7zojsKnPTZZzDUfcQw/TVNDQIYj41csXibXNNWje0l/A4Rka8FdND5xB4VHha3zUW7s9ZDbVvR0oXZTAl9TTrFb4TTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755304; c=relaxed/simple;
	bh=ExQ7E3kBrAtTxCmgFfyf29ldpaZkhlGmTYsCbJAo32k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF6s7PCHuuJX4nZDmclmA3k438GRoLtu/P6QYbDPxUA9Tedo2hHp2p69L3qKihQ2vXMg1346VjlNzVEYbj9Zq5STwlS5yUnkQjrXsLVtIKCvACl4nyxZnB+CKSx673zxkUtUUxVp1GPceN8G0dY11Tn5/MFo0pdLbFvb/c2aubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e3r9tkaZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3r9tkaZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p8px0XxXJF+y3oLJvNMcUJVB3rMlEUk+5pQdljqXFA4=; b=e3r9tkaZ9HmACSX7M3Ar7hX5WJ
	7YR11MqG6xm7ShEcc/4e5i4H4giH2kqflDAZ0gjvB/4Q8a+c7/HTVivzXg4KtN9lkr2xn38Mkm+0P
	+cxt7V3BkWMNHCMljxr9v0gHDm0bvj7gzU2ibdI/pNXPT4xyCPJNGDmmuu9XB4B1sSi/hGJVjznAH
	vzFf4lok3eZmooEa0up5/t8o+Y3ZLQqUWyIrcogDHVSTe2w8Scts4PkHyfZV5jE3jyGwR+Qk9iHEL
	HGTF973aQYGMTW+9yQOHITS9f3GzdAIFCiuojUzIRkRZk6GoBT/By5r9qos5K137zwHkxTAEiyTHu
	hIYCk/8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srHvv-0000000AQDU-1NOf;
	Thu, 19 Sep 2024 14:14:59 +0000
Date: Thu, 19 Sep 2024 07:14:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
Message-ID: <Zuwx409kgivi1G5T@infradead.org>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 18, 2024 at 09:18:43AM +0200, Linus Torvalds wrote:
> On Tue, 17 Sept 2024 at 16:34, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > This series introduces hazard pointers [1] to kernel space. A TL;DR
> > description of hazard pointers is "a scalable refcounting mechanim
> > with RCU-like API". More information can be found at [2].
> 
> Please give actual "this is useful for X, and here is an actual real
> load with numbers showing why it matters".

Agreed.  From the description this would seem like a good fit for
q_usage_counter in the block layer, which currently makes creative use
of percpu counters.

