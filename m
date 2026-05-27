Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F50140E4F;
	Wed, 27 May 2026 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863526; cv=none; b=rVwHSw3kX7vQ54UvL7R8YTFSK3t7lXOLWcgdNb3OEYXO1gB/yT0DDtW4GdwzXiY9a2GMsUyliccmuCe1vkmZTZvlRk8RL7/BpdC8InNs2YUy5qYOwPWC5PS1jtvyfkItNhElhsrsZK1GnnnNAUCDX5kICaKNZXHpcQj7b/UuFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863526; c=relaxed/simple;
	bh=YApNF7JAZumlIXTKaK1v33BlmpaV6Gi+Q9126rLzcOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJA3RRNxmKVaAqxU+BGZGP3eXGfIpVkdU2d6sR38cWrjKz1O06pZYM+ulfhzBLPYw8kefY8znWmY81p26lyc7bHGHZQlDA1itg4OJO5YAXLv07ScKsfwCwxBGCnFj+n7e87JRVm706O7zm1ed/dsMiLPQAZfoGwVLKNaYHCmqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D7lzHE17; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D7lzHE17"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gQKXV12zXz9thw;
	Wed, 27 May 2026 08:31:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779863514; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaiJdvkla/u8vcHh3EBvB6aRZQ0wWGdo0bHkvOslg9U=;
	b=D7lzHE17ci2uCAI0vyfhKE0QqaWMpAMlEo1frTijboibVFyuWqido43fqUqSbJfGY19oV4
	SNwXgUTNO5fJp+GrAJ+/AUJC7AtEMGC+qE/o5JFKWO7Pt9dwNoNRTz6nApeAavA/5J9gXT
	Mdz0zVKHlgwrRtdmdSIVy2YBtgZNBha/pojxWRSgqxItCemPaMsUei/zJQJ79ZEt7H66ta
	BK69bK35KEsNGJsM2O7GH/JUos45TN9XhTZrNhm5WoJDY9i2P5llJRoXPtmVn+2ATBMX35
	vhpPmJyuQcEBQ5SGcYODvfQFeNFJxPmeZi2buQWz+43AXbvsVaZOlhcPA6krsQ==
Message-ID: <49cddd19e6a51c602ee1890fb18bd31afa33df38.camel@mailbox.org>
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Boqun Feng <boqun@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: phasta@kernel.org, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, "Joel Fernandes (NVIDIA)"
 <joel@joelfernandes.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tamir Duberstein <tamird@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Boris Brezillon
 <boris.brezillon@collabora.com>
Date: Wed, 27 May 2026 08:31:44 +0200
In-Reply-To: <ahaIJXi_3MDm5QEY@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
	 <ag2-T9i2nFHjiYLm@tardis.local>
	 <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>
	 <ahXF39fwE5helcj6@tardis.local> <ahaGlUrZdF5_a4Ah@google.com>
	 <ahaIJXi_3MDm5QEY@tardis.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ipcfwepxujr7dcrhordipzoo7s565ca6
X-MBO-RS-ID: 6e0ee7b2dd56bf622fe

