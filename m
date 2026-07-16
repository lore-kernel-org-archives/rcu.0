Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375723C4F2;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161422; cv=none; b=guityBnMk/KbxcUQyOYbI5oKNkxO/FsAi6cmFy8YyvdAj7trm/Tr5jn/XurE99Wktb81SHaeW0TT2hQnnP6PT/VV5rNkM/S7YhqHZqo4abfDJ+RjlyPG4QrqqeITFY0pP9R8XYsyzvOnry1ATVm80GGAP5YbHaYojxvw7+FF44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161422; c=relaxed/simple;
	bh=Yl88lflJiv8h6fgZKJ4Y2kkrLo395TLzV3PY6LBaolk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eg73Sbib3Uj1fVb50IEAJp5tlxDN/Ozj/gSBqUDtTTVfPU+YyMVRYN+qgNCGYXKA+IAjdloiprtOchB+MIBLyBEC91eUQsw/urlKRxnB9e+rJs7FpLZWaTPqFdlLDK1oGpGEEX9W6CIEcdEyLdld7vpPQQ0WlqS2TCSRnagaS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bozm1C6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bozm1C6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB51F00A3D;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=GwXWaesWDGtEGGBh/9BmcgoD/ocnRp5Yoj+6V8USxfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bozm1C6RZexKjGCQNXxwvyywWXrn2qyUmGY8fsTqNAKXha/bzbfTxR5Dj0exjpt2L
	 uNjIOjIQtVTNoCasT0uTBDjRB6Ux1yhHTInZ7yoVm3rB0nGhnFRZE+f2yBWSNLHiwu
	 f8gEAERTEF/pSqHXYqN4A9SfQG+XAobGrOji/95WKyxpucEoXXzvKKLaczIJ8VTMAR
	 Gy74+xA2IE4nbgXf8L55uzDsWnB97BRw9SuRzIeO68wolwaeP9eVRf2JHkJW6gji5C
	 SLf+zlB+7QPpyzu6Zm0WgzMqoodMRnuC2cq58rhahZT5llcXYj7XYdzj0TltEOLe9E
	 hey5rT8GcJaQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED778CE0B8B; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 03/10] rcu: Mark __rcu_access_pointer() as context_unsafe()
Date: Wed, 15 Jul 2026 17:23:32 -0700
Message-Id: <20260716002339.11717-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple comparison of a pointer returned by rcu_access_pointer() results
in a context-analysis warning for lockless inspection of the RCU-protected
(also known as __rcu-protected) pointer.  This can be suppressed by
placing context_unsafe() calls around calls rcu_access_pointer(),
but this is messy and distracting.  This commit therefore wraps the
underlying __rcu_access_pointer() macro with a call to context_unsafe(),
thereby informing the context-analysis code that rcu_access_pointer()
may safely be invoked outside of an RCU read-side critical section.

Reported-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e95acc33989b6..e40dc2e20c5b1f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -490,12 +490,12 @@ context_unsafe(								\
  */
 #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, local, space) \
+#define __rcu_access_pointer(p, local, space) context_unsafe( \
 ({ \
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(local)); \
-})
+}) )
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-- 
2.40.1

