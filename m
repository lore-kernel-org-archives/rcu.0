Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876070;
	b=Wh3wHzU1Yvm/y2fPVlUP0YCVW6hR3VrB62MZmtwnPLdS3ThlgZ2G8SSn7OVMfWj2q5lT
	 f0qaQJ1k1kIQMjzamS+gT0Ian84b8YkKkCBNy9U5KBy1qUeP8LSf3z9u+T53f+0hW7pZx
	 csdsPD/BO0Up/kNNsPlnjqsguTdIEjHnZm3IG758pGVZGbvDDZhI2CAzlY5J+GQFov42J
	 Feu3btTmxGgXXvVbOrrP867cCAgCvp7RsXdhQ41VhOt5q5OM3i1i65dXpYKZRFofVDbPW
	 YZecohaAfn2OiV+IpOKpbDbP95sFgPuyvJy136O0nXegdkyYoIJA0X2bQ9edXMqviMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n9+cWHs/s6hq8awQiXEdJpxL4GfKRDZ6oL3qwXcRcr8=;
	b=CuC4467yNuadp3FNw0E5iM/DmETdz7ZclQ/G4EpSvs5D2Wx8Xj9HeEcLMPXKRqeHZpoR
	 va8y6MwvZpHUp4vKBu3eZSBXy5q1GMKg7zvoXGPw86ENDZ/Jsrlfe24WQMjNHa5q7H+gx
	 CqIrQGlQLSvGdqTgEZH8yB8b0rbAlUVPdJyv8YgTVc4rGJKYAGUx7wHVgGbYselmzUJed
	 l8GwHdLJvqD9nkqbpqyG8y+NHKc59JIG/S6bQ1MaBKzVXBkWppDERf4blveNjEzXQfJ+5
	 H2/94//WWAKDZp4NsZ3NvcnirK1XvqAjRrrFCJuwjoq1kKAHbtNXRzSFrn3oawR4PFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AEsEeHVH;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED32606A31F
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED32606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AEsEeHVH
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso12667581a12.3
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876068; x=1796480868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9+cWHs/s6hq8awQiXEdJpxL4GfKRDZ6oL3qwXcRcr8=;
        b=AEsEeHVH2TV6b/IBxMQqKx90UR9kT+70HcrARqt0tXWdoe+x1MHU1sCZuIbz3mpnfJ
         YFjVvFEn4mI3+mWvUoL/JJHsZRBXg6MJW9ol6G6Z+086UEEqR3xUsjvyGXS7EvFgzIKi
         oc9wmPFF726vi4kfbam877EYECV8PUy1dCIOKzX7Ghriqf4Z+QZqz8ggb0JEhXaFUwvm
         aJnMTb13RemGGoya/Ua3mBbP8VoEfz5o0wGSh+TfqvvAuooCQNC0Rst4dcfkeOjEAzyQ
         ADDbA8WUXbkiNHVEStm6ByqbsIuccmRRBTy2ctlNdZxWWkCf+S52diZmHsH8gNvKHWnL
         BaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876068; x=1796480868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9+cWHs/s6hq8awQiXEdJpxL4GfKRDZ6oL3qwXcRcr8=;
        b=mXuSwnh+jctRRUS7rL46jkSH8AKWHgaRFzHXuSiGf2WWXSHdLPyuNdzJAcm4P3glOI
         wcIc7sKL+TD97KEh2aHn29kkHUtPzrESU5P0lyBL9DYp34TkSq7xcSVYPm+XDMQLQTLB
         VHa7RbKAH2gUklS7pHh0jhzzS2AyGb6OJaSt71UyC3Dbav1DrrauGaDE5rDQaO2+Ihth
         Nm+vKTtyAK4F75DHkq7zZGRv97rNo7eNxIlknifq2lDoUwqUMaIgUYtOTPGb0CUzzhbc
         oyyF5o2fOC9/u5lXwdLnN+MU4xHaXUtzILlZtobRQH2x2Guotg6NBmFaXZ0JjBExKCTo
         2QQg==
X-Forwarded-Encrypted: i=1; AL+hErG+ubZIIuchY2GL3khpvVjQLbQVgCaua9tDib5Cil+JfqU9xioGnPkW/AFsTM1v+9w/swc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cznos/HWqHXcqCkbZwo7mnpWsIxascXrl404aDbCQ0FGPVmlK
	IhNJd0m6mMT01OjBK4lovW282p0QOIOW8wmygIxqfXj3AAx0xOQqFr88
X-Gm-Gg: AZFdTZfrtcPiJT6/vUHUDrd8N4z3yRiFW5tGK565497MLm2y2qn6/GV7A5HhrnedelR
	8XCV+gUr1L5UiOBCuz0ul2ynEby+gz0SQKOfOfMlSyae+dP90PJyvfXNcrlMsY10sTxkI62bv0c
	ZDyoPgL8JcXVoRq2c+m17prLE0n2H9IrvAe6Iu+oJL0/RLpNe32zDKBDtsrZYofcBd3h0l6Srgk
	A/N//NUouAAb6jbtDS2FQ83QlukI0QvuOxLbgwYVp2YBjGr2+GY8dEiPLhhUDrmFsDDUrtUj4eR
	3voHy9qqXjPAQsEcHmo6hIaoGJ+yfDCKteByuyzGLyOkVsnptb21qDK384jMtAr45dNS2Ounqll
	uVlLPoEcLFIcpsFb+DGoY0gNHTkVD5jqwhy1ffN1eWLXfvkiItQbNnpncrQ1iz7U2UwFfjmG/4z
	hnNMLoq0m3a294VZECoTxJjL0DCPtV7e4l5yfKMkJknthewwZ7snreV288GwhFHzq+6zgwZTLgm
	iwbQbl2MsbRqE746iKySXYGYbjn/o5ahdp8oBgZaa1JbXDEQq+xglh3LpUDGTB3SlMD8xiPedWX
	qbQsQ1ZZ1Y5JHUHRpxX7FTCRE7AA0QOyP7LHxfblqc2S6/l00+ENrahHpITDQ2AAkja5Z+PyI7z
	5SBCsYaweLF0QAsLX
X-Received: by 2002:a05:6402:1d4b:b0:6b1:ef16:1855 with SMTP id 4fb4d7f45d1cf-6ba37e7c734mr18149115a12.18.1795876067830;
        Sat, 28 Nov 2026 06:27:47 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:27:47 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 1/7] rcu-tasks: Record callback enqueue stack
Date: Sat, 28 Nov 2026 22:27:23 +0800
Message-ID: <20261128142729.3756679-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tree RCU records the code path that enqueued a given callback via
kasan_record_aux_stack(), but Tasks RCU does not.  KASAN reports
involving Tasks RCU callbacks therefore lack any hint as to which
code path did the enqueueing.  This commit therefore invokes
kasan_record_aux_stack() in call_rcu_tasks_generic(), covering both
call_rcu_tasks() and call_rcu_tasks_rude().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c1e456e08e668..ab05131a12b18 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/ratelimit.h>
 #include "rcu_segcblist.h"
@@ -364,6 +365,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (debug_rcu_head_queue(rhp)) {
 		if (__ratelimit(&rcu_tasks_dup_rs)) {
 			pr_err("%s(): Duplicate CB for %s, %p->%pS()\n",
-- 
2.43.0

