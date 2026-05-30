Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68682BE033;
	Sat, 30 May 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151859; cv=none; b=QwP8Nh6DwHwcEI0P0Ymwo1gBvKMfI14GYEF7sa4sLJ3JkMYqX6XvjGnPm02SIOCi3WoO237zVLsl/MsmswsQZeOjJMLFEvcXMXKPYJsZdg8VjwMCwkTUdofLKPYlETipcRmfZ6MIW8urxxU6sxCzjqQfzpFkYS1A0VRnH1UQSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151859; c=relaxed/simple;
	bh=4euHBbsz9eB8Goft/Un98U/vCSep1wxIpkjJFv0sH48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lhv9dnokl0bp6GbmFpvaUI2b68U4rv9+4uXLxP/vUHHb9jFdnLZ6TsghcBJRjWunYB8oAUuwrwC3kSET2wYTiO152ReZOWLBLa4jSC4L7eGMynYMa0ZhilBvGatWzTnUMPvsI7tfVxNhjCJo9ornJajruVh/qK/UX54S/EUSXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P695W+rQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P695W+rQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C31F00893;
	Sat, 30 May 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151858;
	bh=Oh702E20bwx/p0BX78CbvBoV0ZkW0mSKteIxLUaDpYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P695W+rQUAycRVtKTMK8ZUb4SRqjKHX3MUQPaWLoXKoi1Fh4ArSVZjLAgERV3InZ6
	 azFgBj9tuRdq+8LLH7SCkgIYl6jT59xVULdW8b5zOFVNr1ql+RMvRTRCm50Z6KChcN
	 LpL/sHozZlMg1O7Ds+qQ+9Io9DBC+ahhBanec3c+RZgUauwgBNQFkO3fo4Cagx41Rm
	 Uk8vp2pTDBqdgelT1YnZDLBWC7xVa99KDyu8Uj82J234Gn0mFp/R7hQynU1DK3bPlX
	 PXfqWdFRo6ef4p0Qv3tXENq/y6iZrogTLXOBuAgOW2py0oh9wchFqhFHCMsEErcqhl
	 nuAKWfPFkUkkw==
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
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Rust dma-buf
Date: Sat, 30 May 2026 16:35:13 +0200
Message-ID: <20260530143541.229628-7-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530143541.229628-2-phasta@kernel.org>
References: <20260530143541.229628-2-phasta@kernel.org>
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
---
Just as a suggestion, I don't want to force myself in here. Would also
be perfectly happy with other approaches; there are certainly a few
people who could maintain or co-maintain it.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e8d160babc2..31fc595d5c6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7521,6 +7521,7 @@ F:	fs/dlm/
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
+M:	Philipp Stanner <phasta@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7529,6 +7530,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/driver-api/dma-buf.rst
 F:	Documentation/userspace-api/dma-buf-alloc-exchange.rst
 F:	drivers/dma-buf/
+F:	rust/kernel/dma_buf/
 F:	include/linux/*fence.h
 F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
-- 
2.54.0

