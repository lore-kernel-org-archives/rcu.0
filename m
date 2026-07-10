Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E4376BF7;
	Fri, 10 Jul 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706881; cv=none; b=JPYyvrlNjlFwqOo3Uq6XGSwm3jpSu+sEUdyKX/eSpdlk08drwy0btmgPq0FugesE8sc6OKTrRJUPL1+TY5U/FatjIV8a09KBbK2hSVxOWzfVJrRFkzHNNCTC1BbrrU4+7ZNWjBnXkjS4YWSNoQd9M5lib1O43GDgipFL+KBAWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706881; c=relaxed/simple;
	bh=JRe/I9GeLKJEajADW6/aepQIi/xVnGydvCo1tVSQ4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJhdfNDKhP6MZTmPXGN6HSIpYDpUzNXKNxgXePg4BLWnOpQH9FwVu8+fxr7TqHUiZtduMHrxz6uxWoYW/VDH9AU8CwD8xRx/2sRr+H9hgCOQtk8vfIkLHVCvabL51TYGBXljwo05lsgGF4SD6IbtYDMQzdAbG1OqCEmht0M7IZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9p6V6b8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9p6V6b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6506E1F000E9;
	Fri, 10 Jul 2026 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706880;
	bh=h3dln9do7o47B8mWLnx3PlkmnI34e4ISlQDgt/SIq6g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=C9p6V6b8szIWz8rJ+KILFgbkqQw20U2VQvlLRBJdwOj2/9zWuxCZzv+bT5oec3M60
	 CMkqcWaX5W/0nGiUdqR7JT4QAlKxBDc+AjgBqaShmtQMyFMtb/iza7UExrZoyrKcb5
	 PgxxNcUz2QgBxN06vDi2aCj+tnlaSgW1BQc04LUyRPnkSPTeSpxjEEmR89+giFxz8v
	 fHsTAYdlj6wfPsWBk+gGEkNeCfFmhF4llVoqxIGOZCd5OFzspTX1ujk1KvudgUv7PE
	 crAlaUEDemKMS7R0xC0yxZPNglNmNr9sukVg+9buwtyMke0Wj1bPOrfqE7ZDFi9sy/
	 04GdXU8Mz7Ouw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5200CE084A; Fri, 10 Jul 2026 11:07:59 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:07:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v10 0/5] rust: add SRCU abstraction
Message-ID: <f624a266-c37f-421d-925b-645bb31b411c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260613065348.96750-1-work@onurozkan.dev>
 <alD_OFVyGv7Wesq0@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alD_OFVyGv7Wesq0@tardis.local>

On Fri, Jul 10, 2026 at 07:18:32AM -0700, Boqun Feng wrote:
> On Sat, Jun 13, 2026 at 09:40:06AM +0300, Onur Özkan wrote:
> > The immediate motivation is the Tyr reset infrastructure [1] which needs
> > to serialize reset sensitive hardware access against reset and teardown
> > paths. That reset series started to require many independent dependencies
> > so this SRCU support is split out as a standalone Rust API to keep the
> > reset series focused on the reset logic and easier to review, rebase and
> > land.
> > 
> [...]
> 
> Thank you all!
> 
> Reviewed-by: Boqun Feng <boqun@kernel.org>
> 
> Paul, per our previous discussion, I think this series should into rcu
> tree, since it changes a significant part of SRCU C code. Thanks!

As Boqun said, thank you all!

I have queued these, with a little luck for the upcoming merge window.

							Thanx, paul
