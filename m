Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32F1E1E16;
	Fri, 31 Jul 2026 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485076; cv=none; b=nDdbVytNp8+2Yfy8P6xHRq2SxDcvvyrO1zw1gbuVBrLWZDAOUP4p83tB7YT5Gas34YoP8j6qvYfNYcaUJy0hwEkrG+172yntS0JEqd75aDC1e8voIyT8fReW1WuTvInh8BWr/DQxcM6h2a651q2qpD/slgsMK5E5EPus8q7P4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485076; c=relaxed/simple;
	bh=BZ4twpBYsqgr+QnhmwMxNbH0etFYcp33jC+5Im+9hAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uG6YIkxG9TiWS8Je+P3vx4UHRKNSVZx2hm7lHXT9xzkjD882AvF5ZG6ynzkmzOR1qnulQwft+Nb0eynAWtxN8lyS65EqpKKkcw8hH6z2OjQnT9LB7RXFPZzEiCHG+YCxxL9pX4YSg8A0GTYB3s4jsXppBpP8Fa3JKFgwwaCel60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/MnDO0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/MnDO0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BF1F000E9;
	Fri, 31 Jul 2026 08:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785485074;
	bh=+ihA+jCjxFFFcushqgnFz5EpHjgmUlz7qY0YpA0rFtU=;
	h=From:To:Cc:Subject:Date;
	b=L/MnDO0dwcG9fHiU7Mw3fjfPJwMgFgN9XP3nllaHVyAkL53j06j+gA4kR2KralFNS
	 f+Z4Q+DNB89GjHslgC8EJKpE/dz6GvS0Q5xkEiOSj/Kmh5OKVJ2tCpYsJ1N51e+Ar9
	 yWjc+MgT2b2pN2WOm3d2uXOwoqV0Xig/arguvNZ4Km/p2A9RQ3P6mH3PuVIpSfrKle
	 COqL5u1o4qzqbmABZl7Ny1DAhg9YXPhRJwKsMfe0oWa6ci6VfqF4c0HDtokEMjllIA
	 OXt1u5ey69U5ytlX/5OxWuc//kV0VOOxXL7aihuEt0H6YVRCIK0OeX/spZ68U9DT89
	 Yo2bqMoylasLw==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Burak Emir <bqe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org
Subject: [PATCH v8 0/5] rust / dma_buf: Add abstractions for dma_fence
Date: Fri, 31 Jul 2026 10:04:05 +0200
Message-ID: <20260731080411.848772-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(Timur's patch is just included so that the series builds)

Changes since v7:
  - Remove the forgotten-fences-tracking from FenceContext. Merely warn
    in this unlikely case, using an atomic integer.
  - Be more verbose in warnings about what exactly the problem is.

Changes since v6:
  - Add Timur's error code patch (just so that the series builds. Merge
    however you prefer). (Timur)
  - Replace XArray with list, remove XArray patch.
  - Detail the issue with core::mem::forget() in the commit message.
  - Some code formatting etc.

Changes since v5:
  - Because Rust can "forget" DriverFences, it could bypass the lifetime
    ensuring that DriverFences don't outlive a FenceContext. Mitigate
    this by having the FenceContext keep track of unsignaled fences.
    (Danilo)
  - To support the point above, add support for memory reservations to
    XArray.
  - To support the point above, have FenceContext::alloc_fence()
    increment the sequence number. This is necessary for the xarray
    index. It might become critical with fence seqno holes.. please
    review.
  - Remove acronyms in declarations. (Daniel)
  - Allow for providing initial seqno in FenceContext::new(). (Daniel)
  - Flesh out documentation about DriverFence <-> Fence. (Daniel)
  - Flesh out documentation about weirdness in C backend. (Daniel)
  - Add new, purely internal locking helper / guard for dma_fence.
  - Use the kernel atomics (Gary).
  - Curse angrily at my computer.

Changes since v4:
  - Fix an uninitialized memory bug for FenceCbRegistration with
    ManuallyDrop.
  - Return FenceCtx as impl PinInit
  - Make FenceCtx return an impl PinInit<T, Error> (Danilo)
  - Reformat some comments

Changes since v3:
  - Add a FIXME for an encountered Rust compiler bug. (Gary)
  - Add new Rust files also to DRM drivers & common infrastructure
    MAINTAINERS file. (Danilo)
  - Reposition ECANCELED error code. (Miguel)
  - Replace refcounted FenceCtx in DriverFenceData with a reference plus
    life time. (Boris)
  - Re-add rcu_barrier() patch, since we now can use it for dropping the
    fence context. (Danilo)
  - Add forgotten R-b from Alice, and Acks for MAINTAINERS from
    Christian and Sumit.

Changes since v2:
  - Don't drop DriverFenceData as a whole, but only the members we
    really want to drop. Gives more robustness. (Gary).
  - Break apart large pin_init_from_closure(). (Danilo, Onur)
  - Remove rcu_barrier() and synchronize_rcu() from FenceCtx::drop().
    FenceCtx might drop in atomic context, where you must not perform
    those operations. With the current way C dma_fence is designed, the
    driver must wait for a grace period manually until it unloads.
  - Repair the DriverFenceBorrow implementation, properly injecting a
    life time into it. (Danilo)
  - Fix memory layout bug for rcu_head. (Onur)
  - Drop RCU patches, since this series doesn't need them anymore.

