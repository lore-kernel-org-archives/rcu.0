Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BA3264FC;
	Tue, 16 Jun 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598531; cv=none; b=ju8r4+A9w+15o/fF5LZZYkKEf1AwWnpp8AV9yRlE5mYP0uIxwTM+Xltyh51d2sqqjhIuFrrKrlQDTo024NfQ82K3wpSFBfkEd8F1dfBSpmnLEqZwSVm74tapyquah2TiNNKmUb18M2CYoUow+012YYGA4BbicHl3N1isJ4SNaAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598531; c=relaxed/simple;
	bh=yZ08N+kRCPc3va6G4KH7wajQF4Eh36FakJDqJp1B6P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YpSgm2nkgJPFjVq5geiH7ae4itX1eDli4JXQTwcCU/1W+6Ge3Mb2VOozZoUtt5Qq8YmbD5B+9qWU0+mgX6CXP7p0HmnM3u84dgxh/bLRdBLtwLn6rCAUGRQWDNXmhTW0ZGFPPdvl8nCny+4gakq604MH4aK7clW/Q2mjek69KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkAsvucu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkAsvucu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8F21F000E9;
	Tue, 16 Jun 2026 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598530;
	bh=m8gM8nnPJCjiAangsZ9/IeVwjm4OqGdrfi1ud6iCyJU=;
	h=From:To:Cc:Subject:Date;
	b=QkAsvucu5jVBrxPbQ8u+5R5lxBG11ubcXaiwrSb2lxhkkFLf1uhJ5ZLTByjYfYl10
	 Km+xBtCajc2oZ0zio7LMIQqZUevR3pqn5SlEchcA9Av5Xig6ffnW2+m3gKt5yWPdoB
	 7X7p0CARa5ezzjLCRwf0enDrMxal85axxOvaKlvetvSMoofhq4qWqyZpG84WOg8AkH
	 fvlD6ma2HOUPiYJ1J9yMXH9zx6frs74LWbeKMyW4lWo/cNdZe0196Z37wQ2f5+kUOu
	 5DxNBkF9of5nEFbtGAE47ZXOosInRjf4mrUgHuWNK2Ku3zFejjN9rfOHp6cgRDYdCL
	 3bkjgA3l95OSg==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rcu@vger.kernel.org
Subject: [PATCH v2 0/6] rust / dma_buf: Add abstractions for dma_fence
Date: Tue, 16 Jun 2026 10:28:12 +0200
Message-ID: <20260616082819.2943886-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

New version. Most significant change is regarding RCU. See changelog
below. Also see [1].

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

Philipp Stanner (5):
  rust: sync: Add abstraction for rcu_barrier()
  rust: sync: Add abstraction for synchronize_rcu()
  rust: error: Add ECANCELED error code
  rust: Add dma_fence abstractions
  MAINTAINERS: Add entry for Rust dma-buf

 MAINTAINERS                      |   3 +
 rust/bindings/bindings_helper.h  |   1 +
 rust/helpers/dma_fence.c         |  48 ++
 rust/helpers/helpers.c           |   1 +
 rust/kernel/dma_buf/dma_fence.rs | 884 +++++++++++++++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       |  14 +
 rust/kernel/error.rs             |   1 +
 rust/kernel/lib.rs               |   1 +
 rust/kernel/sync/aref.rs         |  39 ++
 rust/kernel/sync/rcu.rs          |  14 +
 10 files changed, 1006 insertions(+)
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs

-- 
2.54.0

