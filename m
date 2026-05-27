Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54A0283FDC;
	Wed, 27 May 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861545; cv=none; b=trYMEB5iWQv4zEhN6RsK4K2+3W1ZJ7CHVA3l42zgvg4G3TWoGvQ438IvlRXKno6W+3qwm4W1aqsRHzhWCGaQnpt0N4mNhNsEUhS9zSnL0RnOMV5hLVGHuUXRIOVUwxAw8u/kJfJkkZwhDJsM0vuBgPK7Ege/tTJy6fc/7ElDy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861545; c=relaxed/simple;
	bh=htN3jbwYwX8JpzPO3+13CsPy9/FwsiOfTew3vuq8C48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lENfzDUnRscmc7pP+WIrAXlqztIJQTjVLfCSW+tC9xwJYbgeNvvjI1f3fxPatsZ+GEhqnG7BSIt3tSKGn5Fo/SkuJefLFxf4zLS0WNg4w0Nr4QZ1QQW5dG9egAkWTlq2XIXnnx0UQNEW8qmXA7Om6zly809S/otTnmi+SXB59eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdkRFFkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdkRFFkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631D1F00A3A;
	Wed, 27 May 2026 05:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779861544;
	bh=upHGxSaOtvddop65auPqRPdmVCzEr5O99kywI8yLzsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OdkRFFkW9rAcwlnrzE/zmfADaPgbtknt3M5Fptpo5YGxwUIc6wiWl1Q+W8LzRLamm
	 iCctie8pQ345XjLq4QqyYcUK7FCQc/Ln1UNURHwrhZ9nFOZpwp74oe326i45eJctct
	 Zyp5vQM8MeSdSTKCT4PIS/vnR/Rru0QiPTyNzxk16gXsM5ns7P8LamWY/ofQu8uHIx
	 E1mCTa0DU5JyScKAPxkK1AobVR067xExosJDr22+st0JSGYCEz8g3lAcy2JiyxddGB
	 nCfACR/hbE1yJQISPWu39fIXP+07fZh/9YBZLHxBGV43osm5PoaVZMI5oqXLWEPur8
	 cB4YfQmNDvmvQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9A60DF40072;
	Wed, 27 May 2026 01:59:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 01:59:02 -0400
X-ME-Sender: <xms:JogWaozZSqtJpZRRbAv3_7nOzbHMGOWGOMu-d0J_JnVNG6SZXQfAUw>
    <xme:JogWapuuPHZ5PQWHPfRvoMb_SNZn1XjxZPrkKxs3KOWEYZZqaPPnLLjoj8COpLu4w
    ZbU5we9IQNeVYeytk5bYrLwQkgLchKj7EHPUVfqYwiX9JFNTJUzMg>
X-ME-Received: <xmr:JogWaqRV6lsv3aQjksyWg53n6AzonuTtuEMcfJpx9UFeUQAKif9Dg0scAc32gmC_MPFtMlkOhASgE8r49Pl35ydqQeA2dZS0>
X-ME-Proxy-Cause: dmFkZTFcXiEzNYwiQWvd3p41gl7xPOQVk1Vu8ySLWtxBy0zK8Uz+SG39WKRufpDOqsg5HP
    cqNZLJ0mG9vJSLA9DPIImiRulGBP1bqG7SnbqwmSrhWM+JI0RXYfwcpigwaRcV+MAMmyXr
    S9eBbNUXfyURq4zck88sLW+ObF4HrB23c1gVTqWGnhyzNTlNdKLDFLGSRhRqX1U8Ujx1ya
    qNs4Lus+v0w8buckaRer9FxofsBHytLSPajst3c2iIUeJrw6klc/mvSQFp5wo85FOCki3m
    vNZHQseQoelcosiGqyFqeEjzVzFSLzJpUINJva6C5tfvHmtK1YF/LRzXW15cXZL5jO80ls
    LYmS64SU8lJvpaj935D/Z+cUm+Fy144yh/EKZT1Zk1IuNIfTfHzWFF5jgJ5GYJF5cki8NO
    3HMK/ZBmkg4XHCtYbGij/ePzxyaM0QM1JkVteQIDiG5w00+81Kx92YjQ5H0Yq7ktatZgOf
    o+N4iqU5lSKH3oBH0lR6PCGv/OV4ItIBMNWYsR2E+7Y/FGndIOISu+k6ARFBIYx2W4QqG1
    X9lZAzc693tfAwP4jpF+epIozPNRC9U4Bl3q+yQrdAWXkxLF9i7NLyt8gwa69QJlIxvTNd
    YwiHoBPzwN1MmtcVurxbDpE1qpTYUaFb3KS0Xs7O6HCOAeQidzUJeq/XvBJQ
