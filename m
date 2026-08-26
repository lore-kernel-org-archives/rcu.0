Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE137F8A4;
	Wed, 26 Aug 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732620; cv=none; b=bUfux0E/AHNg4ISWeOToSw/3XXRYqZRD+em/orpDB9Xt21+4iBzNTE9v3Em62ZePtn0bQhak0UyprtdkcPFhHtQ8ICXv8mez7UP0u0R3Gx9CJs5JsLXBHYkOOHeZyGjtK4nj53haJEzP7rUIO3WU6CyI7otzlCv+TFOl54bPjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732620; c=relaxed/simple;
	bh=XMSNlUFg45l39BM9FP72hKoIqvxzXHeGAhyVGgaMEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yz5yE9gtKPICH9iIGC+mw/hlBd5p8/XMMz8tIRKN9lKmU+4c7UZPnyX0rnVZvtRSpqOoCTn7wnuSzY/kLoyZ51J1WAGLdSSYoaCNalulO8gt9W96FKNL91AnyfNT9m2HxOwg1mYiNP0Pp18F5SZmF+qyKC/KwS3WwLHXbB2cyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d0ky79c5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d0ky79c5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3X
	BgLlzKd81D6QA9F67J7ZWT0nav2O3LxUSa7YUKIbI=; b=d0ky79c542Dx1eSYJZ
	G1LGrnw2t0TQ7SGpXa/qD3Y3cfUmqCPDB1ymDM9iEurI5rfDQu1x4wbzfmP5lCdg
	2QYUjaMCpTXr3tQvtGnK3HRwxwH7b8IzYy5hTaRBq0czdyYAsskCywzqRaBmsKVX
	uqjum/sqb15OEBoWZMSYOe5H4=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnfhpOoo5qtxJFOQ--.25262S2;
	Wed, 26 Aug 2026 16:22:40 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: paulmck@kernel.org,
	frederic@kernel.org
Cc: neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	vineeth@bitbyteword.org,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xialonglong@kylinos.cn
Subject: [PATCH v2] rcu: fix shrink budget underflow in lazy_rcu_shrink_scan
Date: Wed, 26 Aug 2026 16:21:50 +0800
Message-ID: <20260826082150.3311391-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnfhpOoo5qtxJFOQ--.25262S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1UWr1fZF4kuFy8Aw4xJFb_yoW8Wr1rpF
	WjkFyUKrWfXr48XF9Fq3W8uFZxZ395CrWfKFZY9w1fJwn093Zaq34qyFyagw4Yqa1IyF1F
	vr12gryj93Wvy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uu5lnUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3BH682qOolEOzwAA3S

From: Longlong Xia <xialonglong@kylinos.cn>

The lazy RCU shrinker decremented sc->nr_to_scan (unsigned long)
and then tested the result with <= 0.  When a single CPU's lazy
callback count exceeds the remaining budget, the subtraction wraps
to a large positive value and the <= 0 comparison, which is
equivalent to == 0 for an unsigned type, never fires again.  The
scan loop then iterates through every nocb CPU instead of honouring
the reclaim budget.

Accumulate into count and stop once count >= nr_to_scan.

Fixes: c945b4da7a448 ("rcu: Shrinker for lazy rcu")
Assisted-by: Zcode:GLM-5.2
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
Changes in v2:
- Rework to accumulate into count directly and compare count >= nr_to_scan
  instead of decrementing nr_to_scan, matching the kfree_rcu_shrink_scan()
  fix reworked per Hao Li's suggestion.

Link: https://lore.kernel.org/all/20260824133142.2293426-1-xialonglong2025@163.com/
---
 kernel/rcu/tree_nocb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 19bb42672baf..b6cfee4e5039 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1332,9 +1332,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp);
-		sc->nr_to_scan -= _count;
 		count += _count;
-		if (sc->nr_to_scan <= 0)
+		if (count >= sc->nr_to_scan)
 			break;
 	}
 
-- 
2.43.0

