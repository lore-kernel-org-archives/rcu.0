Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B48423C;
	Wed,  5 Aug 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946325; cv=none; b=PScM8SGoa7Xe12Z7h8TQ2AHKGXKiGY1sxFGXPm6dcRaNMZjZD2nUfbgap7mk1+GS1rR2dJIAsDQZPK0T4rFA3q/UJEvloes2G92pfY9xAD7W6JNLFp80Nn2t6Do650gYZHBh15kus4AG6WBU03W3yzbDrKOv4MselV3umpUXWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946325; c=relaxed/simple;
	bh=pLUmslCAKli5eS6BVXk/fZasQKXL8cvdH6dyunbQjpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJhAr2dwu6KYvttwDgoBhuy8PSTS0mXJIwRgkXp7Xui7+5aT6+XxjB96T9hzMDOVl8djrOg0jIjuL755rmTIn/5AjwMRJ+TyFVVExrjYZW525GqcY6MRqXWmouXGKYyZKbx5Yb8Zb/nRIPyyHiDhbLmNDjPhkDE7jdrpBofau8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PClHvRdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PClHvRdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D601F00A3E;
	Wed,  5 Aug 2026 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946319;
	bh=7qgVCEMFfeXqOm+h7mElNk6mJJTmwO2Mx/jFGHen54s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PClHvRdFNOUd/5FBgmDqVJrtLHxEBI+M71llKg81WAyfe/Pn6i9zzvbSDCAIVgN/u
	 Dt55fb7qPhrcxRohsojbTUG/dNH+g8rqpkrobhtw21wRSFZ7EQwKmSkFkc+FZif2Gj
	 aN3cBD7erbko7e3RYt4jIqjMnX5Or358JZs8d+CLVIdKMibP/mDhDhNDo75ZvE1/iA
	 UJp+I2sxB6/7t6GdbqAI0Ia8bTKZ9YD1lkA60/vJK8CDEs0h5mNe7m6ntECjvB0ZPm
	 6O172hpS7fs0bHx8aFe5a7BG4ijn0sMdnZFdgCQynCiAL/LiZCkIS+l0ysAS5UtKnY
	 HMwpQC5JGPFog==
Message-ID: <15e9c1d6-e39a-440d-a9aa-5b150ff2cd1a@kernel.org>
Date: Wed, 5 Aug 2026 18:11:51 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] rust / dma_buf: Add abstractions for dma_fence
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Mirko Adzic <adzicmirko97@gmail.com>, Timur Tabi <ttabi@nvidia.com>,
 Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
References: <20260805145949.938505-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 4:59 PM, Philipp Stanner wrote:
> Danilo Krummrich (1):
>   rust: types: implement ForeignOwnable for ARef<T>

Nit: You also need to add your SoB to this patch; you can just reply with your tag.
> Philipp Stanner (3):
>   rust: sync: Add abstraction for rcu_barrier()
>   rust: Add dma_fence abstractions
>   MAINTAINERS: Add entry for Rust dma-buf

Good stuff! :)

> Timur Tabi (1):
>   rust: error: add remaining error codes
Also needs your SoB.

For the series,

Acked-by: Danilo Krummrich <dakr@kernel.org>
