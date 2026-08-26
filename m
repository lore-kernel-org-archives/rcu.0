Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19B356772;
	Wed, 26 Aug 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731105; cv=none; b=jG814BLRzVYzXKi7z+wSQgew63banR7bN4abrKfmdNRiEZm1qXUrq5ZdNt2jeADvN33CL0Wz6TdRoJsbexyfq9t7nrJ6tY1wWen/kLP+Nuh2cm8Ide28LMmrx3nDedB28ndlhXRPHi/xO8UWSeV7MQV2KocwFcHgHKj2bYDWUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731105; c=relaxed/simple;
	bh=H/NiG2ZAT867eBZQbPGG2vqwqxJVVzWtfuBajJju73U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZisuyPt5T1HoIleQ+H+DdhvnBAY2wqeIGuENImW5w/a/PPQZj1ztd9iymJEeN/zNcDUR04GWnDURpCOqm6G8odsFcbD/uC5znEHAmQyaoWzsiaSX9doJxM0UsBWz63OV88SS36IqD/Q9EUQrxuTkYEgjxjIUF2Yii9oNooEEbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BXbNQZlj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BXbNQZlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ry
	PvxdGRgH5h0qjgqPGLBcGenj7IQqwTD2ysSpkPQlk=; b=BXbNQZljB8Hq81dl3+
	UBzBkBQnQX08q87b14sr5fY0xXz8yjx4VpKKl4gZiQm2K8kxvnc3Pp3hziGWoKoF
	yUH/iOd1xKg8KTpPFMA5/kLvTmou9fhdI8aymZTgklG63QrNLLGA9aj5sEtKxRQ6
	iBgmwP3wt3bx04XNW4IrhOw5s=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnK8hnnI5qiaqVRQ--.33731S2;
	Wed, 26 Aug 2026 15:57:28 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: vbabka@kernel.org,
	harry@kernel.org,
	akpm@linux-foundation.org
Cc: hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	xialonglong@kylinos.cn
Subject: [PATCH v2] mm/slab_common: fix shrink budget underflow in kfree_rcu_shrink_scan
Date: Wed, 26 Aug 2026 15:56:53 +0800
Message-ID: <20260826075653.3304251-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnK8hnnI5qiaqVRQ--.33731S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18JF4rKr4xGF43tw47urg_yoW8Zw17pF
	Wjk34UKr4xJrWkuwnrGa48XFWay39YyFWxKrZrCr43Kwn0q3WrJryIyr4j9rW5KryxXaya
	vr9Ig3WUXFyjya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUIDcUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC+Al-eGqOnGlJDwAA3h

From: Longlong Xia <xialonglong@kylinos.cn>

The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
and then tested the result with <= 0. When a single CPU's object
count exceeds the remaining budget, the subtraction wraps to a large
positive value and the <= 0 comparison, which is equivalent to == 0
for an unsigned type, never fires again. The scan loop then iterates
through every possible CPU instead of honouring the reclaim budget.

Accumulate into freed and stop once freed >= nr_to_scan. The shrinker
core treats nr_to_scan as input-only, so dropping the decrement is
safe; freed becomes unsigned long to match the return type.

Suggested-by: Hao Li <hao.li@linux.dev>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
Changes in v2:
- Rework per suggestion from Hao Li: accumulate into freed directly,
  compare freed >= nr_to_scan instead of decrementing nr_to_scan, and
  drop the per-CPU count local; promote freed to unsigned long.

Link: https://lore.kernel.org/all/20260824091838.1692153-1-xialonglong2025@163.com/
---
 mm/slab_common.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 657fd75776ea..e227c2ef2a4e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2162,20 +2162,17 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	int cpu, freed = 0;
+	int cpu;
+	unsigned long freed = 0;
 
 	for_each_possible_cpu(cpu) {
-		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		count = krc_count(krcp);
-		count += drain_page_cache(krcp);
+		freed += krc_count(krcp);
+		freed += drain_page_cache(krcp);
 		kfree_rcu_monitor(&krcp->monitor_work.work);
 
-		sc->nr_to_scan -= count;
-		freed += count;
-
-		if (sc->nr_to_scan <= 0)
+		if (freed >= sc->nr_to_scan)
 			break;
 	}
 
-- 
2.43.0

