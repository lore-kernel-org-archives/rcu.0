Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A42FF144
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666551; cv=none; b=uy+qDWQzCPQg398BPjY733dxsh7smi9tUnnxBC1mD6+khBqlGZwrQGlFcvo4cToUg7bachkIEcJqJh/F7sx4Cy+x1/O3QTISgGQFQUzXWrg1A2NFW5wfTOwR3rhNzOfzlt7oAvTOsvW+aeLQ100gU/5tbTZbJ2gN0ihNOWp4Qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666551; c=relaxed/simple;
	bh=UUhxtcNBQidBPnhJq9akfhz+nsSIhTWipy6zveKmyyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuoQ/iXwKXu7Fy6ppAKKNGxrMahi+BF7bEakW8KYgXq/QZxAmQXwh/MXgXf8M/4EHNhLVcbidQaUNdufSlqGG7XUFDE88geQikdO7EWV58eC9MgG+c2bwN9950sQDxUViTNrqdERYO4FNptEvRwH1z6tgUQRViriPOuU/WSWhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv30AGuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv30AGuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3691F00898;
	Fri,  5 Jun 2026 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666548;
	bh=V+3GJsZxiITcRMlzwywosE1kBJjYYPTTK69C+X92Rrw=;
	h=From:To:Cc:Subject:Date;
	b=Hv30AGuR+cz2CQ2dj67Yzpp52IXj2ahmvSWppUfeA7+bppg8L4k+Hy7Pfqcu4W62R
	 l0hQsQfHDF0dhRyZopukNUwZ30jtYN3jkaG1B9Ex7yFoRjEx5TNLXPXbKfUWpf0NfR
	 v64+z5I+zn3QoUp3NrsD/yYhKNsSVacQ4zGYlsxXS3JeOoRbe6uDkBrMwFFOPpJmAR
	 92/wP/EOjqTU5YsI+hvhpDCzD3jvArw0S8HR0o4CzV20pI4bnib1gCgEZYButbIKg3
	 tUXn3339talxM8SxFivN+oP+v/rv88klTG92uWDDp6r1n1cwgOU2pir71Cl4ZV1vM9
	 xaa9FveNs/CKQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B751F4006F;
	Fri,  5 Jun 2026 09:35:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 09:35:47 -0400
X-ME-Sender: <xms:s9AiaradpzQawOzKlJVdLrR4MQLkpLTE_FbiMrwK4PtwHVH_Qy5Vrw>
    <xme:s9Aiam0rZx6Vqij-n0XJQMXbyll_Wv18_UYjL5Pc6oD_1DKFgEun5JsmkyKRsLgDF
    ba5z_9a237nYuDO5K7KEU1zrsxyLGKSA93STKOyVKhnUnNCZXk-JtQ>
X-ME-Received: <xmr:s9AialO2SzzCUNoUPS8MA78Q6f4GJkThBBPf1nyzR7DSTjOoRX4s-kHFkvM>
X-ME-Proxy-Cause: dmFkZTFKENnCiyPS37jOfUW/oSt3ApI4Om6wyeJiiPYsBRF27Y77NEp2GRWEH/Wu22F/nN
    jSLPXUo+vpn9G/MZoMnCSmi/RsIDJMGfJOTTMeMH880odghXtGPynqv6EEGLiWUW12Ktmf
    F+PPRU0YRdVUAi+LO4dYxUc0b6J0tg7+Juur2hWdNU+gehj5U/NdtzZkPNhXPF4Ah90viD
    aqhiOSGPff6V/LBAdW9kqJklU4xsIoTyQSGu0+i9A580vKQSwad1R6zoD1RnChJ5FNQ0dU
    bczE0+CcxhZJZhPPbEA3Zn2zVHH/I+liU4sR06uQjZ7j0Fz1fxA7p/zOJ9UaIcNU9giYU4
    XnFhxWfhVpmI0x48ilXTpAWnWZJOWYHCRkUPVu8DzmXQd2Evddhunr9+jUv3n1xsRGUJ1h
    KQmDvz7AHx4jreqF+CU8EJa22nDQZyEc9Isrzx55OoJPiCds42Ma8cXKeCFslYjHG0g2UR
    m6MN2ENP/0QYdd3tNgHfqUXI8s9lbQEVkiZm7rEvQKJcZd9JW2V8zNmSlmmZOl++/Hc5au
    +QVxNWcUjE7N0iLrQMQT9DTEs0O5zHvXQelb/HgeoOaRMTqiwWdtOm48B35HA/2VcP5yvX
    S1vKc1wSal6Sc4eAgayfqjlzetTHUH/A4qSt4sbZEumI7lZ7JRGIbnYqaGjA
X-ME-Proxy: <xmx:s9AiaoJP5H1mQq9mKqc22IPHCNQuAKSzFAZYMeMiGwLs8-ig5fL5Hg>
    <xmx:s9Aiam4LYBXuxb1CczLm-kQ0FUaaSPEcwlsLr9L1gFUdmjctsaDyDg>
    <xmx:s9AiatSoEaiQxwJIDLjzp4xVMegWPQ5UQXM7aeL9Vst0yqyTkKrP3A>
    <xmx:s9AiahdPhb1tKWWG_57IHXbjRJhH6bbERiKFH42OtQjaSz7OoEZYxQ>
    <xmx:s9Aiam3Zz_OY6OnrU-z3FXeMx44yzRAihPGnvnLADD9yX_TAyGAs9s8j>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:35:46 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	maple-tree@lists.infradead.org,	linux-mm@kvack.org,
	linux-media@vger.kernel.org,	dri-devel@lists.freedesktop.org,
	Philipp Stanner <phasta@kernel.org>,	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 0/3] rust: sync: Introduce Rcu*Box
Date: Fri,  5 Jun 2026 06:35:36 -0700
Message-ID: <20260605133541.22569-1-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(this series is based on Alice's RFC [1] and discussion around Philipp's
patches [2], [3])

As an easy way to provide RCU-protected allocation, two major types are
provided:

- `RcuBox<T, A>`, inner T will be dropped and after a grace period.
  Users: binder with maple_tree and dma_fence.
- `RcuFreeBox<T, A>`, inner T will be cleaned up immmediately and freed
  after a grace period. (Name suggestion is welcome). This is an attempt
  to consolidate Alice's `PollCondVarBox` [4] into a generic
  implementation, InPlaceInit support is still missing, but I want to
  get some feedback on the trait `RcuFreeSafe`.


[1]: https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-0-38ebfbcd53f0@google.com/
[2]: https://lore.kernel.org/rust-for-linux/20260530143541.229628-2-phasta@kernel.org/
[3]: https://lore.kernel.org/rust-for-linux/20260520131725.266014-2-phasta@kernel.org/
[4]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com/

Regards,
Boqun

Alice Ryhl (2):
  rust: rcu: Add RcuBox type
  rust: maple_tree: Add load_rcu()

Boqun Feng (1):
  rust: rcu: Introduce RcuFreeBox

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/maple_tree.rs       |  52 ++++++
 rust/kernel/sync/rcu.rs         |  65 ++++++-
 rust/kernel/sync/rcu/rcu_box.rs | 290 ++++++++++++++++++++++++++++++++
 4 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/rcu/rcu_box.rs

-- 
2.51.0

