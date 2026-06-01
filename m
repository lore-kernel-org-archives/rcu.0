Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896B39D6EE;
	Mon,  1 Jun 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311589; cv=none; b=HpMsRjT74gfIlztEeBI+xXBIX6mhzS4dMngshjsrpiqmrWgPl0kgjeVD1tMk/d+mAIigGh9S76FtVsNZovHpfU8UPnERy082nYy/7RHZ/4c085xUqf/q78QFMv5bpXhZk97nUtwkdcOrtu+FM+rKPBphs1vB5NzZvO7FdrO2wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311589; c=relaxed/simple;
	bh=Oj7qS6tCatuQd6v/AdPdQ1yTq6EBjPpukk1n6mBZaDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwp1hFpq1yj5Xp50gvT6spdpF89ADAzPYvq5RLBI+ZN8ucOue72rI2FHWOV+1o7fCocnf6SJYVjAIGkbYtiJeYjNvHkq7+XYx6AmdSifRwsAZRHnggyOZKwFq4Fuj2Vg3sS3826ezGLMSCanMnd8RQWbCrjQ+0NYXJhy+m4M67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jDT3G3Jb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jDT3G3Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780311580;
	bh=Oj7qS6tCatuQd6v/AdPdQ1yTq6EBjPpukk1n6mBZaDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDT3G3JbDb4+8nGVmGp41Da6WyNqifQEpLVE2rktUe7VEhM4wwEzU4zxPEO0mRCAZ
	 S54cSYDjRxD8i73BAg8QcPiKMhCmTQlsa2eUnXeCBzbkLLyk0rlHfeeMa+sAN3nFig
	 7Pim0wDrdbyRkB0oZjtsguBfJpnrUPphEp85nC3TlCJDVzjL8NGrJc1OKUu4HVx/tK
	 x6AYIk5mNJk0r9a3z9n7SNSnTjmSoYUEy4l90Op/WJxMxMD2osYYyHDqpJeTuz2xVD
	 8QATTOHpmh9+mdxg/7B5BqOCwYgiH/sppl30tsGDS276dRqxW2phCf1oaNzuNL83f1
	 yRoJrH22VFiwg==
Received: from fedora-2.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6223C17E03DA;
	Mon,  1 Jun 2026 12:59:39 +0200 (CEST)
Date: Mon, 1 Jun 2026 12:59:33 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>, Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
Message-ID: <20260601125933.17ca4dd5@fedora-2.home>
In-Reply-To: <ah1glmXDM-OAKa5h@google.com>
References: <20260530143541.229628-2-phasta@kernel.org>
	<20260530143541.229628-5-phasta@kernel.org>
	<ah1glmXDM-OAKa5h@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 10:36:06 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> > +};
> > +
> > +use bindings::ECANCELED;
> > +
> > +use kernel::str::CString;
> > +use kernel::sync::{
> > +    aref::{
> > +        ARef,
> > +        AlwaysRefCounted, //
> > +    },
> > +    Arc,
> > +    ArcBorrow, //
> > +};
> > +
> > +/// VTable for dma_fence backend_ops callbacks.
> > +//
> > +// Mandatory dma_fence backend_ops are implemented implicitly through
> > +// [`FenceCtx`]. Additional ones shall get implemented on this trait, which then
> > +// shall be demanded for the fence context data.
> > +pub trait FenceCtxOps {}  
> 
> This empty trait is unused.

I had initially suggested to add the F type (AKA FenceData) passed
around in multiple places type as an associated type

pub trait FenceCtxOps {
   type FenceData: Send + Sync;
}

so we don't have to pass both F and C. The reasoning here is that:

1. We expect we'll have to define more methods to the FenceCtxOps trait
at some point, so adding it now kinda makes sense.

2. In the current design, we've assumed that a Fence can't live/be
created outside of a given context, so there's no world where the
FenceData wouldn't be known by the FenceCtx implementation, and forcing
users to pass F and C around seems needlessly verbose.
