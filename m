Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE72D1F64
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768650910; cv=none; b=lV/9YQw2En1qh/DqKMOSwwlecc96EEHH5VwuVQ7Gg0hQg56Vezge1pxhD60lHNY7FTZNqyLJCi1wwJWHSxICIb1zPcgbv1ibh13r/qk9f9jXrcQgojzRgmIhxEJmTy52iLQLU4tEGmYh6D65xs/U9xObkS1tRLiV7fzypik1Oik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768650910; c=relaxed/simple;
	bh=JKuiMJd4b5PrjzGihqsZ2lYXtmBAHUr5Vx2YzFo1CFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fxLi49QIMXFknADGzOl/XE95p0WlB96bH52h0ysKo8AbkqfzXttz63z0hz4CxCtvHrvea8jBVTKZdy3htg8hR71K9EJobGSFarmTmmJkjj2n8ZIIoykG5AyVPLGdOiYupd8OyUGp18Nfoa4XWmEPcx02BFV1/tNw85BmWZ8wB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKa25yV2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKa25yV2"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso21158595e9.3
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768650908; x=1769255708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLzmroCaS/6bTcyxw8v2f5hrQAsPrQS2nRkMsKAP0sg=;
        b=yKa25yV2suGryY/7Wd+kPBR52nUFlBA1IQlqVhoc9Iak9NqFa95KfIZVZKTwp39gJy
         ry7kICaBUNkNcvZlw7Nqf3wdT9kpzgj8tDJnxkDgyPX/WDTUw6iycTeb0Esr9y2VJWHv
         RoWvjzYlZ2ZrbbS5u0stqa2Ij+j0/HC3Vk1G7CJ3UdRodhWHzKZBDuq/ob8D5j2D0qcS
         ItooGlyPpvuVX1AHWRxMz4yF6lUAniB0Pc2XE0VJ3z599P8ywGAw/LePCCgwROVPl8zc
         MMXRhH7TSn2cop0zwBOSRnQyGt3slsxS2golg4WHt0aNv/6K41XEy8j+IpZMmDf1ntzl
         SnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768650908; x=1769255708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLzmroCaS/6bTcyxw8v2f5hrQAsPrQS2nRkMsKAP0sg=;
        b=nUlwdZXeB+MqF1f5NFgki2kPGK6PIJYaghZ0ZiCjpoq/NdEQgifRY1pGdV3EDA2LMR
         cg/hf7bO118TTEWH/dIyE6LQpFq0gH2o7VpEfJQLnDJQogRV3kYpYpbnY27WxQd2Yv28
         3LBQMTs/0QjytoSlfQypHdjxwZGocnk5i1DMmAp2etykTlRhFLbUo+qdebUtowTJbGOm
         +vD3fS1QdQdUD7KX/ik4rxSH9nmQKE5aE3kAbhDhVrEXbf2z/k6KFQk8yD2gRMIAQE6i
         HwjoxMuOsDVNI42q38HN8XktrlYVtS1SzaKYkmzDa5RMbzAu1zBRimnfwiMtUM3zcRl9
         4hNA==
X-Forwarded-Encrypted: i=1; AJvYcCWaaRLZ7XLUkDUpFnyfZzb5Z5He67rjx5ixef7m59AUPJHnyO9Ryi7TfP4tRWuSKFfOYlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4p8OQ5PaliSwyfNhZCvXweEPiwbHX/NGat+xme3VQgBNOny/
	vux+VkGxIuvbnCfcR3fdNLxKQbpIaozXiBMZQNFZ1fO2LD/Sidxa874mtcYz6sBAFrc9qx1bLNn
	efUexLApyQ+ONc3uTng==
X-Received: from wmpx37.prod.google.com ([2002:a05:600c:18a5:b0:476:ddb0:2391])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458d:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-4801e341e2emr60365675e9.19.1768650907837;
 Sat, 17 Jan 2026 03:55:07 -0800 (PST)
Date: Sat, 17 Jan 2026 11:55:06 +0000
In-Reply-To: <aWrSkAPFkdH_tvtN@tardis-2.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com> <aWrSkAPFkdH_tvtN@tardis-2.local>
Message-ID: <aWt4muGXbe7lBmXt@google.com>
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Sat, Jan 17, 2026 at 08:06:40AM +0800, Boqun Feng wrote:
> On Fri, Jan 16, 2026 at 03:46:35PM +0000, Alice Ryhl wrote:
> > I'm sending this RFC to share an experiment I'm looking at. This may let
> > us replace the range allocator in Rust Binder with a maple tree.
> > 
> 
> Thank you, Alice.
> 
> > An RcuBox is like a Box except that it lets you obtain a &T that
> > outlives the box by a grace period. It does not allow mutable access to
> 
> I think the `RcuBox` can be folded into the more generic RCU pointer api
> [1], e.g. Rcu<Box<RcuBoxInner<T>>> where RcuBoxInner<T>: HasRcuHead. The
> benefits are at least 1) we use relaxed atomic read for RCU readers
> which guarantees address dependency that RCU needs under LKMM (while in
> the RcuBox here, we just use plain reads), 2) we also support mutable
> access as well.

1) But mtree_load() does use rcu_dereference() to obtain the pointer?
1) "relaxed atomic" does not sound like something that provides an
   address dependency to me.
2) How do you intend to provide mutable access? By waiting a grace
   period?

> As for the progress of that effort, the Rcu atomic pointer is almost
> ready [2], I will likely send it early next week. For the `HasRcuHead`
> part, as you may be aware, I'm working on a generic `HasField` approach
> to avoid duplication of `Has*` trait and macros [3], that requires some
> syn adjustments from Gary and Benno, but they should be available next
> cycle. I will probably send the patches for reviews before that. Once we
> have that `HasRcuHead` should be easily to add.
> 
> Given the WIP code I have, I *think* we are not that far from providing
> what you need for binder.

Hmm, so I looked over [2], and I think my RcuBox is an RcuOld<_> rather
than an Rcu<_> under this model. Though I can't afford to pay
synchronize_rcu() for cleanup - I need kfree_rcu().

Alice