On Tue, 2026-05-26 at 22:59 -0700, Boqun Feng wrote:
> On Wed, May 27, 2026 at 05:52:21AM +0000, Alice Ryhl wrote:
> > On Tue, May 26, 2026 at 09:10:07AM -0700, Boqun Feng wrote:
> > > On Thu, May 21, 2026 at 09:25:28AM +0200, Philipp Stanner wrote:
> > > > [+cc Boris]
> > > >=20
> > > > On Wed, 2026-05-20 at 06:59 -0700, Boqun Feng wrote:
> > > > > Hi Philipp,
> > > >=20
> > > > Hi Boqun; hope you're doing well
> > > >=20
> > > > >=20
> > > > > On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
> > > > > > call_rcu() can be expected to be needed by a great variety of u=
sers.
> > > > > > This functionality is almost always used for deallocating resou=
rces
> > > > > > after all accessors are gone. Hence, it appears reasonable to i=
mplement
> > > > > > the abstractions in such a way that the user merely passes data=
, which
> > > > > > is later (after a grace period) dropped.
> > > > > >=20
> > > > > > In the rare cases where the user needs special action to take p=
lace,
> > > > > > this could be achieved through implementing a custom drop() met=
hod.
> > > > > >=20
> > > > > > Implement a first minimal abstraction for call_rcu().
> > > > > >=20
> > > > >=20
> > > > > Thanks for the patch! Do you have have any reference usage of thi=
s new
> > > > > API, maybe contains how RCU readers will read the data?
> > > >=20
> > > > Read the data? This design does not intend to have any readers.
> > > >=20
> > >=20
> > > Please understand that from the perspective of an RCU maintainer, I
> > > would like to examine how the current design would work with a more
> > > general case, otherwise it's going to be a maintenance nightmare.
> > >=20
> > > > I want it as some sort of trash-bin container that does nothing but
> > > > defer a drop(). Intended user will be this section here:
> > > >=20
> > > > https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requ=
ests/1/diffs#5ef8add7e1b3375ce9a0b47595b531244bf98dce_0_611
> > > >=20
> > >=20
> > > The fact that you need a "defer" means that there are readers, right?
> > >=20
> > > You don't need to worry about here because the readers are in the
> > > callback of fences.
> > >=20
> > > >=20
> > > > >=20
> > > > > Compared to Alice's RcuBox proposal:
> > > > >=20
> > > > > 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38e=
bfbcd53f0@google.com/
> > > > >=20
> > > > > I do have a design question: is support data type like Arc<CallBa=
ck<T>>
> > > > > or Pin<VBox<Callback<T>> in the plan of this API? If so, how woul=
d that
> > > > > be like? A separate new() and submit() function or a separate dat=
a type?
> > > >=20
> > > > I wasn't aware of Alice's proposal. Let me try whether I can make i=
t
> > > > work for my purposes.
> > > >=20
> > > > The idea behind my code here would be to have some minimalist RCU
> > > > wrapper that merely defers dropping data. So it's a fire-and-forget
> > > > mechanism that would not support Arc: take over ownership of the da=
ta,
> > > > have it be unaccessible, and drop it after a grace period.
> > > >=20
> > >=20
> > > Maybe then name this data structure `RcuDeferDropBox<T>` or something=
?
> > > Because if the design goal is not to support a general RCU usage (wit=
h
> > > readers), than it probably shouldn't take the rcu::Callback name.
> > >=20
> > > Or maybe keep the `Callback<T>`, but only implement `new()` (with a
> > > return type as `impl PinInit<Callback<T>>` and the rcu_head accessor =
of
> > > it. Then based on it you can implement the `RcuDeferDropBox<T>`, in t=
his
> > > way, we could both support your usage and move towards a full-feature=
d
> > > RCU implementation. Thoughts?
> > >=20
> > > Plus, I think Alice's patch here [1] would also benefit from having a
> > > basic rcu::Callback (to replace `PollCondVarBoxInner`).
> > >=20
> > > [1]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-=
1-f5b4c747eac2@google.com/
> >=20
> > My patch specifically uses kvfree_call_rcu(), which I think is importan=
t
> > that it keeps using over call_rcu().
> >=20
>=20
> Of course, but note that using call_rcu() for your case was not my
> suggestion. We can reuse a general `Callback<T>` which is not tied to
> call_rcu() or kvfree_call_rcu() to represent a container type with a
> rcu_head for both cases (your and Philipp's).

I have given Alice's code a spin and concluded that it would be fully
usable for my intended use-case. The trick would then be to force users
of my API to pass their data in an RcuBox, which Rust can certainly
enforce. Has the great advantage of me not having to allocate again
just to drop something, so this is a far cleaner design.

From my side, only minor details would remain open regarding Alice's
draft, like Boqun's question about how to implement VBox maybe.

But in principle you can regard my patch here to be withdrawn :)

Regards
P.

>=20
> Regards,
> Boqun
>=20
> > Alice

