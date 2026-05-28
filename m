Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00F2F8E93
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980799; cv=none; b=TrzhB7eepkc4iOXJFIQL7NuaxXJfBjY8SCwJkTKg1N1oTaO5z9N9uwZs+3L1fCaZqr1vzfEqW+c6XihW0VEYb43eJhZJIGTh5KvxQZCqFqxuq/CL4KG8tvC5lf983B5jmM+EwktoJhdyXsx7a8qWpnsilxCm3F72vgNaD9w2v2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980799; c=relaxed/simple;
	bh=CetneEB6Ddz2AtH+SCWvtKlWsa9Lu3j7cl7huYJ+EEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPkbeSBoWrTrumY3VqbrBG5cDWSXSd2VS7GGzaJuyUw97Bfgsqy0mJM/zyCBG3kpEdX6KPHIbHewXT5YOzCjsPeZLkgii3uHdmRmDugY1v0IFqNyRAkq1dt592aLe2Ud7wxDdQxzAl3Ym3WH+CUu+ZG1gtXjT38e1OXTRvgtQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv4bQjvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv4bQjvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F51F00A3C;
	Thu, 28 May 2026 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980797;
	bh=bIEzIL1LN3xvxmpSkiEuKB2FgUOHE5n8Piif0j7Dtic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hv4bQjvl2/1EnNTsnw8uydDJskVs5DlVig91RyYXKJKnRDhdE0H6iB8YOMthX/uXS
	 2O+w3oNxQczpoQdM7ZuYWre3vUdB7HuycNmVPfKFmj1laM69Oao/qfrCBzILsISdJB
	 agLRg+RQEt9Y4DjDfqcrD0dCZp+Mh25Qm8ornW6moNzbaKzX7H2sXZTSDUA9Fy/J1+
	 q5gJq/ij4N2fdm/VfoS7Mkn/vWRyEC2QEAcOVBTiYGGYo6wbB5QJ3uQf7my3GbiRKP
	 v1akVklfT4/5Hp9QjxTatNhHgoNbvcWUOtCTlxhKkZ+6sx/rlEMcCdEwsLSgNN42F4
	 yVVoYHBvqyE4g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C11DFF4007E;
	Thu, 28 May 2026 11:06:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 11:06:35 -0400
X-ME-Sender: <xms:-1kYaqLKR50ijq9_N4IcEKPihm2CCHDAvEelaouvpEWYKwn5_MDHkw>
    <xme:-1kYaqhrOyvFE8GtVxqMHU_q8r0RVfMCOEM-iUQ8C0_wU82DmlPOoM3XMh4zGmBqB
    e2jGaXyJM4iL0DNhb7idN4szF4Cc3ZzpEtwTr33i9ytT_IAGxxN>
X-ME-Received: <xmr:-1kYas4equQw7vGOPaSRwfhkB2gjdUi8ZSiWWseyzOj10DyMqPvraYMAkfg-e_rFxwHH3JIqRBT8SMXjXHxG1vWG2OiivdX2>
X-ME-Proxy-Cause: dmFkZTGEgOIqBevyj0mc/lQL+jy1RxSfcZ244kGEakEAP22RhAaXhe/3YR4JB3Cm3Xfp2Q
    qUQUgM5pdfzQ7if8U5L394GuB2wjZfxXrPJfdBNHfx1ZDc1GAFmJlmosexBkeKi9yNlJcf
    37KWH0OjRFQO8PdKDaaYuuCPzkEkcGaNBTSDapoHj+Mh3hcNskfBOEDT4+ySctlAh6Yp1K
    h1w5Fdjr+Qy87sdLk2DAhkakKt9c0o6zoKlxaZHWrLWfqZL9BjktLWR5Tqs38lTMCgmf5S
    VsUSK3TVoF4KniGjT8KO/cfGrFege71n74+F2gGZPYXNEa883tO3FnL/fvy5ycHZ2LfxqY
    w+C1lAeSsGTX8KEe3rzRu+VX4NUI1ymldJz88bUmHVn9R56PuNLVOSjKXJIcIHCj43Njco
    poR0uOGCwRDBV/Rz78WoDvN5GV+HtdJmaiIGtmWeXch2BACpcY3e1kmmwkFCXWDDYkiob4
    //pWr46osHrmm6ObCHq4jQ18EgZgjBDqsu8MVFBPPkfhwZUZnlKlg+Hv8LvHUN6xXXcYC3
    GWJ7zBNDHmklwbhvw8l9iPuB9aerBc56PzGAVwyGSqeypCygRV0ZSeBPcQMUml0Tr87ehE
    ATMsuylyyC5mdjCTMo9SpZF9L6VMqM7m/UOohgwii2uIrolgWvcoOy44lCVg
