Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F293E558A;
	Wed,  5 Aug 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919857; cv=none; b=GQIumzKgtnui1/Y55h/N3fHvR2R8s2ZIlYXUTearGGsQwLFBHTi6ENcofO2rbWHa6GpvZm0+iW+W6nJa1xZEATj4/1qiFT0gFb+EopRPv67mnbTYLtP2R/xk6Ar8/bnOHqXtZobm9QVczgYhJeZLcXvD4b2V7weZdgkjc+uQexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919857; c=relaxed/simple;
	bh=zM2Cc63xKCxAoBLXLPcSeNbDsA2llpVWwzg9g5qE0zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnNMv9u/xqddYhmhyO62idoycQPuclLgIg2L+AmA63tQuIHzB4780rbNpE6KRhHNYHli/gc6Q6+8CBr4Q1gy4M6T7ffC6Ki5ko5Mqz8T5IAq1sdj/IQWrIauNJQwFCMX29llLEkZdzTVSUEIBoae2F7KSM6hIrzpSPsyBuLIGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVRL+6iY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVRL+6iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E71F000E9;
	Wed,  5 Aug 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785919855;
	bh=zM2Cc63xKCxAoBLXLPcSeNbDsA2llpVWwzg9g5qE0zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VVRL+6iYv1yhmElNNYw6kF15OzzK/W6LadgQ5dpUhJ2TRgfyuXDlpWh10nJD+DpWd
	 PliDDQ8qBUFWG+U4Qsx9jeNhhx7bko0rx9J4V4qrS2eaTPdykRXH4GWZp6/OS2S1Th
	 sG8NjzKLBC+AY1Vx6y641p6+K8HNSVtjOslJL408yMR0cmEI++Tzqt3F2tMI1/jEj6
	 BP77nXqN4T+B7c278RGEFoWXj6XUZmTZqjTmrFOVghjyPZtlEKyiyniCu9xwhpA0NI
	 40hxzdMrIBspnu7Po9RCQvZH5qGy2MozxK2mPoApLPDwbHXHeoafF8UUAH/wkNO8sj
	 3qtiSxlXrsa+w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Lyude
 Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>, Lorenzo
 Stoakes <ljs@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic
 <adzicmirko97@gmail.com>, Daniel del Castillo
 <delcastillodelarosadaniel@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 4/6] rust: xarray: Add support for index reservations
In-Reply-To: <20260722144931.1070312-6-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <AR60HaAmgoRArB0MtLSPafNeuclmXBF50OveeRR2_bXpofTeHInyi-US9AnrgXyIEZYKcEYGLBGd5lzHqCkOFQ==@protonmail.internalid>
 <20260722144931.1070312-6-phasta@kernel.org>
Date: Wed, 05 Aug 2026 10:50:40 +0200
Message-ID: <87se4t7xy7.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philipp Stanner" <phasta@kernel.org> writes:

> One often cannot allocate in the kernel with the desired flags, most
> notably in atomic context. Pre-allocating the memory is the preferred
> solution in such situations.
>
> Add support for xa_reserve() in the Rust abstractions of xarray. Create
> a Reservation object similar to a lock-guard, that can be dropped once
> the reservation is no longer needed or once the index was stored to.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Please regard this more as an RFC.
>
> I need pre-allocating in XArray for DmaFence. How exactly we achieve
> this is open for discussion.

Do you need to actually reserve a key, or do you just need atomic
allocation?

I have a series that solves the allocation issue here [1]. Tamir did a
reservation API a while back [2].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20260604-xarray-entry-send-v4-0-965f6028790e@kernel.org
[2] https://lore.kernel.org/r/20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com

