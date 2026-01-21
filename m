Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90815318BBC;
	Wed, 21 Jan 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020688; cv=none; b=agySlCCALeLi0zoXm11NNr6hilX9Y6QtOfctNdMXUOvJUnQcveCr5uk5h/wJlayqnyx0eEmfNUYmzz1wHKJYN4Pq+POHCgfltA6Bg3XJbB7DE6mL4Ow1I2a7vjhHWFtFZGJ5xZVwR+HbGjsEXLnvEw4t6x7CNN8rCEhRledNbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020688; c=relaxed/simple;
	bh=1hh4ex1uDE6widfQ/8EJAr1hxwctCfZZuy9aDzidOUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leohu3kEIdlPpQaHg5aUeyGJAGQ9k6Zkfrh8ab6PQ3Wxb+7l1GqEoybag+r951SywNJw/TkgnuVWPor521Jw5gI3DYUW95fjgiaPVwaWekXjsqcXCWY2GJgNtDKK4ui8hyVrRcSe78cXaQu8M4SwofGc2tob78BcqixVE8Ig4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MegpK9gs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MegpK9gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBBC4CEF1;
	Wed, 21 Jan 2026 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769020688;
	bh=1hh4ex1uDE6widfQ/8EJAr1hxwctCfZZuy9aDzidOUY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MegpK9gsVtYVh4R0tEQBj55SnWzqUincnli9RSKL3/Njw0EQvPdKkdqaYEMDEaadk
	 yvQw2P5P6XJTY7KPskg3zSVDoBcBCcXZfADOx8rR7245xMP82speBsUjUcA+Ztq8DN
	 AEyM3lPUGEjGTW8XwgpDPyw//3BvJ2V48gdLo9qwT1BCZ1yJEQaFXjeMc8rGkUaps4
	 nTBzZOYSwYHqFhMCDTpkQ5uBo/qNFZTBIStg/rOeDvAJaHOiD6pQjQCzciHFhJIyTz
	 zvd+Lv71sYyuv84IqXXdhiI35gmFA1fipY0QcBulzm0xniQtlgmR0oNcxk+1jE/VJg
	 GVV06RrmP6aTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9900ECE0B2B; Wed, 21 Jan 2026 10:38:07 -0800 (PST)
Date: Wed, 21 Jan 2026 10:38:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
Message-ID: <15c256da-a1cf-4b7f-bd60-10042a8e9fea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local>
 <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local>
 <aWuKqLERqpNz9qtz@google.com>
 <aWuV858wU3MeYeaX@tardis-2.local>
 <aXDCTvyneWOeok2L@google.com>
 <aXDRHerRiM7TzACy@tardis-2.local>
 <aXDS6rNbsWhDVGK9@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDS6rNbsWhDVGK9@google.com>

On Wed, Jan 21, 2026 at 01:21:46PM +0000, Alice Ryhl wrote:
> On Wed, Jan 21, 2026 at 09:14:05PM +0800, Boqun Feng wrote:
> > On Wed, Jan 21, 2026 at 12:10:54PM +0000, Alice Ryhl wrote:
> > > On Sat, Jan 17, 2026 at 10:00:19PM +0800, Boqun Feng wrote:
> > > > On Sat, Jan 17, 2026 at 01:12:08PM +0000, Alice Ryhl wrote:
> > > > [...]
> > > > > > > 1) "relaxed atomic" does not sound like something that provides an
> > > > > > >    address dependency to me.
> > > > > > 
> > > > > > If you look at rcu_dereference(), it's a READ_ONCE(), which is the same
> > > > > > as a relaxed atomic load, and yes in LKMM, relaxed atomic load provides
> > > > > > address dependency (Please see the DEPENDENCY part in
> > > > > > tools/memory-model/Documentation/explanation.txt).
> > > > > 
> > > > > You argued that we should rename READ_ONCE() to atomic load on that
> > > > > other patch series because "atomic load" naming is better than what LKMM
> > > > > normally uses. Fine, but relaxed atomic load is a much worse name than
> > > > 
> > > > To be clear, in that series, my argument was not about naming, it's
> > > > about READ_ONCE() being more powerful than atomic load (no, not because
> > > > of address dependency, they are the same on that, it's because of the
> > > > behaviors of them regarding a current access on the same memory
> > > > location), and we want user to specify the intention more clearly.
> > > 
> > > Expressing intent more clearly is fine with me. I still think it's weird
> > > for us to not have READ_ONCE() when it's a primitive operation of our
> > > memory model, though.
> > > 
> > 
> > But in our memory model, it's exact the same as atomic_read() (see
> > tools/memory-model/linux-kernel.def and search for "atomic_read"), so
> > why do we want to have both? ;-)
> 
> I've been saying Rust should have both because I've been repeatedly told
> that they are different. If READ_ONCE() and atomic_load() are the same,
> then I retract my concern.

I confess some bemusement on the allergy to READ_ONCE() and WRITE_ONCE().
However, we have a similar thing within the Linux kernel.  READ_ONCE()
is the same as atomic_read() from am memory-ordering perspective,
and WRITE_ONCE() is the same as atomic_set() from a memory-ordering
perspective.  The difference is typing.  READ_ONCE() and WRITE_ONCE()
will eat anything, but atomic_read() and atomic_set() insist on pointers
to atomic_t.  There is also atomic_long_t and atomic64_t, just in case
you want more API members.  ;-)

							Thanx, Paul

> > > And I also think we should consider using an implementation along the
> > > lines of what I shared for our atomic_load() or READ_ONCE() or whatever
> > > you wish to call it. The perf impact of helpers makes me sad.
> > > 
> > 
> > I'm not totally against that, it'll actually help Atomic as well, I also
> > hope that we can use `asm!()` to implement the cases where
> > `{read,write}_volatile()` cannot cover. However currently I would rely
> > on helper inlining to resolve this to avoid duplicate implementations.
> 
> I'm in favor of using helpers to begin with. I think it's probably worth
> to do atomic_load() before we do the other ops, since it's so much
> simpler to implement that particular operation than the ones using asm.
> 
> Alice
