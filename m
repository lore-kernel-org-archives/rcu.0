Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA23378D9E
	for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330635; cv=none; b=Aw2yz+zYNvmS4m3p9W9dUTioSPBhb1TnuQ+whhhhyDpjlNWgpmJcYVuQQ7+xpzD3X2mg6lvyVFl5Wb+8CxYpECZN23JdbZ0qH36RlwvYqT+mmn5KLtBxoI98MUaPrHzaPCMC9yPMRQ1pBRlaiHOIJpUrX0Em4loPnCMBV1xz+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330635; c=relaxed/simple;
	bh=FbfsKh65NpkUNC5s76FTA/U0ULodFRvJ0QEyCbw2wT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH5ixfHknWzLuAVv+bp57vVFlGTWhOIgiKQUMW+rPAXKNdL36PLPjewVJMALJa4Z/GWHUWneAdzfwZ65py6T7DcI7uFRp3JPQDUVZdN1uHmGka0FIGoOfNmK43oENWgsv4Q1Qa2LIl/NcD3vEXWX2tPLRlloUwTaKQ43Kr0xzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/9v/hAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/9v/hAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB48C2BCB9;
	Thu, 16 Apr 2026 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776330634;
	bh=FbfsKh65NpkUNC5s76FTA/U0ULodFRvJ0QEyCbw2wT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/9v/hAVivpxbOOVVZ1g0Qn0EgFbx17lYu2siYtiroVkoHu8cHgHh5fPt4GcUKFjN
	 TioMsCrJ7V4ygW/z0e60zQrBCVXU6ipFREYWCK4A11Zyg1cBAIk9yrNQgy5KU5g9dO
	 0rOKY0R7QUbp7YoawRK43fruKeHvG3ZwQd981T6nPjN3N1lefD4j67n947jawb5+fi
	 YBrhhc8R+qwSWshHs/cBSiDIbNLz9q9UNc26jxP9YzUGHdC0RjfGQy1uLQbqkSyaXN
	 UsWBrN+r1F+FXDRTEWjeiBTPZw4az3F7g+l0uHAOjJbA/bMWg5Q00E7Cc6Hu/sFcaU
	 iud6Xyg1AMP6g==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] fs/dcache: use rcu_ptr instead of rcu_head for external names
Date: Thu, 16 Apr 2026 18:10:16 +0900
Message-ID: <20260416091022.36823-3-harry@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091022.36823-1-harry@kernel.org>
References: <20260416091022.36823-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file name length exceeds 31 (DCACHE_INLINE_LEN-1),
struct external_name is dynamically allocated. Because only kfree_rcu()
is used to free the objects, struct rcu_ptr is enough and saves a pointer
per object.

Under the author's home directory, there are 230k unique file names that
are longer than 31. Some memory saving benefit is expected.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 fs/dcache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..fa37e3964b38 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -325,12 +325,12 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 /*
  * long names are allocated separately from dentry and never modified.
  * Refcounted, freeing is RCU-delayed.  See take_dentry_name_snapshot()
- * for the reason why ->count and ->head can't be combined into a union.
+ * for the reason why ->count and ->rcu can't be combined into a union.
  * dentry_string_cmp() relies upon ->name[] being word-aligned.
  */
 struct external_name {
 	atomic_t count;
-	struct rcu_head head;
+	struct rcu_ptr rcu;
 	unsigned char name[] __aligned(sizeof(unsigned long));
 };
 
@@ -393,7 +393,7 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 		struct external_name *p;
 		p = container_of(name->name.name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->count)))
-			kfree_rcu(p, head);
+			kfree_rcu(p, rcu);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -2863,7 +2863,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		dentry->__d_name.hash_len = target->__d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
-		kfree_rcu(old_name, head);
+		kfree_rcu(old_name, rcu);
 }
 
 /*
-- 
2.43.0

