Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AB365A14;
	Mon, 24 Aug 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563237; cv=none; b=JcVMxWyyYNOpd6eVfCjyAPbGHrWyl/fce3S7in4R3Oh2i8eSNxaD03YZSZYYrvRbN7qeBGHySX3/sNSorraVHi3xdBZb1AEEyOO8mOEgm1BBvVlOPmvUNfvQ0fc3HlVzLWrhBYCCKfWQpRU4vTAyzP1OPIuEq2TQP8zPFPgYtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563237; c=relaxed/simple;
	bh=EJR0HZAidY5OceGJ+eu9LmIqoVlPgAuhha4+quau4gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Me4k6aVzQuUNBvsFMIiqjoANZbYcaZKbCaJLFglRC2OYI1rCEn3e/Jit05Z0tF52YddFTw45UdWqEcAFQ5D1I0Evl0rtUTKgU5FiAFEstsNwGUqJbzh+RdQMQ/LAuEFgXWBx+Egz2dEvPLq/b8fPDo2N0Moq4Kx/MCELB5931sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bL+PHrQM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bL+PHrQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qq
	6CTw9aog03XEKs9hMeWAiZoyfqTL2ZWlIAp3UfVfQ=; b=bL+PHrQMD9HvsXVgg5
	g+gdvFry3YQw2ywvp8Mdl8PkXAhC9IIP9Q0LYDe9HOzofOJfgYVZadOHLdqmN/Bt
	DKmMIL+pHoFhtkdYAkntcLbVKYNgV00fl84Q1GvxTdqY2CUIgPAWYomC3QWf406V
	dcGGnaKrvclWOZ5cETz+iWf08=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAnWPeZDIxq17gxMw--.50121S2;
	Mon, 24 Aug 2026 17:19:23 +0800 (CST)
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
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] mm/slab_common: fix shrink budget underflow in kfree_rcu_shrink_scan
Date: Mon, 24 Aug 2026 17:18:38 +0800
Message-ID: <20260824091838.1692153-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAnWPeZDIxq17gxMw--.50121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18JF4rKr4xGF43tw47urg_yoW8JFyxpF
	WjkFyUKr48XF4UZr4kA3W8Xay5X3ySyFZ7GrWqkw43Jwn8Xw1fta4xJry29Fy5Ka48Xaya
	vrnF93WUZa4jkFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3Bvm32qMDJuUSQAA3S

From: Longlong Xia <xialonglong@kylinos.cn>

The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
and then tested the result with <= 0. When a single CPU's object
count exceeds the remaining budget, the subtraction wraps to a large
positive value and the <= 0 comparison, which is equivalent to == 0
for an unsigned type, never fires again. The scan loop then iterates
through every possible CPU instead of honouring the reclaim budget.

Reorder the logic to compare count against nr_to_scan before
subtracting, so the loop exits as soon as the budget is met.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 657fd75776ea..95ddbab290d4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2172,11 +2172,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		count += drain_page_cache(krcp);
 		kfree_rcu_monitor(&krcp->monitor_work.work);
 
-		sc->nr_to_scan -= count;
 		freed += count;
 
-		if (sc->nr_to_scan <= 0)
+		if (count >= sc->nr_to_scan)
 			break;
+		sc->nr_to_scan -= count;
 	}
 
 	return freed == 0 ? SHRINK_STOP : freed;
-- 
2.43.0

