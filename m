Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482450094B
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768608406; cv=none; b=o8/s1Qyq4qyrDafT2HPfDyjsQ8moqXo+oFU5meXjxWDiVBiLKr3f7/A/1Js4wM691AfRJVh/PExZEQqjMcq4Z/V6NjKpbL47ZLdsBX91FZXT91KiblGe9F/4tTImFENTFutZlUCLE1CKRtSvTazc21MJXHFFiKQuwesUrwtNb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768608406; c=relaxed/simple;
	bh=Cbb0OwS1PY2jkwETG9wvSSZ9cReY1BDgkXB6tyZ4ViQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm4W77mVCck7AuYcBj6gPpJmTDNyMVL8CqrGA8EB+/1EZfgVIrBnjXhk0xYVaBhYudP/Oved9ODe1ro0hhGy2Fl4xIpWhePRRxvMWs1BkIerCEbV3t+oaoFbImzENQy9r+0xE/ZpjewQlzYbOTblwW7kQ0C0miCEJ9QRmw76+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8YjtdOi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8YjtdOi"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8887f43b224so48245066d6.1
        for <rcu@vger.kernel.org>; Fri, 16 Jan 2026 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768608404; x=1769213204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDkOv8xyeBo7PdDVE07s2ucba4/fDLaQQcXd3ir6y64=;
        b=R8YjtdOiJYGUepUbscbM4R/SaTpN0mm+6XIeAHeJ3o2xBxWRNzebiOZDKntgunRU9t
         kQksNiyquiKZbGFM2Gg4RqtPLqbTc9lpQpnIJ5/VTtNXa94PGCyd1g0BJawFdN4llweB
         ajfCaxdgkjihzmT7knPncM2GWSLIYk9W35jTL1avvrnt7KTnyB2NqbwLQMRSTQ8vSZCb
         HKJT1lCnVNGKwrVQgL7sldleUoniMcSkS735fupDia8r/vhR/OuFcqGt0MLGkkwUe7Vf
         eF11K/9OkR6zK/fVfZ6PWQus2kfc6pmRi0DrFIioSFGpxN51EB08ZcC3zNAdWW5dsu/2
         jUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768608404; x=1769213204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDkOv8xyeBo7PdDVE07s2ucba4/fDLaQQcXd3ir6y64=;
        b=tiyB/VPcJyX7iGqbJVin7xn267Ktym94G/jm3yrrikFKSY2BaOB+EuuXIXpqxdmKVY
         tgxWBV0sXTO396jUpjUUj1pZT9Sxir9TX2YO6wwKKAl2FNniPwGkq2kCYKw5hRNfN1AA
         UidbQc6MYX7Q07FnwOlKDU5rgBk5ZO/7bdfZZAnl6aeHp3nTDqvBRvmzJUYCBp9gYJj9
         qf2JeoGZ6s7XhNd5i0wbpTBe5fT6IMbf9PiF2S24t9HP4eLRZ43WUdKqgu/VHMj9TMXv
         UmlEexRmJpg07iuMOhTkPnuCPTIlKZhRmtTwePD33Ph5wZzE+C73qajiTBvYnaVKKpxA
         L3hA==
X-Forwarded-Encrypted: i=1; AJvYcCUsman2vnZGscA4xjdbbpRY8b//Z+QTwWuBIJc/FlGp/fV/13sfjHgL8suTkkor9oZ1JfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljC0so2TA6dAJssxwhMvpPn7uQeIfFtWzk2qVovi4gGtAcWqb
	BwGn4J5HaEPLPYP6pgkl01a5sibNnhSjDzRnWzth650PsDA/ECZTiC5a
X-Gm-Gg: AY/fxX6P2ahObI8tyck6QoAVCH7mDx7MN8aLbJ1mr2yc0w/FfGRjXWf3lqPftiMAhmN
	DDKu6kBgZ5RebgYFX268qwYrAu+l+OynAPlQOArZ2IM+cYi/8OKK5nXsKQHckbmR8EqLRbF5+hD
	3cSao6h7JJJkW6fvi6rYMbetOkfPGIVMysV0WsBHTZEF/xpZCutVuH/Yv1vyJiPnpYDQPcRS3Ny
	tgLLQukbN3tk7ggscCfIgQpWGlJr8a+LxFG7nbMHuSZSTvdj6mN02TZ/6wt6iZoIRZGEEEtan/2
	TjlB8Cy/ZNn0O1vaqTgk5HPQs6D4r1gQxBoRRbtcIW8NQWBUYU2ueBpAJowOh7klUHkx09/cG94
	DK3YHafBQvXuUpT5i5aigsfboy6P4gZsLRE4qsNMLs+CkK3Xc3Ef76u/ekJDqx1gOpQCzUp2zFw
	bxjGTBF6FkzUka+93ExhlI/BHvCRt2N3Y8KFaz1eLA0sFnMkmDgnNrltckHb5A/ysRlNHaJGHDo
	D6GYOCfgRE+Cp4=
