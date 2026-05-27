Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1232641CA
	for <rcu@vger.kernel.org>; Wed, 27 May 2026 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861146; cv=none; b=siGN4zhoTkAy+ImoHgfpCIB80Az/r7JBAW0qGm7cbr0cSg1uPVwNPEumtUslP8FlFcrx3X3oEONUO9jaN0jI5p5Tnx/Gk5sEHKFd/hsZzARnAKOzoPRwJaQnTxs4pz8QZHeaQCLSf4q1p3FcLL2HbNdCTQpBAMKPDgCCYS3s2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861146; c=relaxed/simple;
	bh=e59JLyye+BCPeBvIcOO0K0XxtFU+z5dm8jMiz/RL3GI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaJWRoVOCYk0Wgf4Dw3j7ScUuyW2BkcjcDRj1VP+v3Jcui69zUMkAhyBO/lXxaeNvLtRJaBkWaAe1UsXtynSrx10B1qwpjbSdi0Dzu3S8FMN0mt0OvoNAJEf44sxCLEZEHpiaLDHi0lp6oSxOuxOBcaU++pYyoNKq6sPpAVF/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5EbOwJu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5EbOwJu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490479c2911so53376825e9.2
        for <rcu@vger.kernel.org>; Tue, 26 May 2026 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779861143; x=1780465943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mnO3XlOhvg9H/RyJsxjQAjYjnU39d3V6ICKG4zIz5s=;
        b=H5EbOwJupU06Nb28ygI87DJx/nXBIhBp/e9BJSW+z8cIeg8djYaBUPwZ0zFjQX02G+
         MrCTf0Te4tp4Vq/uugvlDUgAeJfw82aPSen2YospT5b8c0d7OZCEhuoen13kcpR2P0wA
         s/qOLXKsCEYdgNZd6XCg8XMVoJDdJSptPv43/8vsb+y5h+HC4VSKawCLP/le6oUBHcHI
         g+bdyPnFmYJuzcwVemWtPFQuIHUk9F8n4KtTdi8BHZ3+UtjElAIyw7kQmCUJuJfKNtrS
         Nj2m+PRyxnyQELnEdHot09k5mcCuH1PTh9fDouOrPhjETtzuT66jVwbJv/owhqqAtBOn
         CT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861143; x=1780465943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mnO3XlOhvg9H/RyJsxjQAjYjnU39d3V6ICKG4zIz5s=;
        b=YIZTHzNPqiVcA8pigQZafh/ReXcCxMLeQlx3sGHXmziU22iedWeVADt6WqAbh6Z128
         Uf4g6pIvgFuZougAQLz34L3jBkvLtgpYSq/c60FW8wJ4AxurRDzfM6NEwjmuZBXUtjjK
         LnnUUJp+TIdEQY4wJxZ1lChMsrHJfRif4a2wNW3OeV9nZIoCIdFoWLE/5TbIomyqSNHz
         YRrTlcAxUK9C8BpV8+T9ZKI1EbDLWVg3zYz1Vz6q17gMVJqttixWAjlCUMaVU/vmhMUh
         NDnFuyqV+fdLDB8cWylf01Tf0XztTbgblQyrdqT1aq3IJRarFc7rtQTOeXhS/kVCRmF+
         kAXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kv0G6RdV8NZXoMm8RC7YaG4Cg1Tn/q5kwV6ajYN1AmJ5fHmXs/sKXJSLYqpiDzDE8DkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDiV+WZQk33iVEjDd0P16u+HPgjSDaWvCDMWvym2vdg58IIgA
	hCpbsyefbpuYOllWy3vkXpUKxlBjKsUDeKBjQJyWeh1Z+FUSE+ayMQGoaEzjytJTANMkqh/prXU
	s5oXsjfNY/DuCdO8qog==
