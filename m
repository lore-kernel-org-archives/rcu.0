Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2042D0C72;
	Mon, 24 Aug 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578444; cv=none; b=rvHbTMMmP5DOvf8l/4CJZjzfC1HjNOPhWN9YCQn5lddOMQaBbgNmaEgnMbRMjwYu1pY6VFHxKDJJuxfktSkWuHeS3xcr8y9d2LT3K+0gEo3HZn881f9+sTCUueQJKWQZKl+Lv5CHeUQgTWgSFxUA2wQ0Jq8m+n49D6+inkWOdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578444; c=relaxed/simple;
	bh=oqCpM8e82MTHbEpCfGzpqBtUymWyg9sVqUEyWSbYK6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBK1OsXWODtbPuONqAByFbMuwp+tVc8R/u8CJ8IshB6jKmnE/K4R4Rvh5zBkI8HvEXijX0NPuvCv0PUZn8RU2FBvz3AEPU2kSN28sxzszfMjEqVrAPvSFsIZgHJrZoyYC/YBiKIrDAOuKbdDaXLEUBseIFPXe0sLzTykWI3kWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YQ+vvoEy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YQ+vvoEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vW
	VriaitYN1KglPbAKhmjDPWKdXy8ZX+UIxHe2PiL0Q=; b=YQ+vvoEyFeEON3RHuu
	8Codx0udyLk4WajSDLk6on/uxZXacVxglAw3AidkvqNMl3iDoW2tmRUKtZoOVxUe
	7XOfbEdpRV1ORt9yh5dHexeHnroPRhhmOnV0bQ2kS8l/Rp8rsY3aGqcALNyfB6Hv
	0dAaF/JZu6gbSQJa0q1RUd/Ac=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBX28e_R4xqJJw4RA--.50069S2;
	Mon, 24 Aug 2026 21:31:46 +0800 (CST)
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
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] rcu: fix shrink budget underflow in lazy_rcu_shrink_scan
Date: Mon, 24 Aug 2026 21:31:42 +0800
Message-ID: <20260824133142.2293426-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX28e_R4xqJJw4RA--.50069S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1UWr1fZrWrAr43XrWUArb_yoW8GFy3pF
	WjkFyUKr4rXF48Xr9rZ3WrZFZ8Zw4rCFW5KFZY9a4fJ3Z8uwnIqa4UAFy2gw45ta1xJF4Y
	9r1jg34j9ayvy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UM5lnUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9wK-uGqMR8IP-QAA3j

From: Longlong Xia <xialonglong@kylinos.cn>

The lazy RCU shrinker decremented sc->nr_to_scan (unsigned long)
and then tested the result with <= 0.  When a single CPU's lazy
callback count exceeds the remaining budget, the subtraction wraps
to a large positive value and the <= 0 comparison, which is
equivalent to == 0 for an unsigned type, never fires again.  The
scan loop then iterates through every nocb CPU instead of honouring
the reclaim budget.

Reorder the logic to compare _count against nr_to_scan before
subtracting, so the loop exits as soon as the budget is met.

Fixes: c945b4da7a448 ("rcu: Shrinker for lazy rcu")
Assisted-by: Zcode:GLM-5.2
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 kernel/rcu/tree_nocb.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 19bb42672baf..afc3ab84cc47 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1332,10 +1332,11 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp);
-		sc->nr_to_scan -= _count;
 		count += _count;
-		if (sc->nr_to_scan <= 0)
+
+		if (_count >= sc->nr_to_scan)
 			break;
+		sc->nr_to_scan -= _count;
 	}
 
 	mutex_unlock(&rcu_state.nocb_mutex);
-- 
2.43.0

