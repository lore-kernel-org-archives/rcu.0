Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200442981C;
	Tue, 16 Jun 2026 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607736; cv=none; b=GmPhPTMfn18n8ep4ywpwpD6HvXMAhS5FLSaqW31yWbQAhJimhf0W09h5Wcog4reHDjg/zwpBw8fkfM9S72CGA/EEO7ocA63FvVwG6MYGfZ9ZpaCusxncAxxwPxqNVABPtt59voIVcrvPfF7eCkbhI6oJFK8p71IQgl+TyFTsnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607736; c=relaxed/simple;
	bh=5d5C3DUtpWx5RhNtKmmckeqo4zoWOKCchVwP5MlaYR8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eJoJzGSQYvRiD7HWPFqcK8TBU9AhbyyQIUokvpRw9wQVVDd/J1wTY4kaFskS/3hUA+yJYgET63YyhohqlrYt60qv1/1S1CqXtp+4S83geYPJxq9eUi+OmIOeoQTk+oOVF1QvivMkIkfJYvgeG5k/yzDmmndA0oHbff0KDb6N8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQq18BbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQq18BbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE3B1F000E9;
	Tue, 16 Jun 2026 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607735;
	bh=FZdmkJa6dqoSyrKuaAVidWmX42dvojCrnG29qH9XCgw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=cQq18BbZC4JXqTwKwf+CBS3TKAMMmefYiM1Ym96bLGdhPIzG7Co8NkIkLjH9MItPx
	 UGCD6xe0cbB2mVyBbPOBRhKMH+kNEYv+T0uZr/bTpYrn7ZhQS/ArXVCWIY9mTf61cG
	 wUV4zW91EJMYL4P0ChI9nnkmPJO6qJDpMiE9soBsKIqhEFk4ftie4xNalLTUp1Lxpi
	 zffNy1CQtg9ngSo/OcREICPqxInKJ34VEzwoBPmAJt/PZYROHgrZaBJ/XtiYB1mPzK
	 HPvLFPyr62rbPgRJdRFpA0hbS0AMG3fMNxH8RtfdasRvEvut+gK64S5hSmJzDtm6zu
	 aboGmQh5BSdbA==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 13:02:07 +0200
Message-Id: <DJAF8AXHRRIX.2E0FNAQP3DOWK@kernel.org>
Subject: Re: [PATCH v2 0/6] rust / dma_buf: Add abstractions for dma_fence
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
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
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>

On Tue Jun 16, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
> Changes since v1:

It seems that some of the comments from v1 [1][2] are not addressed, did yo=
u
forget them?

In particular the pin_init_from_closure() looks unnecessary and can probabl=
y
replaced with something like (untested):

	let mut callback =3D Some(callback);
=09
	try_pin_init!(Self {
	    cb <- Opaque::try_ffi_init(|ptr| {
	        // SAFETY: `fence.inner.get()` is a valid, initialized `struct dma=
_fence`. `ptr`
	        // points to the `struct dma_fence_cb` field within the pinned all=
ocation, so it
	        // remains valid until `dma_fence_remove_callback()` in `PinnedDro=
p` or until the
	        // callback fires.
	        let ret =3D unsafe {
	            to_result(bindings::dma_fence_add_callback(
	                fence.inner.get(),
	                ptr,
	                Some(Self::dma_fence_callback),
	            ))
	        };
	        match ret {
	            Ok(()) =3D> Ok(()),
	            Err(e) =3D> {
	                let cb_back =3D callback.take().expect("success path did n=
ot run");
	                if e =3D=3D ENOENT {
	                    Err(CallbackError::AlreadySignaled(cb_back))
	                } else {
	                    Err(CallbackError::Other(e))
	                }
	            }
	        }
	    }),
	    callback: callback.take().expect("error path did not run"),
	    fence: ARef::from(fence),
	}? CallbackError<T>)

Please also see my previous comments regarding DriverFenceBorrow, it still =
seems
to miss the lifetime and it should probably use ManuallyDrop<DriverFence>.

It also seems the patch series was created without --base, what's the base
revision?

[1] https://lore.kernel.org/all/DIW3ZK5NLKU3.1QYMQB0ISHFBG@kernel.org/
[2] https://lore.kernel.org/all/DIW42TO5HY6H.2RLL8V8H48A5A@kernel.org/