X-Received: from wmjk2.prod.google.com ([2002:a7b:c302:0:b0:483:6e28:c16f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b92:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490426d18e5mr368797885e9.22.1779861143003;
 Tue, 26 May 2026 22:52:23 -0700 (PDT)
Date: Wed, 27 May 2026 05:52:21 +0000
In-Reply-To: <ahXF39fwE5helcj6@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520131725.266014-2-phasta@kernel.org> <ag2-T9i2nFHjiYLm@tardis.local>
 <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org> <ahXF39fwE5helcj6@tardis.local>
Message-ID: <ahaGlUrZdF5_a4Ah@google.com>
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: phasta@kernel.org, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, "Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tamir Duberstein <tamird@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="utf-8"

On Tue, May 26, 2026 at 09:10:07AM -0700, Boqun Feng wrote:
> On Thu, May 21, 2026 at 09:25:28AM +0200, Philipp Stanner wrote:
> > [+cc Boris]
> > 
> > On Wed, 2026-05-20 at 06:59 -0700, Boqun Feng wrote:
> > > Hi Philipp,
> > 
> > Hi Boqun; hope you're doing well
> > 
> > > 
> > > On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
> > > > call_rcu() can be expected to be needed by a great variety of users.
> > > > This functionality is almost always used for deallocating resources
> > > > after all accessors are gone. Hence, it appears reasonable to implement
> > > > the abstractions in such a way that the user merely passes data, which
> > > > is later (after a grace period) dropped.
> > > > 
> > > > In the rare cases where the user needs special action to take place,
> > > > this could be achieved through implementing a custom drop() method.
> > > > 
> > > > Implement a first minimal abstraction for call_rcu().
> > > > 
> > > 
> > > Thanks for the patch! Do you have have any reference usage of this new
> > > API, maybe contains how RCU readers will read the data?
> > 
> > Read the data? This design does not intend to have any readers.
> > 
> 
> Please understand that from the perspective of an RCU maintainer, I
> would like to examine how the current design would work with a more
> general case, otherwise it's going to be a maintenance nightmare.
> 
> > I want it as some sort of trash-bin container that does nothing but
> > defer a drop(). Intended user will be this section here:
> > 
> > https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requests/1/diffs#5ef8add7e1b3375ce9a0b47595b531244bf98dce_0_611
> > 
> 
> The fact that you need a "defer" means that there are readers, right?
> 
> You don't need to worry about here because the readers are in the
> callback of fences.
> 
> > 
> > > 
> > > Compared to Alice's RcuBox proposal:
> > > 
> > > 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f0@google.com/
> > > 
> > > I do have a design question: is support data type like Arc<CallBack<T>>
> > > or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
> > > be like? A separate new() and submit() function or a separate data type?
> > 
> > I wasn't aware of Alice's proposal. Let me try whether I can make it
> > work for my purposes.
> > 
> > The idea behind my code here would be to have some minimalist RCU
> > wrapper that merely defers dropping data. So it's a fire-and-forget
> > mechanism that would not support Arc: take over ownership of the data,
> > have it be unaccessible, and drop it after a grace period.
> > 
> 
> Maybe then name this data structure `RcuDeferDropBox<T>` or something?
> Because if the design goal is not to support a general RCU usage (with
> readers), than it probably shouldn't take the rcu::Callback name.
> 
> Or maybe keep the `Callback<T>`, but only implement `new()` (with a
> return type as `impl PinInit<Callback<T>>` and the rcu_head accessor of
> it. Then based on it you can implement the `RcuDeferDropBox<T>`, in this
> way, we could both support your usage and move towards a full-featured
> RCU implementation. Thoughts?
> 
> Plus, I think Alice's patch here [1] would also benefit from having a
> basic rcu::Callback (to replace `PollCondVarBoxInner`).
> 
> [1]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-1-f5b4c747eac2@google.com/

My patch specifically uses kvfree_call_rcu(), which I think is important
that it keeps using over call_rcu().

Alice
