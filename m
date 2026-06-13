Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A002388862
	for <rcu@vger.kernel.org>; Sat, 13 Jun 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333668; cv=none; b=l4SDXTpkopiiypZz3OwTMPMUWGDrajwGaI9o5Qpfbier/OmvaWyfWmL0nR7dtoMemSorDm+s6o8HvdgCqgL/IgNhnyJYhGlF1V4DHHKTNO7Duoq4g9Qk/yE4qHtXZcQ4HC7yEOlQWfGnvaYIWVNEPBOIn56p1Q527kSSkBdretc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333668; c=relaxed/simple;
	bh=iNIea3X1u5UlLSCKpcd9EjyAvSlc5TEnDXzmsvHUUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIEaI4aiin6ZSbm4p1iKvtWmmmoA7MxTtIaUoMCMt/Tr1+SrxNXqHVqHn8w6arMaoY+pLl88g0G1ad4Ps8tRLxNk33nrubt2XOOc5S43yzHGWfCVHGkR7Nd1/lpXK7pz0HO0BXaa1qNioZuNZvkxjUnadclSgIBo23PefIxLyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=XFLwIZiE; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="XFLwIZiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781333656; x=1781592856;
	bh=JkD+A35aA68GLUHdDWX6WjTBKf+CG0Z+zqkNuKRO2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XFLwIZiE3r1oSZIxQS67qHYUAaaOwoH82RU/j46qmZulY9GJ0k3UUn6b/btFz4xad
	 N1wrH2XD12clIBPSzH9lrGM0qGe+X2DkKMQCnpYF8LipEHyYKGCABwf1j5IbL4gCFO
	 gGDI4w7V1b6MCdBYrWqwz3w5UiYkkhpjiIcV3+19B0ae4+L6u7+FQW4FSUeOG7jFqz
	 TfFyCMyVE4UTBiRT2LSJRs7RCurYoUAG7no1Qg3zeuDP767d4ETqkqQiRCcsx8aY6m
	 k8y+2qHZJsMIrZ9wjbQ0SEApS9/Dnwcrxu6dWhlRBl429zjJBzRy0CqHXVOdUhtwby
	 2yi+EqAjpcjnw==
X-Pm-Submission-Id: 4gcnDM2RhPz1DF7c
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
Subject: [PATCH v10 5/5] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Sat, 13 Jun 2026 09:40:11 +0300
Message-ID: <20260613065348.96750-6-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>
References: <20260613065348.96750-1-work@onurozkan.dev>
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

