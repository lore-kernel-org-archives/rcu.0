Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DB30C360;
	Tue, 16 Jun 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623694; cv=none; b=qvFHMzqTANG6Tp8p/AiQwvjhAxRxmXiG0tswkv8jodpoNHEWuKR/kFfuhfYQDn++jd/KiTYRJMpCp5/WzQkPfFBOJx1hwOEXyP5bK7uGGCiTaOVkjUf+zuFbGHswR0MNRC3ihnmKDLskDoZy8UuobEbytr3CLYD66kMdIu6bEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623694; c=relaxed/simple;
	bh=KTPFzRNp3UqELYgoWeZnt3CM5M9+y07XBMT3rlA91bo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Hbj2rXgvplJMG8sPncUKSLyN5yNKNrUrErA+jEIukc8SCSmWB/aeVUA8hN2p0L4Byjde7Lvu0cM0utKoddrmCmKfUpBerdM+A0POGfu5b+JM7RzDW8BRMnhicow62yk0oz67lacHopw2SX8x0SkBO/a0ZOXLzlH43ZiWqOHsQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrxioINo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrxioINo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795211F00A3A;
	Tue, 16 Jun 2026 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623693;
	bh=KTPFzRNp3UqELYgoWeZnt3CM5M9+y07XBMT3rlA91bo=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=BrxioINockLKwWsvcBd9ayjh5CHH4WSzRwy1vkp85RTyeFH4zBaP0BInXvxmMVKnz
	 h/sYVd8wWdUxioziefxH6Kq7kyIyIBnxiE83DrD7sb8OXmAt4/wmZezjTHQrOxbMbf
	 o5Ju1PeFdvWHMYBipOYkoRoVL4AKgeTYeBUGA6VkBEDqo2Lkss6nwGOLjMR2i0hChv
	 tDa+0ESYVWUygGAXw4bPPUI/eZRNtuY+bqmVrWa/SF/6Yxga2bswqGftqF7BqOj+g5
	 6dBuqsS/B6zEOvT4LAxT2plEXHn0GgRG3xews+mOa9PcD5nKbijw3DPtB7v3Y5zr1c
	 67tnL8yvAyy0g==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 17:28:04 +0200
Message-Id: <DJAKVXTHQJ99.152VRPFJDPTRU@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
Cc: "Philipp Stanner" <phasta@mailbox.org>, "Philipp Stanner"
 <phasta@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Krishna Ketan Rai" <prafulrai522@gmail.com>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, <manos@pitsidianak.is>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rcu@vger.kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
 <20260616082819.2943886-7-phasta@kernel.org>
 <20260616124755.460550-1-work@onurozkan.dev>
 <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
 <20260616145112.14201-1-work@onurozkan.dev>
In-Reply-To: <20260616145112.14201-1-work@onurozkan.dev>

On Tue Jun 16, 2026 at 4:51 PM CEST, Onur =C3=96zkan wrote:
> repr(C) only makes sense when the type have multiple fields.

I don't think that's universally true. repr(transparent) guarantees the lay=
out
and ABI match the inner field. The wrapper is passed through calls exactly =
as
the field would be. repr(C) guarantees C-compatible layout and makes the ty=
pe
follow the platform's C ABI for passing an aggregate, which isn't always ho=
w the
bare field is passed.
