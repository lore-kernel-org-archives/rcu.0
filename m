Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266724397F
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222031; cv=none; b=bflnQve2aYIruF5gMAp67qqTseVWiY3i3e5fU/2NKlbkNpXre7k2n+MRN7gN8y3KTjD7xnOw58djLS8RViQotleZtB6dlC0/uaKcLl5eNOGC1fHfW4ojVzCSWuMGmiutu727ltW49AgJd8Rj8HxB/CkQ2L/ujazPR2Rz6R80QPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222031; c=relaxed/simple;
	bh=50tQcubCUH+CBgUwKBIh63YGi3Os5DtzMxCkiADJQNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WF+9EnQ2jhYyW9ePNU9pkbTk59NniO6OyYESOxUM6buXtnCjMNk+IfFd/fpWr1fOveo0+5Ns2mDH7DwHUfdxGOfHJKTrHcxJkxi3okOq67ZuU0W4dOMWBaQewYFjjdr1VmQ5mAPn3+cUUWL/LGOwu6jTakovXUNAz1+LunqkJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10A1821AF7;
	Mon, 17 Mar 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F040A13A5D;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eK1jOr0y2GcycQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 14:33:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 17 Mar 2025 15:33:06 +0100
Subject: [PATCH RFC v3 5/8] slab: determine barn status racily outside of
 lock
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-slub-percpu-caches-v3-5-9d9884d8b643@suse.cz>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 10A1821AF7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The possibility of many barn operations is determined by the current
number of full or empty sheaves. Taking the barn->lock just to find out
that e.g. there are no empty sheaves results in unnecessary overhead and
lock contention. Thus perform these checks outside of the lock with a
data_race() annotated variable read and fail quickly without taking the
lock.

Checks for sheaf availability that racily succeed have to be obviously
repeated under the lock for correctness, but we can skip repeating
checks if there are too many sheaves on the given list as the limits
don't need to be strict.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ab3532d5f41045d8268b12ad774541dcd066c4c4..2c7b2a85c628d01fa4811dd6cd3e4fd198d80381 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2698,9 +2698,12 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *empty = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_empty) {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty,
 					 struct slab_sheaf, barn_list);
 		list_del(&empty->barn_list);
@@ -2716,38 +2719,36 @@ static int barn_put_empty_sheaf(struct node_barn *barn,
 				struct slab_sheaf *sheaf, bool ignore_limit)
 {
 	unsigned long flags;
-	int ret = 0;
+
+	/* we don't repeat the check under barn->lock as it's not critical */
+	if (!ignore_limit && data_race(barn->nr_empty) >= MAX_EMPTY_SHEAVES)
+		return -E2BIG;
 
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (!ignore_limit && barn->nr_empty >= MAX_EMPTY_SHEAVES) {
-		ret = -E2BIG;
-	} else {
-		list_add(&sheaf->barn_list, &barn->sheaves_empty);
-		barn->nr_empty++;
-	}
+	list_add(&sheaf->barn_list, &barn->sheaves_empty);
+	barn->nr_empty++;
 
 	spin_unlock_irqrestore(&barn->lock, flags);
-	return ret;
+	return 0;
 }
 
 static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
 			       bool ignore_limit)
 {
 	unsigned long flags;
-	int ret = 0;
+
+	/* we don't repeat the check under barn->lock as it's not critical */
+	if (!ignore_limit && data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
+		return -E2BIG;
 
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (!ignore_limit && barn->nr_full >= MAX_FULL_SHEAVES) {
-		ret = -E2BIG;
-	} else {
-		list_add(&sheaf->barn_list, &barn->sheaves_full);
-		barn->nr_full++;
-	}
+	list_add(&sheaf->barn_list, &barn->sheaves_full);
+	barn->nr_full++;
 
 	spin_unlock_irqrestore(&barn->lock, flags);
-	return ret;
+	return 0;
 }
 
 static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
@@ -2755,6 +2756,9 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *sheaf = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full) && !data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
 	if (barn->nr_full) {
@@ -2785,9 +2789,12 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
 	struct slab_sheaf *full = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full) {
+	if (likely(barn->nr_full)) {
 		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
 					barn_list);
 		list_del(&full->barn_list);
@@ -2810,19 +2817,23 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
 	struct slab_sheaf *empty;
 	unsigned long flags;
 
+	/* we don't repeat this check under barn->lock as it's not critical */
+	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
+		return ERR_PTR(-E2BIG);
+	if (!data_race(barn->nr_empty))
+		return ERR_PTR(-ENOMEM);
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full >= MAX_FULL_SHEAVES) {
-		empty = ERR_PTR(-E2BIG);
-	} else if (!barn->nr_empty) {
-		empty = ERR_PTR(-ENOMEM);
-	} else {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
 					 barn_list);
 		list_del(&empty->barn_list);
 		list_add(&full->barn_list, &barn->sheaves_full);
 		barn->nr_empty--;
 		barn->nr_full++;
+	} else {
+		empty = ERR_PTR(-ENOMEM);
 	}
 
 	spin_unlock_irqrestore(&barn->lock, flags);

-- 
2.48.1

