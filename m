Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8C3C1D53;
	Fri, 31 Jul 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485133; cv=none; b=nA/elfiJNfa7Ujtsv6qsFxzKnMOHPQJvBCE7b51f3fAx7oD/UOUB1803px8uPef1npCjV/+QPB/UnoZqNNs6Dz9cnmbj07dJwirABJCcUI+/w3UfBRQHQEHp18WVdIf0wOAsdkUSra8iMGo/49x9+SQMAR1RQTJ0GKrX8egaa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485133; c=relaxed/simple;
	bh=sFODsdZOcNm0gekpE5+jEpQIm/WtPGZmb8Mtayj7aCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhvQUJAXGEduwHcK6QMam0GFIaYi6p3l3pg+rmmpFuNlSyPcDPdJV7De1Ix0MDk+l/uhw5/Wjr+goPq5Sj+7SP1fm0mTh4bi4qxhTmVkfrGyDj2HtKgsuXxSDDeMzad9ej4votSVbvZVy05ZT5cTvHdFIN7j0G6DPQx+FKEqEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhkAbHXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhkAbHXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138741F00A3A;
	Fri, 31 Jul 2026 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785485130;
	bh=FZuzxmSnBQOpaEeW/8N4DI3loKXJJljrvFvwaulbdt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhkAbHXnlcGidJuc7z8VLE/9FALjC1r4HjFV+0a4fD/msUV+zzWU7DQvxcCpirlFz
	 2T2ZHqgWU/I0zTnKBp7u+PiEvvq+OF0SYyu44kTWdkiA4hzObEnWXeFSQTY9Zj2zRS
	 rroSFmlB/SidmUvy9dySLsF5/iFdAwwlCCkd06aJnpodmrF45nqjP5+WvjE5lDo8pv
	 llWnQQZ6CCF4T9DuOjoOwm0sDgWrFR5+Rsw4pdbjl0+WJJYiRstKN/MjFWv0Hfyo0O
	 1673F+BjGXw5SWKRMtKtKhNiNpSHbUSSQY2CwAqXbRpyGp/+Ls6jNCneZUjm25QnPT
	 kzuxUiUE/4I1g==
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
Subject: [PATCH v8 5/5] MAINTAINERS: Add entry for Rust dma-buf
Date: Fri, 31 Jul 2026 10:04:10 +0200
Message-ID: <20260731080411.848772-7-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731080411.848772-2-phasta@kernel.org>
References: <20260731080411.848772-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rust does now have abstractions for dma_fence. These abstractions are
quite complicated and require expertise with both the C and the Rust
side. Therefore, using the existing entry also for maintenance of the
Rust code appears reasonable.

Philipp volunteers to help maintain the dma_fence abstractions. Add a
corresponding MAINTAINERS entry.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 721ecafe4b2a..e00e8ea312dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7622,6 +7622,7 @@ F:	fs/dlm/
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
+M:	Philipp Stanner <phasta@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7635,6 +7636,8 @@ F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
 F:	rust/helpers/dma-resv.c
+F:	rust/helpers/dma_fence.c
+F:	rust/kernel/dma_buf/
 K:	\bdma_(?:buf|fence|resv)\b
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
@@ -8627,7 +8630,9 @@ T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
 F:	drivers/gpu/drm/nova/
 F:	drivers/gpu/drm/tyr/
 F:	drivers/gpu/nova-core/
+F:	rust/helpers/dma_fence.c
 F:	rust/helpers/gpu.c
+F:	rust/kernel/dma_buf/
 F:	rust/kernel/drm/
 F:	rust/kernel/gpu.rs
 F:	rust/kernel/gpu/
-- 
2.55.0

