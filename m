Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8B4A04
	for <rcu@vger.kernel.org>; Sun,  2 Feb 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482617; cv=none; b=Xm6x1hgLApCSaMo+43MzIwjdkAENYyMjhsR5SAujK6cJAXEMAbFFaJe/M86xt4LVeGPl73TeolQxKvVF1t2NZkcIHTEgXYZK0s7zIVLcbQBkd+V0MzIvuWz5om8mofM42Mkoe7/OzKPANZRE6G7aW5K6UCWC2d6rAUpJtssOj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482617; c=relaxed/simple;
	bh=ARoDWwW98f9Qqj1Z/6pNaVICFhd0AJ487nZVCYeZmfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAyd995Ni6bMlI5eNJWc5BqWSSX9gLX7lNTecIertujm81LCcTixtqPFGBzr4XKzxvn5hb3sRML19eNWWvAPLQfrsessZGspL+0B2rfzv94XUH7CRc1oy+ua5MPRg5t5JytK68nrWYUIEthXWpYrNCeKTpNe4KYe4zIoMLKOJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=T10ddF7k; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="T10ddF7k"
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id C534F1C242A
	for <rcu@vger.kernel.org>; Sun,  2 Feb 2025 10:50:14 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482614; x=1739346615; bh=ARoDWwW98f9Qqj1Z/6pNaVICFhd
	0AJ487nZVCYeZmfU=; b=T10ddF7kroUUOwT7h9/y3Gh+ykC/p8h2keUjM9NddWQ
	ylmhIFBcziup8FlowpCA7BLqiL84s6y4C9VXs+bJ6WC1pQpUh36ljmNm3hdxf6Xp
	CS6vWAKXc6DocE2InoFsIxfRFkf9dVv2J4D5fbYRuf7/+/68ZACLYexzPv7tatR8
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2dRmEfvfgvrx for <rcu@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:14 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id CCF2C1C19B7;
	Sun,  2 Feb 2025 10:50:10 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 02/16] bpf: Factor out a common helper free_all()
Date: Sun,  2 Feb 2025 07:46:39 +0000
Message-ID: <20250202074709.932174-3-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

commit aa7881fcfe9d328484265d589bc2785533e33c4d upstream.

Factor out a common helper free_all() to free all normal elements or
per-cpu elements on a lock-less list.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20230606035310.4026145-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6382da64459a..b9bdc9d81b9c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -211,9 +211,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	mem_cgroup_put(memcg);
 }
 
-static void free_one(struct bpf_mem_cache *c, void *obj)
+static void free_one(void *obj, bool percpu)
 {
-	if (c->percpu_size) {
+	if (percpu) {
 		free_percpu(((void **)obj)[1]);
 		kfree(obj);
 		return;
@@ -222,14 +222,19 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_all(struct llist_node *llnode, bool percpu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
 	struct llist_node *pos, *t;
 
 	llist_for_each_safe(pos, t, llnode)
-		free_one(c, pos);
+		free_one(pos, percpu);
+}
+
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+
+	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
@@ -426,7 +431,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	bool percpu = !!c->percpu_size;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -435,14 +440,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
-		free_one(c, llnode);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_llist), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
-- 
2.43.0

