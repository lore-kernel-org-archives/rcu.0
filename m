Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825833C198;
	Fri, 29 May 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062035; cv=none; b=b4v4V/amNUs6YaDtdUvsmBYeBCGvQM8ZZjBo7Nj5psDvxAY44MI4dz4tY14NCSZuSYKD7WH6FUEcZuE81x+1GRuFnhK+bAclFrSKHzZMNnQiDHp0z82hmpYRp+hy+x4p5DvnkkG8uavtvcGjmWKVHfZPTtc3JtfinUJp2plKQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062035; c=relaxed/simple;
	bh=iNIea3X1u5UlLSCKpcd9EjyAvSlc5TEnDXzmsvHUUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDhDV+ecuFLV36nT15QMz7s3qayGe0xFEpjoUtZCxY/hPLH/ZkGqJZhJr3PDOpp4UaCqUQK9tVUC4+l0lsdhXmvmkYUYT+qrHeFXOdy7W9FCbZiNc8O+WjaEyiImcbT/3ENAMCwE6noRIYD6BuakfaT+IGELkCNMVbNGDdIHNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=C1VSkMtK; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="C1VSkMtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780062022; x=1780321222;
	bh=JkD+A35aA68GLUHdDWX6WjTBKf+CG0Z+zqkNuKRO2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=C1VSkMtKslNINulm98AOcEJ1KLPrK2oVRaXeceQ6vrdPPpi3OtGGpbqsUoBXGsaD7
	 ZV2Rm3iAe7OEASoWw1threTvfNa5agWU8ZpU8lFKHRttLlgi0xaDdSvb7QJuPU2Zr4
	 Xjkn3p0TwvSG1cmJ04n5WAAOFqfOLBKx9loBeREnMPaGhLUgeCfrP+ocorPUTJV6YT
	 etOBZ9bRaUs8xsPpCaXyQCuML74v7Scwc8XN7gYTslMHENUAb897bKKKJZA8Ktigbb
	 Kr/BCQk2PqIJhTLpqvZzyvO07Hr2GNEjSPBnyuSmjz/WARjsr19dJ7lM/X4bgIKvoj
	 zB8CbsEvKYFDw==
X-Pm-Submission-Id: 4gRkxw0vfhz1DDKv
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v9 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Fri, 29 May 2026 16:39:54 +0300
Message-ID: <20260529134004.396743-5-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260529134004.396743-1-work@onurozkan.dev>
References: <20260529134004.396743-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include Rust side implementation files to the SRCU maintainer
entry.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0b307b2108c..7739a435f258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
@@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.51.2

