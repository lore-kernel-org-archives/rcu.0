Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC439EB4F;
	Fri, 22 May 2026 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428576; cv=none; b=XEC6vUd6yMrpaz83jWFK7w3qRAbExEYxzS8LOcGrb698brLF3wvm+lJutFet+xm6xT+YBtlw3xBe8pfvvwLvhChrslws1a/y2eGXxT6PPpxqf8CjqoBbx9Nao2l9WFP1XDNw4VlCZ+VdNiKy45/850IBGjiestKZ+/DX/6O9RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428576; c=relaxed/simple;
	bh=OXKg7IoJRXxJABbEWtm/U0WbRH/zsPKFQvYu+ZBgzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2ZJg06UQlYaKyx8fctlbxHvxKBDw8Pc42Csc2SHqiEq0YQ7Yr1cCKsR5QOaO4YQvCezk5id+G5xy3CGgJwdO6NTIsBwK5a6rAhU8gOynSd4sGNAiOG+ntREIhav9cjcyqEDsznxH+spjBMjGuoXd+9kzqGpnqwRIEG5wOOHe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NnAeN398; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NnAeN398"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779428566; x=1779687766;
	bh=/JxKK4le+0Qf2c0FvyVzReRLUsasiZAYNwA0SE2Vp0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NnAeN398wKRYB9Ua3klckuSKVdf9df3GtEYGwikx0/w/YQLN2E+mKtAMGlohahOTb
	 0vreDlnPEYkBk2Ep5OJ3g06obdxmqNMWZW15IyyqlO7CVyonumbssiCTaXoaT1Ee3L
	 u7RTvtccx2JAWuszMZhQp43oiJbFVCCxIxXYzvQMcnms8nkcb+f3j7wQaNKhgGo9Mt
	 Cg0eV6Tyo0UXoNTxZhffH4saXg/68Yr89aI0ruPZjWTh2UPWkjqWXojMjUP07qhV/E
	 FOEsJFAagAf7C0DtaTiF/3C0Bd40lZ+VnA/FjDBBAy2snKvLJxPsRvOblWnwKMwshq
	 Ra5tUiBN4iFXA==
X-Pm-Submission-Id: 4gMDh10dp6z2ScPd
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
Subject: [PATCH v3 3/3] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Fri, 22 May 2026 08:41:52 +0300
Message-ID: <20260522054228.114814-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260522054228.114814-1-work@onurozkan.dev>
References: <20260522054228.114814-1-work@onurozkan.dev>
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

