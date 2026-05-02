Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8F3859D2
	for <rcu@vger.kernel.org>; Sat,  2 May 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739339; cv=none; b=EEqvk0ClfpMSiBazkp3dkenb3MJZHDFJv6dMcANLnqmc7sMtEtEqLItxfik1XTZJUpCnACJVpoQe0LUnMX764Vikyg3ClOrobPdliOHOwKsUsZuGmxOsHRu6xghY7AFU9DKwDPGfmrDd5rbDFdROygdLdmS0eyb3QEjQj12bAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739339; c=relaxed/simple;
	bh=aLN/nYG9SOkiA4x4g2eZtGH4x/hIBvc7zj9D1ao0FNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A48bj9HeND384f+vJimxdLvfAYo3LSLoXHBmRkmNdqL6kxoVZjnLBS6uqGVzDSW/u/pl9gDZiLOTaOmxl9rUOZPK1ZqNRZhnmurPmCeAIJ1xwvrGQrCeseNkyedeJnEe/8B0HikTJI4Y5Cch1WNEv3fnvRW2ooWjH1puard1+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=p3MejekB; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="p3MejekB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777739334; x=1777998534;
	bh=H3sh8/9rJHMx1+JJUzxq6tpBVaFRS1rv7nPe7gXi5Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p3MejekBEQ2J5HZUUZe3ZcgPJh4lOZr7N1QrtVxcO5r0cQYYgsxv6p2CWCBZX9zYB
	 22kYKi7H1F2cFpyy12AvGVCkwxxrKDlhyliRmLaPxWqL4ovSvDxQ7FHW5FRkCnTO4+
	 rW/BZiatAcbp7wEOhHDEvwULywPMgBsQzWgFRdOq/JX+8qoic6fVXLsiTppsIU4mkw
	 2bsXTAF1B8OaJnIq3KjI2brwpOMQQu1C094fOP9ozv+lLwW0EZl8E3TAwdt30MAiLG
	 letvXOx3UWr3VEQzNYngGgY2/EApPjV9k8ixVNmhBeo5DPEvfKBGeli4kZM+w5B1Yl
	 KvnThupVVtOcg==
X-Pm-Submission-Id: 4g7Cyn6YBfz1DFFm
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
Subject: [PATCH v2 3/3] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Sat,  2 May 2026 19:27:39 +0300
Message-ID: <20260502162833.34334-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260502162833.34334-1-work@onurozkan.dev>
References: <20260502162833.34334-1-work@onurozkan.dev>
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

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c93fa23654c..8c1588e2f6fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24405,6 +24405,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
@@ -24413,6 +24414,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.51.2