X-ME-Proxy: <xmx:-1kYanNjYi-_nFzwDaYyBR05gsxKNJ_wC-bzzZSoM6-4mNvf_cRlTw>
    <xmx:-1kYajcTE0TlzTbi5ZYEw3EKVAC0PNxSOdhZzWTvh5qRevLf_DBGcA>
    <xmx:-1kYaq33JcxuJnTJfdDc-jN1izVUO1VhhIZIUhx4DOJc9QU0znJDCw>
    <xmx:-1kYarOMHQa5IkKg5oo9Lftyf1KhJrVI-LBLrxz_b1nKr1ZmkEzjJA>
    <xmx:-1kYatcR-c0zWz6i6bNWm-5VaKoPwkeaDZruUErpl2jylxKhUdtE_JQF>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 11:06:34 -0400 (EDT)
Date: Thu, 28 May 2026 08:06:33 -0700
From: Boqun Feng <boqun@kernel.org>
To: phasta@kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	"Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tamir Duberstein <tamird@kernel.org>,	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rcu@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
Message-ID: <ahhZ-S2-OGHoulAR@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
 <ag2-T9i2nFHjiYLm@tardis.local>
 <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>
 <ahXF39fwE5helcj6@tardis.local>
 <ahaGlUrZdF5_a4Ah@google.com>
 <ahaIJXi_3MDm5QEY@tardis.local>
 <49cddd19e6a51c602ee1890fb18bd31afa33df38.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cddd19e6a51c602ee1890fb18bd31afa33df38.camel@mailbox.org>

On Wed, May 27, 2026 at 08:31:44AM +0200, Philipp Stanner wrote:
[..]
> > > > > 
> > > > > > 
> > > > > > Compared to Alice's RcuBox proposal:
> > > > > > 
> > > > > > 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f0@google.com/
> > > > > > 
> > > > > > I do have a design question: is support data type like Arc<CallBack<T>>
> > > > > > or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
> > > > > > be like? A separate new() and submit() function or a separate data type?
> > > > > 
> > > > > I wasn't aware of Alice's proposal. Let me try whether I can make it
> > > > > work for my purposes.
> > > > > 
> > > > > The idea behind my code here would be to have some minimalist RCU
> > > > > wrapper that merely defers dropping data. So it's a fire-and-forget
> > > > > mechanism that would not support Arc: take over ownership of the data,
> > > > > have it be unaccessible, and drop it after a grace period.
> > > > > 
> > > > 
> > > > Maybe then name this data structure `RcuDeferDropBox<T>` or something?
> > > > Because if the design goal is not to support a general RCU usage (with
> > > > readers), than it probably shouldn't take the rcu::Callback name.
> > > > 
> > > > Or maybe keep the `Callback<T>`, but only implement `new()` (with a
> > > > return type as `impl PinInit<Callback<T>>` and the rcu_head accessor of
> > > > it. Then based on it you can implement the `RcuDeferDropBox<T>`, in this
> > > > way, we could both support your usage and move towards a full-featured
> > > > RCU implementation. Thoughts?
> > > > 
> > > > Plus, I think Alice's patch here [1] would also benefit from having a
> > > > basic rcu::Callback (to replace `PollCondVarBoxInner`).
> > > > 
> > > > [1]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-1-f5b4c747eac2@google.com/
> > > 
> > > My patch specifically uses kvfree_call_rcu(), which I think is important
> > > that it keeps using over call_rcu().
> > > 
> > 
> > Of course, but note that using call_rcu() for your case was not my
> > suggestion. We can reuse a general `Callback<T>` which is not tied to
> > call_rcu() or kvfree_call_rcu() to represent a container type with a
> > rcu_head for both cases (your and Philipp's).
> 
> I have given Alice's code a spin and concluded that it would be fully
> usable for my intended use-case. The trick would then be to force users
> of my API to pass their data in an RcuBox, which Rust can certainly

Note that we can extend RcuBox to implement `InPlaceInit` similar as a
normal Box, that way you can ask user to pass the `impl PinInit<T>`
instead of the data.

> enforce. Has the great advantage of me not having to allocate again
> just to drop something, so this is a far cleaner design.
> 
> From my side, only minor details would remain open regarding Alice's
> draft, like Boqun's question about how to implement VBox maybe.
> 

I think we can make RcuBox generic over Allocator, i.e.
`RcuBox<T, A: Allocator>` then we should be able to support vmalloc as
well.

Regards,
Boqun

> But in principle you can regard my patch here to be withdrawn :)
> 
> Regards
> P.
> 
> > 
> > Regards,
> > Boqun
> > 
> > > Alice
> 