Changes since v1:
  - Remove unnecessary mutable references (Alice)
  - Split up unsafe comments where possible (Danilo)
  - Remove PhantomData + implement FenceCtx ops trait (Boris)
  - Consistently call FenceCtx generic data `T`. FenceDataType is
    derived from that. (Boris)
  - Add abstractions for call_rcu() and synchronize_rcu() (Danilo)
  - Add ECANCELED error code in Rust (Alice)
  - Remove the rcu_barrier() from FenceCtx::drop() – because we now use
    call_rcu(), there can be no UAF access to the FenceCtx anymore. In
    any case, it is illegal to use either call_rcu() or
    synchronize_rcu() in FenceCtx::drop(), because our new
    drop_driver_fence_data() can run in atomic context and might put the
    last fence_ctx reference.
    So we now only have to guard against module unload, which it seems
    either the driver or Rust driver-core / module unload infrastructure
    must solve.
  - Minor formatting etc. changes
  - Add C helpers to MAINTAINERS. (Danilo)
  - Ensure that `Fence::is_signaled()` is fully synchronized, i.e., all
    callbacks really have run. See [1] and [2]. (Myself, Christian
    König)

Changes since the RFCs:
  - Include support for ForeignOwnable for ARef, so that a Fence can be
    stuffed into an XArray et al. (Code by Danilo)
  - Implement ForeignOwnable (with new borrow type) for DriverFence, so
    that it can be stuffed into an XArray.
  - Include the rcu::RcuBox data type to defer dropping data with RCU
    (Cody by Alice)
  - Port DmaFence to RcuBox to make UAF bugs through later, new dma_fence
    callbacks (backend_ops) impossible.
  - Force users to pass their fence data in an RcuBox (or have it not
    need drop()) through a Sealed trait.
  - Document the rules for the user's DriverFence::data's drop
    implementation very clearly (deadlock danger).
  - rustfmt, Clippy.
  - Various style suggestions, safety comments, etc. (Önur)
  - Add __rust_helper prefix to helper functions. (Önur)

Changes in RFC v3:
  - Omit JobQueue patches for now
  - Completely redesign the memory layout: Instead of a Fence
    refcounting a DriverFence, both now live in the same allocation to
    allow for future support the dma_fence backend_ops callbacks which
    need to do container_of. (mostly Boris's feedback)
  - Allow for pre-allocating fences to avoid deadlocks when submitting
    jobs to a GPU. (Boris)
  - Simultaneously, allow for pre-preparing fence callback objects, so
    the driver can allocate them when it sees fit. (code largely stolen
    and inspired by Daniel).
  - Signal fences on drop, ensure synchronization.
  - Force users to set an error code when signalling.
  - Write more documentation
  - A ton of minor other changes.


[1] https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.org/
[2] https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kernel.org/


Alright, so since the last RFCs did not reveal significant design
issues, I decided to transition this series to a v1 and hope that we can
get it upstream.

This now includes code for more common infrastructure that dma_fence
needs, contributed by Danilo and Alice.

---

Old cover letter for RFC:

So, this is the spiritual successor of the first / second RFC [1]. v2
also contained code for drm::JobQueue, but mostly to show how the fence
code would be used. JobQueue is under heavy rework right now, so I don't
want to bother your eyes with it. The docstring examples should show how
Rust fences are supposed to be used, though.

This v3 contains a huge amount of highly valuable feedback from a
variety of people, notably Boris, but also from Alice, Gary and Danilo.

There are some TODOs open (a better trait for fence backend_ops and RCU
support), but my hope is that this effort is now finally approaching its
end.

I would greatly appreciate feedback and especially more information
about what might be missing to make this usable, which is obviously
where Daniel's and Boris's feedback will be valuable once more.

Please regard this patch just as what it's titled: an RFC, to discuss a
bit more and to inform a broader community about what the current state
is and where this is heading at.

Many regards,
Philipp

[1] https://lore.kernel.org/rust-for-linux/20260203081403.68733-2-phasta@kernel.org/

Danilo Krummrich (1):
  rust: types: implement ForeignOwnable for ARef<T>

Philipp Stanner (3):
  rust: sync: Add abstraction for rcu_barrier()
  rust: Add dma_fence abstractions
  MAINTAINERS: Add entry for Rust dma-buf

Timur Tabi (1):
  rust: error: add remaining error codes

 MAINTAINERS                      |   5 +
 rust/bindings/bindings_helper.h  |   1 +
 rust/helpers/dma_fence.c         |  48 ++
 rust/helpers/helpers.c           |   1 +
 rust/kernel/dma_buf/dma_fence.rs | 995 +++++++++++++++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       |  14 +
 rust/kernel/error.rs             | 105 ++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/sync/aref.rs         |  40 ++
 rust/kernel/sync/rcu.rs          |  20 +
 10 files changed, 1230 insertions(+)
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs


base-commit: 849044a381323b141d81f6bcba628cbeb0bcff31
-- 
2.55.0