X-Received: by 2002:a05:6214:5189:b0:7f1:c596:e1cc with SMTP id 6a1803df08f44-8942e2c9a62mr63452806d6.19.1768608403919;
        Fri, 16 Jan 2026 16:06:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e526dsm36097626d6.12.2026.01.16.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 16:06:43 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C43F6F4008C;
	Fri, 16 Jan 2026 19:06:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 19:06:42 -0500
X-ME-Sender: <xms:ktJqaZjli6pSPr0lgEwuRW55b0H4U8LD8NLR3lHOGXSYxrQbmppdcQ>
    <xme:ktJqad7Q2ebf2mdrvMxHZdE1tuosI0weMpqp_qGjTc-r_uMwNX8xdm3oVVBo88oEp
    bgbKS4Ei9V7uaoGwpRt911P4XQoj3zWdbYLgocbt0Dp-SNJt5-C3WE>
X-ME-Received: <xmr:ktJqaWZp5WMcwhlHYy7JlSwiCyzKZ_MJadXzsfsf9CyJ-qdJMK281ips>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrg
    hilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmh
    hgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:ktJqaac7GCuaHwgTeMm0CU46aZa71lO254tPUYfOJTYnIkQG64vhng>
    <xmx:ktJqaT5FZSWzmlGLskLIJJkJ8VeOpZRTfg5LmlEkXYGgfvDHZy1ttw>
    <xmx:ktJqaWV1VtSnPpJ4juZeUACUDbCYRq2vgS98xl_4viBjOZw038X5vQ>
    <xmx:ktJqaaZ1tQM38pJy5xhs8t_-UQ_m75VB8rd_OfxBiH4VDSrwBa0-XA>
    <xmx:ktJqaVzUQm-GAC-h9ll--b7tadH8zpOT6MqbHzKuHn-RYqIr994ewhOu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 19:06:42 -0500 (EST)
Date: Sat, 17 Jan 2026 08:06:40 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <aWrSkAPFkdH_tvtN@tardis-2.local>
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>

On Fri, Jan 16, 2026 at 03:46:35PM +0000, Alice Ryhl wrote:
> I'm sending this RFC to share an experiment I'm looking at. This may let
> us replace the range allocator in Rust Binder with a maple tree.
> 

Thank you, Alice.

> An RcuBox is like a Box except that it lets you obtain a &T that
> outlives the box by a grace period. It does not allow mutable access to

I think the `RcuBox` can be folded into the more generic RCU pointer api
[1], e.g. Rcu<Box<RcuBoxInner<T>>> where RcuBoxInner<T>: HasRcuHead. The
benefits are at least 1) we use relaxed atomic read for RCU readers
which guarantees address dependency that RCU needs under LKMM (while in
the RcuBox here, we just use plain reads), 2) we also support mutable
access as well.

As for the progress of that effort, the Rcu atomic pointer is almost
ready [2], I will likely send it early next week. For the `HasRcuHead`
part, as you may be aware, I'm working on a generic `HasField` approach
to avoid duplication of `Has*` trait and macros [3], that requires some
syn adjustments from Gary and Benno, but they should be available next
cycle. I will probably send the patches for reviews before that. Once we
have that `HasRcuHead` should be easily to add.

Given the WIP code I have, I *think* we are not that far from providing
what you need for binder.

> the inner value (Binder would probably use LockedBy for inner values).
> 

[1]: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-13-boqun.feng@gmail.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-sync
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-field

Regards,
Boqun

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (2):
>       rust: rcu: add RcuBox type
>       rust: maple_tree: add load_rcu()
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/maple_tree.rs       |  52 ++++++++++++++
>  rust/kernel/sync/rcu.rs         |  31 ++++++++-
>  rust/kernel/sync/rcu/rcu_box.rs | 145 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+), 1 deletion(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260116-rcu-box-7a8e4c9f2180
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
