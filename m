Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F23009D4;
	Wed, 29 Jul 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351525; cv=none; b=kw0nFgTqxE9KzNswBIC9shRz/wlrOJtngMozfFcVrOVnC6KCoGGd1RWZqXDxv8G+vJlN6j0I7ZovU/BaBkXTG8BWyFD+QmJ5pXDXfL/Ug5r9anbTGPWhiWMbmZVHmvKr0UT4UcKrYB8xD5wjSiNVCxH8d+6wOCID3rAHpnSyUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351525; c=relaxed/simple;
	bh=JXWk+YLpfVA6o+Q2oCEhdWcvKVMwp3SFMgqxNpS5h30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBHcyTtITQ865SeZUznXULVceSSCe7ULK5ozzMV1LlR5JAlIMPNjVeeiT6Z6h1jgKBisOmkwlOHlawEji23UW/kggVKwxE9PXCNUPeZuCeQWkrXcUcb74k/iKp/KHvwnZYPf7mHfgORZT5UDJhO+2UanvmI9thloo82SSNs3z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RupjfiUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RupjfiUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD61F000E9;
	Wed, 29 Jul 2026 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785351524;
	bh=a7xQnZiq/bBhFVL1TMInPD93nGWgpZ8+XaCM3fzGCUQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=RupjfiUe9ot/VVh0BFkPolgJigl1mNHSVogjNJPzkceLbZcRO3tKy5t9rAn8oX4Ff
	 bosOwYXIXIPZk1rXLh8hwj29hinId2E8M9thaTarxrCct/OOnl43VnXUGwEcNje7dw
	 R/XdnOwJmQVuHfrcNuO1lvf/YWZb+0MxAq2FRspnof3XBtz24l8AcyjrhtFATGF+eK
	 N50fEXvs4//aoienjBWZqLrLwkTApIP2AhfmpKPYO7zjkBm8m2p+dlUDQ7VxYWYY4L
	 69S/bls7q2q4aX5G5yINLBtAygomTF368kXXrKMNUHrft4y11HNuHvGXm3EDcqj/zu
	 nRaeFxH45/vkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05987CE0B67; Wed, 29 Jul 2026 11:58:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:58:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>, Timur Tabi <ttabi@nvidia.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v7 3/5] rust: sync: Add abstraction for rcu_barrier()
Message-ID: <f680fb1b-ecbc-47b4-a252-b792933bfe3e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-5-phasta@kernel.org>
 <296c71c4-4d2f-416d-bfbe-40fd911b44db@paulmck-laptop>
 <DKBA29HOEUIX.H4CDPOQQXRD0@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKBA29HOEUIX.H4CDPOQQXRD0@garyguo.net>

On Wed, Jul 29, 2026 at 07:47:46PM +0100, Gary Guo wrote:
> On Wed Jul 29, 2026 at 6:18 PM BST, Paul E. McKenney wrote:
> > On Wed, Jul 29, 2026 at 11:45:40AM +0200, Philipp Stanner wrote:
> >> rcu_barrier() is a frequently used C function which is always safe to be
> >> called.
> >
> > Just checking...  Here "always safe" means only from task level, with BH,
> > preemption, and interrupts all enabled, correct?
> >
> > In contrast, if you do this:
> >
> > 	preempt_disable();
> > 	rcu_barrier();
> > 	preempt_enable();
> >
> > the results won't be safe.
> 
> This is same for all sleepable functions. In order to avoid having to mark all
> sleeping function unsafe, we've decided that sleeping from non-preemptable
> context is "safe", but is a bug regardless.

Got it, thank you!

I tried to resist parameterizing "safe" over things like execution
contexts, but obviously failed to do so.  Besides, there is a name for
that sort of thing, and that name is "precondition".  ;-)

Adding Julia Lawall on CC based on her recent work with preconditions,
which might be an act of kindness or of vandalism.  You guys get to
decide.  ;-)

							Thanx, Paul
