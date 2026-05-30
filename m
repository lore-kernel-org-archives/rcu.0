Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505D2DF717;
	Sat, 30 May 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154867; cv=none; b=d4OB2N38npwP7t78rMabUaT4egifjWz5NqdbvKCktMZkkXvjIev3hz+cRc1a5ePszAkghxdHHW0TPhFizEppdJf3HV6thjz9fIMotLbAuFgDaNGcd18CWLkQXZ6JTmeYC996JeXxZ29RZA6xC70qVYfEHxDGnEUA2uuPaw2sqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154867; c=relaxed/simple;
	bh=JzNwHAlWijeIAaG15DTA2o5Tf9s2L7yI5CPXH7a+wi8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kyCEEemcH2ZlPK80SIxmiIqCbjwtdXNmKVTHH2znmrjpsSalvFECTp3VBwvkFMW5VQ/QEu3zLykkY5rpxl3KygD0X44iaqdKJjdnFHd8HMdJpNFAdDDdnWhV7jrA8gKSW6ooMNiruFdmGdEuKzJXuisTTdiXtHA6/8yT2b5AMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlqV5rtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlqV5rtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76381F00893;
	Sat, 30 May 2026 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780154866;
	bh=JzNwHAlWijeIAaG15DTA2o5Tf9s2L7yI5CPXH7a+wi8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=PlqV5rtUI6f9pzKL6aAEp+ROgJjj+sh4ZJqNOuJh2RWXEY75/QdgcavEFArDBDdzG
	 qDYr/VmZeRxgIm73QBDrlOHUB1FPPYLqiGCWSNxb7QJD2N6mCTBHEYLNwHHxy0h104
	 UFlAdxA4Oi9LEUnoyuYzscH0IG27O//ciYKe5QMuK/Uyl/KnPP+Qpq57Y2OiGHJP1Y
	 /0NL7Ho0IumfW86Ai2o2W2pBosUBtA6n3EAQQAMThS3PYsniiPVQKVxlr2s3jMg5L7
	 y+LTcjdHivWP2c9vLPNp2/hniUFMFmg86acan+82wKvuxWpsJYdRiJR/kgKa9FbCOw
	 RFql/BO+U+O+g==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 17:27:38 +0200
Message-Id: <DIW48C65445Y.1VVD8AEDB35UM@kernel.org>
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
Cc: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
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
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <rcu@vger.kernel.org>
To: "Boqun Feng" <boqun@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org> <ahr9gtzQLSbPeBx_@tardis.local>
In-Reply-To: <ahr9gtzQLSbPeBx_@tardis.local>

On Sat May 30, 2026 at 5:08 PM CEST, Boqun Feng wrote:
> type RcuKBox<T> =3D RcuBox<T, Kmalloc>;
> type RcuVBox<T> =3D RcuBox<T, Vmalloc>;

type RcuKVBox<T> =3D RcuBox<T, KVmalloc>;

> To support RCU-protected vmalloc allocation, we need to make `RcuBox`
> generic over `Allocator`. Currently this works since all `Allocator`s
> are either kmalloc() or vmalloc(), and kvfree_call_rcu() works with both
> allocations.

I think we can add Allocator::free_call_rcu().