X-ME-Proxy: <xmx:JogWaoJnLEG1HwP7tw-sypYDISi70UmX74Lzi0RgD8upMYlX7bELNQ>
    <xmx:JogWaqA2g_fxuD_GQJTGnNfow2VsfLnS41DmaUI2r_YuYQklgnuOtA>
    <xmx:JogWat0z0FISc-TXp90GXQkC8jq-gAgjB--K4whFadCPcBlvvzABDA>
    <xmx:JogWalkMzBAsbMruHqogYie3kiyTXEOzIbb1SomALk0gFc44-xmyxA>
    <xmx:JogWaieXFE66xqp8YiHvcjV6g8QNB-QYuOVrwHTAbpJziKqTIlZIabst>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 01:59:01 -0400 (EDT)
Date: Tue, 26 May 2026 22:59:01 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: phasta@kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <ahaIJXi_3MDm5QEY@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
 <ag2-T9i2nFHjiYLm@tardis.local>
 <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>
 <ahXF39fwE5helcj6@tardis.local>
 <ahaGlUrZdF5_a4Ah@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahaGlUrZdF5_a4Ah@google.com>

On Wed, May 27, 2026 at 05:52:21AM +0000, Alice Ryhl wrote:
> On Tue, May 26, 2026 at 09:10:07AM -0700, Boqun Feng wrote:
> > On Thu, May 21, 2026 at 09:25:28AM +0200, Philipp Stanner wrote:
> > > [+cc Boris]
> > > 
> > > On Wed, 2026-05-20 at 06:59 -0700, Boqun Feng wrote:
> > > > Hi Philipp,
> > > 
> > > Hi Boqun; hope you're doing well
> > > 
> > > > 
> > > > On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
> > > > > call_rcu() can be expected to be needed by a great variety of users.
> > > > > This functionality is almost always used for deallocating resources
> > > > > after all accessors are gone. Hence, it appears reasonable to implement
> > > > > the abstractions in such a way that the user merely passes data, which
> > > > > is later (after a grace period) dropped.
> > > > > 
> > > > > In the rare cases where the user needs special action to take place,
> > > > > this could be achieved through implementing a custom drop() method.
> > > > > 
> > > > > Implement a first minimal abstraction for call_rcu().
> > > > > 
> > > > 
> > > > Thanks for the patch! Do you have have any reference usage of this new
> > > > API, maybe contains how RCU readers will read the data?
> > > 
> > > Read the data? This design does not intend to have any readers.
> > > 
> > 
> > Please understand that from the perspective of an RCU maintainer, I
> > would like to examine how the current design would work with a more
> > general case, otherwise it's going to be a maintenance nightmare.
> > 
> > > I want it as some sort of trash-bin container that does nothing but
> > > defer a drop(). Intended user will be this section here:
> > > 
> > > https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requests/1/diffs#5ef8add7e1b3375ce9a0b47595b531244bf98dce_0_611
> > > 
> > 
> > The fact that you need a "defer" means that there are readers, right?
> > 
> > You don't need to worry about here because the readers are in the
> > callback of fences.
> > 
> > > 
> > > > 
> > > > Compared to Alice's RcuBox proposal:
> > > > 
> > > > 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f0@google.com/
> > > > 
> > > > I do have a design question: is support data type like Arc<CallBack<T>>
> > > > or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
> > > > be like? A separate new() and submit() function or a separate data type?
> > > 
> > > I wasn't aware of Alice's proposal. Let me try whether I can make it
> > > work for my purposes.
> > > 
> > > The idea behind my code here would be to have some minimalist RCU
> > > wrapper that merely defers dropping data. So it's a fire-and-forget
> > > mechanism that would not support Arc: take over ownership of the data,
> > > have it be unaccessible, and drop it after a grace period.
> > > 
> > 
> > Maybe then name this data structure `RcuDeferDropBox<T>` or something?
> > Because if the design goal is not to support a general RCU usage (with
> > readers), than it probably shouldn't take the rcu::Callback name.
> > 
> > Or maybe keep the `Callback<T>`, but only implement `new()` (with a
> > return type as `impl PinInit<Callback<T>>` and the rcu_head accessor of
> > it. Then based on it you can implement the `RcuDeferDropBox<T>`, in this
> > way, we could both support your usage and move towards a full-featured
> > RCU implementation. Thoughts?
> > 
> > Plus, I think Alice's patch here [1] would also benefit from having a
> > basic rcu::Callback (to replace `PollCondVarBoxInner`).
> > 
> > [1]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-1-f5b4c747eac2@google.com/
> 
> My patch specifically uses kvfree_call_rcu(), which I think is important
> that it keeps using over call_rcu().
> 

Of course, but note that using call_rcu() for your case was not my
suggestion. We can reuse a general `Callback<T>` which is not tied to
call_rcu() or kvfree_call_rcu() to represent a container type with a
rcu_head for both cases (your and Philipp's).

Regards,
Boqun

> Alice
